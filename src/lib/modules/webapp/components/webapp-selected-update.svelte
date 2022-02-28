<script lang="ts">
  import BoxCardEntities from '$lib/modules/components/boxs/box-card-entities.svelte';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import BoxCardEntitesHead from '$lib/modules/components/boxs/box-card-entities-head.svelte';
  import BoxCardEntitiesBody from '$lib/modules/components/boxs/box-card-entities-body.svelte';
  import { createEventDispatcher } from 'svelte';
  import { webapp_selected_store } from '../store/webapp-selected.store';
  import Input from '$lib/modules/components/input/input.svelte';
  import BoxCardEntitiesBoxBtnForm from '$lib/modules/components/boxs/box-card-entities-box-btn-form.svelte';
  import ImgEmptySvg from '$lib/modules/components/img-empty-svg/img-empty-svg.svelte';
  import { createObjectAsFormData } from '$lib/providers/format/format.service';
  import { webapp_product_store } from '../store/webapp-products.store';
  import BoxContentBody from '$lib/modules/components/boxs/box-content-body.svelte';
  import BoxContentHeader from '$lib/modules/components/boxs/box-content-header.svelte';
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';
  import BtnAdd from '$lib/modules/components/btn/btn-add.svelte';
  import BtnDelete from '$lib/modules/components/btn/btn-delete.svelte';
  import Texarea from '$lib/modules/components/textarea/texarea.svelte';
  import type { IProduct } from '../webapp.type';

  let loader_save_webapp_selected = '';
  let loader_sup_img_webapp = '';
  let loader_img_webapp = '';
  let loader_save_condition_gen_selected = '';
  let img;
  let img_product;
  let value_input_file_webapp_selected;

  // creation event dispatch
  const dist = createEventDispatcher();

  /**
   * fermeture du volet de modification de la presentation
   */
  function closeUpdate(): void {
    dist('close_update', false);
  }

  /**
   * load file image dans la variable img
   * @param e event onChange input file
   */
  function loadImageWebappSelected(e): void {
    img = e.target.files[0];
  }

  /**
   * ajout de l'image au web app selected
   * @param idWebappSelected id de la webapp selected
   */
  async function uploadImg(idWebappSelected: string): Promise<void> {
    loader_img_webapp = 'loading';
    await webapp_selected_store.uploadImageWebappSelected(img, idWebappSelected);
    loader_img_webapp = '';
  }

  /**
   * suppression de l'image au web app selected
   * @param idWebappSelected id de la webapp selected
   */
  async function deleteImage(idWebappSelected: string): Promise<void> {
    loader_sup_img_webapp = 'loading';
    await webapp_selected_store.deleteImageWebappSelected(idWebappSelected);
    loader_sup_img_webapp = '';
  }

  /**
   * modification du webapp selected
   */
  async function updatewebappSelected(e, idWebappSelected: string): Promise<void> {
    loader_save_webapp_selected = 'loading';
    const data = createObjectAsFormData(e.target);
    await webapp_selected_store.updateWebappSelected(idWebappSelected, data);
    loader_save_webapp_selected = '';
  }

  /**
   * ajout d'un product au webapp selected
   */
  async function addProductWebappSelected(): Promise<void> {
    await webapp_product_store.addNewWebappProduct($webapp_selected_store.id);
  }

  /**
   * modification des données de product
   * @param e
   * @param idWebappProduct
   */
  async function updateWebappProduct(e, idWebappProduct: string): Promise<void> {
    const data = createObjectAsFormData<IProduct>(e.target);
    data.technos = data.listtechnos.split(',');
    delete data.listtechnos;
    await webapp_product_store.updateWebappProduct(
      data,
      idWebappProduct,
      $webapp_selected_store.id
    );
  }

  /**
   * supprimer un product
   * @param idWebappProduct
   */
  async function deleteProductsWebappSelect(idWebappProduct: string): Promise<void> {
    await webapp_product_store.deleteWebappProduct(idWebappProduct, $webapp_selected_store.id);
  }

  /**
   * load image product
   * @param e event onChange input file
   */
  function loadImageProduct(e): void {
    img_product = e.target.files[0];
  }

  /**
   * upload image product
   * @param idWebappSelectedProduct id du webapp selected product
   */
  async function uploadImgProduct(idWebappSelectedProduct: string): Promise<void> {
    loader_img_webapp = 'loading';
    await webapp_product_store.uploadImageWebappProduct(
      img_product,
      $webapp_selected_store.id,
      idWebappSelectedProduct
    );
    loader_img_webapp = '';
  }

  /**
   * suppression d'une des images du product
   * @param urlForDelete
   * @param idWebappProduct
   * @param index
   */
  async function deleteImageProduct(urlForDelete: string, idWebappProduct: string): Promise<void> {
    await webapp_product_store.deleteImageWebappProduct(
      urlForDelete,
      $webapp_selected_store.id,
      idWebappProduct
    );
  }
</script>

{#if 'id' in $webapp_selected_store}
  <BoxCardEntities>
    <!-- en-tete -->
    <BoxCardEntitesHead>
      <Title slot="title-1" title="Modification de" type_title={ETypeTitle.H4} />
      <span slot="title-2" class="md:ml-4">{$webapp_selected_store.title}</span>
      <BtnCloseUpdate
        slot="btn-close-update"
        changeUpdate={closeUpdate}
        relief={true}
        size="w-4 h-4"
      />
    </BoxCardEntitesHead>

    <!-- modification ajout d'une image -->
    <section class="flex flex-col items-center justify-center mb-24 mt-12">
      <div class="flex flex-col items-center">
        <!-- si pas d'image on affiche svg de remplacement -->
        {#if $webapp_selected_store.image !== ''}
          <img class="w-56 h-44 mt-8 mb-2" src={`${$webapp_selected_store.image}`} alt="webapp" />
        {:else}
          <ImgEmptySvg />
        {/if}
        <p class="text-center font-bold mt-4">Modifier l'image</p>
      </div>
      <!-- input file -->
      <div class="flex justify-center my-6">
        <div class="w-96">
          <input
            class="img-webapp-selected form-control
          block
          w-8/12
          sm:w-10/12
          m-auto
          px-2
          py-1
          text-sm
          font-normal
          text-gray-700
          bg-white bg-clip-padding
          border border-solid border-gray-300
          rounded
          transition
          ease-in-out
          focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
            id="formFileSm"
            type="file"
            on:change={loadImageWebappSelected}
          />
        </div>
      </div>
      <!-- btn envoie ou suppression img -->
      <div class="flex">
        <button
          class={`${loader_sup_img_webapp} btn btn-xs btn-secondary mr-4`}
          on:click={() => deleteImage($webapp_selected_store.id)}>Supprimer l'image</button
        >
        <button
          class={`${loader_img_webapp} btn btn-xs btn-primary`}
          on:click={() => uploadImg($webapp_selected_store.id)}>Envoyer</button
        >
      </div>
    </section>

    <!-- modification d'un webapp -->
    <BoxCardEntitiesBody>
      <!-- form donnée principal -->
      <form
        on:submit|preventDefault={async (e) =>
          await updatewebappSelected(e, $webapp_selected_store.id)}
      >
        <!-- title -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Title : </label>
          <Input name="title" placeholder="titre" value={$webapp_selected_store.title} />
        </div>
        <!-- description -->
        <div>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label> Description : </label>
          <Input
            name="description"
            placeholder="description"
            value={$webapp_selected_store.description}
          />
        </div>
        <!-- btn modifier  -->
        <BoxCardEntitiesBoxBtnForm>
          <button class={`${loader_save_webapp_selected} btn btn-primary mt-12`}>Valider</button>
        </BoxCardEntitiesBoxBtnForm>
      </form>

      <!-- partie product -->
      <!-- en tete -->
      <BoxContentHeader>
        <Title slot="title-content" title="Partie production" type_title={ETypeTitle.H6} />
        <!-- btn ajout content -->
        <Tooltip slot="add-content" data="ajouter une production">
          <BtnAdd changeUpdate={addProductWebappSelected} />
        </Tooltip>
      </BoxContentHeader>

      <!-- contenu des products -->
      {#each $webapp_product_store as product, i (product.id)}
        <section class="flex justify-start items-baseline mt-20">
          <p class="mr-4">Document numéro : {product.id}</p>
          <Tooltip slot="btn-delete" data="Supprimer la production">
            <BtnDelete size="w-5 h-5" changeUpdate={() => deleteProductsWebappSelect(product.id)} />
          </Tooltip>
        </section>
        <!-- ajout image delete image de la production -->
        <section class="mb-12 mt-24">
          <Title
            title="Ajouter / Supprimer des images de la production"
            type_title={ETypeTitle.H5}
          />
          {#if product.images.length > 0}
            <section class="flex justify-start flex-wrap mt-6">
              {#each product.images as image, i (image)}
                <div class="mr-4">
                  <img src={image} class="w-56 h-44 mr-2" alt={`${i}`} />
                  <Tooltip slot="btn-delete" data="Supprimer l'image">
                    <BtnDelete
                      size="w-5 h-5"
                      changeUpdate={() => deleteImageProduct(image, product.id)}
                    />
                  </Tooltip>
                </div>
              {/each}
            </section>
          {:else}
            <div>
              <ImgEmptySvg />
            </div>
          {/if}
          <section class="flex flex-col items-center justify-center">
            <!-- input file -->
            <div class="flex justify-center my-6">
              <div class="w-96">
                <input
                  class="form-control
            block
            w-8/12
            sm:w-10/12
            m-auto
            px-2
            py-1
            text-sm
            font-normal
            text-gray-700
            bg-white bg-clip-padding
            border border-solid border-gray-300
            rounded
            transition
            ease-in-out
            focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                  id="formFileSm"
                  type="file"
                  on:change={loadImageProduct}
                />
              </div>
            </div>
            <!-- btn envoie image -->
            <div>
              <button
                class={`${loader_img_webapp} btn btn-xs btn-primary`}
                on:click={() => uploadImgProduct(product.id)}>Envoyer</button
              >
            </div>
          </section>
        </section>
        <!-- donnée principal product -->
        <form on:submit|preventDefault={(e) => updateWebappProduct(e, product.id)}>
          <BoxContentBody id={product.id}>
            <div slot="input-content">
              <!-- svelte-ignore a11y-label-has-associated-control -->
              <!-- partie url -->
              <div class="mb-6">
                <label>Url du site : </label>
                <Input name="url" value={product.url} placeholder="Url du site (http)" />
              </div>
              <!-- svelte-ignore a11y-label-has-associated-control -->
              <!-- partie title -->
              <div class="mb-6">
                <label>Titre de l'application : </label>
                <Input name="title" value={product.title} placeholder="Titre de l'app" />
              </div>
              <!-- svelte-ignore a11y-label-has-associated-control -->
              <!-- partie techno -->
              <div class="mb-6">
                <label>Les technos utilisées (séparer par une virgule sans espace) : </label>
                <Input
                  name="listtechnos"
                  value={product.technos.join(',')}
                  placeholder="Les technos"
                />
              </div>
              <!-- svelte-ignore a11y-label-has-associated-control -->
              <!-- partie content -->
              <div>
                <label>Texte du contenu : </label>
                <Texarea
                  name="content"
                  value={product.content}
                  placeholder="Texte de présentation du site"
                />
              </div>
            </div>
          </BoxContentBody>
          <!-- btn modifier condition generale -->
          <BoxCardEntitiesBoxBtnForm>
            <button class={`${loader_save_condition_gen_selected} btn btn-primary mt-12`}
              >Valider</button
            >
          </BoxCardEntitiesBoxBtnForm>
        </form>
      {/each}
    </BoxCardEntitiesBody>
  </BoxCardEntities>
{/if}
