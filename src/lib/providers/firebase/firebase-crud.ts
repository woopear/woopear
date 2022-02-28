import { store_notification } from '$lib/modules/notification/store/notification.store';
import { addDoc, arrayUnion, collection, deleteDoc, doc, updateDoc } from 'firebase/firestore';
import { fire_db, fire_storage } from './firebase.service';
import { constEnumNotificationType } from '$lib/modules/notification/notification.const';
import { deleteObject, getDownloadURL, ref, uploadBytes } from 'firebase/storage';
import type { IMessageNotif } from '$lib/modules/notification/notification.type';

export function fcrud(collectionBase: string, message: IMessageNotif) {
  /**
   * affiche la notif succes
   * @param message le message succes
   */
  function activeDesactiveNotif(message: string): void {
    // si message alors notification
    message !== ''
      ? store_notification.addNewNotificationUser(constEnumNotificationType.SUCCESS, message)
      : null;
  }

  /**
   * affiche la notif error
   * @param message le message error
   */
  function notifError(message: string): void {
    // error pour interface
    store_notification.addNewNotificationUser(constEnumNotificationType.ERROR, message);
  }

  /**
   * affiche la notif Warning
   * @param message le message Warning
   */
  function notifWarning(message: string): void {
    // error pour interface
    store_notification.addNewNotificationUser(constEnumNotificationType.WARNING, message);
  }

  /**
   * affiche la notif Warning
   * @param message le message Warning
   */
  function notifInfo(message: string): void {
    // error pour interface
    store_notification.addNewNotificationUser(constEnumNotificationType.INFO, message);
  }

  return {
    /**
     * ajoute document dans collection
     * @param data les données pour creer le document
     * @param pathCollection le path pour atteindre une collection enfant d'un document optionnel
     */
    add: async function (data: any, pathCollection?: string): Promise<void> {
      try {
        // ajoute document dans collection avec ou sans pathCollection
        pathCollection
          ? await addDoc(collection(fire_db, collectionBase, pathCollection), { ...data })
          : await addDoc(collection(fire_db, collectionBase), { ...data });
        activeDesactiveNotif(message.succes);
      } catch (error) {
        notifError(message.error);
        // error pour dev
        throw new Error(error);
      }
    },

    /**
     * modification d'un document
     * @param data les données pour creation, doit correspondre à votre model
     * @param pathCollection le path pour atteindre une collection enfant d'un document optionnel
     */
    update: async function (data: any, pathCollection: string): Promise<void> {
      try {
        // modification d'un document
        await updateDoc(doc(fire_db, collectionBase, pathCollection), { ...data });
        activeDesactiveNotif(message.succes);
      } catch (error) {
        notifError(message.error);
        // error pour dev
        throw new Error(error);
      }
    },

    /**
     * telecharge un fichier
     * @param refPathImage ref de l'image dossierimage/nomimage
     * @param pathCollection le path de la collection / document ciblé
     * @param file le fichier
     */
    uploadImage: async function (
      refPathImage: string,
      pathCollection: string,
      file,
      tab = true
    ): Promise<void> {
      try {
        // ciblage ou/et creation du nom de fichier
        const i = ref(fire_storage, `${refPathImage}`);
        // enregistrement de l'image dans le dossier donné en réf
        await uploadBytes(i, file);
        // creation de l'url pour stocker dans le document
        const url_img = await getDownloadURL(i);
        tab
          ? await this.update({ image: url_img }, pathCollection)
          : await this.update({ images: arrayUnion(url_img) }, pathCollection);
      } catch (error) {
        notifError(message.error);
        // error pour dev
        throw new Error(error);
      }
    },

    /**
     * suppression d'une image et update d'un document
     * @param refPathImage la ref de l'image
     * @param pathCollection le path de la collection en rapport avec l'image
     * @param data les données à modifié pour le document de la collection en rapport avec l'image
     */
    deleteImage: async function (
      refPathImage: string,
      pathCollection?: string,
      data?: any
    ): Promise<void> {
      try {
        // suppression de l'image
        await deleteObject(ref(fire_storage, refPathImage));
        // modification du document apres suppression de l'image (si collectionBase est renseigné)
        collectionBase && pathCollection && data
          ? await this.update(data, pathCollection)
          : activeDesactiveNotif(message.succes);
      } catch (error) {
        notifError(message.error);
        // error pour dev
        throw new Error(error);
      }
    },

    /**
     * suppression d'un document et de l'image si il y a le refPathImage renseigné
     * @param pathCollection le path de la collection
     * @param refPathImage la ref de l'image si il y a une image à supprimer si pas renseigner init à null
     */
    delete: async function (pathCollection: string, refPathImage = null): Promise<void> {
      try {
        // si image path on supprime l'image
        refPathImage ? await this.deleteImage(refPathImage, message) : null;
        // suppression du document
        await deleteDoc(doc(fire_db, collectionBase, pathCollection));
        activeDesactiveNotif(message.succes);
      } catch (error) {
        notifError(message.error);
        // error pour dev
        throw new Error(error);
      }
    }
  };
}

// class pour creation message notif
export class MessageNotif {
  constructor(succes: string, error: string) {
    this.succes = succes;
    this.error = error;
  }

  private succes: string;
  private error: string;

  get() {
    return {
      succes: this.succes,
      error: this.error
    };
  }
}
