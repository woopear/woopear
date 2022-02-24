<script lang="ts">
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Card from '$lib/modules/components/card/card.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import {
    constNotificationConfirmation,
    constNotificationError,
    constNotificationType
  } from '$lib/modules/notification/notification.const';
  import { store_notification } from '$lib/modules/notification/store/notification.store';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { createObjectAsFormData, firstToUppperCase } from '$lib/providers/format/format.service';
  import { current_user_store } from '../user.store';
  import type { IUser } from '../user.type';

  // voir modification de la companie
  let seeUpdate = false;
  // voir modification du logo
  let seeUpdateImg = false;
  // change le flex du input file
  $: flex_img = seeUpdateImg ? 'flex-col items-center' : '';
  // taille de la marge du haut des input du formulaire
  const margin_top_input = '4';
  // stock le file du input
  let img_file;
  // loader pour btn update image logo
  let loader_img_logo = '';
  // loader pour btn update user
  let loader_update_companie = '';

  /**
   * modification de l'entreprise
   * @param e => event formulaire
   * @param id => id du current user
   */
  const updateUser = async (e, id) => {
    try {
      loader_update_companie = 'loading';
      // création du formData
      const form_data = createObjectAsFormData<IUser>(e.target);

      // modifier le user
      await current_user_store.updateUser(id, form_data);

      // on ferme le volet de modification
      seeUpdate = !seeUpdate;
      loader_update_companie = '';
      store_notification.addNewNotificationUser(
        constNotificationType.SUCCESS,
        constNotificationConfirmation.UPDATE_ACCOUNT_COMPANIE,
        $current_user_store.uid
      );
    } catch (error) {
      store_notification.addNewNotificationUser(
        constNotificationType.ERROR,
        constNotificationError.UPDATE_ACCOUNT_COMPANIE,
        $current_user_store.uid
      );
      throw new Error('Impossible de modifier la compagnie, une erreur est survenue');
    }
  };

  /**
   * stocke le file dans une varibale
   * @param e => event change
   */
  const loadImage = (e) => {
    img_file = e.target.files[0];
    console.log(img_file);
  };

  /**
   * upload l'avatar du current user
   */
  const uploadImg = async () => {
    loader_img_logo = 'loading';
    // upload logo
    await current_user_store.uploadLogoCompanie(img_file, $current_user_store.id);

    // on ferme le volet de modification image
    seeUpdateImg = !seeUpdateImg;
    loader_img_logo = '';
  };
</script>

{#if $current_user_store?.companie}
  <Card>
    <!-- partie btn update -->
    <section class="flex justify-end">
      {#if seeUpdate}
        <BtnCloseUpdate changeUpdate={() => (seeUpdate = !seeUpdate)} relief={true} />
      {:else}
        <BtnUpdate changeUpdate={() => (seeUpdate = !seeUpdate)} relief={true} />
      {/if}
    </section>

    <!-- logo de l'entreprise -->
    <section class={`flex ${flex_img} justify-center`}>
      <!-- section si le logo n'est pas présent -->
      {#if $current_user_store?.companie.logo !== ''}
        {#if !seeUpdateImg}
          <img
            class="w-24 h-24 rounded-full mt-8 mb-2"
            src={`${$current_user_store.companie.logo}`}
            alt="logo de la companie"
          />
        {/if}
        {#if seeUpdate && !seeUpdateImg}
          <BtnUpdate
            changeUpdate={() => (seeUpdateImg = !seeUpdateImg)}
            relief={true}
            size="w-4 h-4"
          />
        {:else if seeUpdate && seeUpdateImg}
          <BtnCloseUpdate
            changeUpdate={() => (seeUpdateImg = !seeUpdateImg)}
            relief={true}
            size="w-4 h-4"
          />
          <h1 class="text-sm font-semibold mt-8">Modification logo entreprise</h1>
        {/if}
      {:else}
        <!-- section si le logo est présent  -->
        {#if !seeUpdateImg}
          <svg
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            class="h-20 w-20"
            style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd"
            version="1.1"
            viewBox="0 0 846.66 846.66"
            xml:space="preserve"
            ><defs /><g id="Layer_x0020_1"
              ><path
                class="fil0"
                d="M97.17 185.96l343.73 0 0 -102.62c0,-11.49 9.31,-20.81 20.8,-20.81l287.79 0c11.49,0 20.81,9.32 20.81,20.81l0 659.18 48.48 0c27.36,0 27.36,41.61 0,41.61 -263.63,0 -527.27,0 -790.9,0 -27.36,0 -27.36,-41.61 0,-41.61l48.49 0 0 -535.76c0,-11.48 9.31,-20.8 20.8,-20.8zm212.43 556.56l0 -81.83 -60.33 0 0 81.83 60.33 0zm-101.94 0l0 -102.64c0,-11.48 9.31,-20.8 20.8,-20.8l101.95 0c11.49,0 20.8,9.32 20.8,20.8l0 102.64 89.69 0 0 -514.95 -322.92 0 0 514.95 89.68 0zm335.52 -593.64l124.83 0c11.49,0 20.81,9.31 20.81,20.8l0 374.5c0,11.49 -9.32,20.8 -20.81,20.8l-124.83 0c-11.49,0 -20.81,-9.31 -20.81,-20.8l0 -374.5c0,-11.49 9.32,-20.8 20.81,-20.8zm104.03 41.6l-83.23 0 0 332.89 83.23 0 0 -332.89zm-467.12 211.18l68.66 0c11.49,0 20.8,9.32 20.8,20.81l0 68.65c0,11.49 -9.31,20.81 -20.8,20.81l-68.66 0c-11.49,0 -20.81,-9.32 -20.81,-20.81l0 -68.65c0,-11.49 9.32,-20.81 20.81,-20.81zm47.85 41.61l-27.05 0 0 27.05 27.05 0 0 -27.05zm82.19 -41.61l68.65 0c11.49,0 20.81,9.32 20.81,20.81l0 68.65c0,11.49 -9.32,20.81 -20.81,20.81l-68.65 0c-11.49,0 -20.81,-9.32 -20.81,-20.81l0 -68.65c0,-11.49 9.32,-20.81 20.81,-20.81zm47.85 41.61l-27.05 0 0 27.05 27.05 0 0 -27.05zm-177.89 -174.76l68.66 0c11.49,0 20.8,9.31 20.8,20.8l0 68.66c0,11.49 -9.31,20.8 -20.8,20.8l-68.66 0c-11.49,0 -20.81,-9.31 -20.81,-20.8l0 -68.66c0,-11.49 9.32,-20.8 20.81,-20.8zm47.85 41.61l-27.05 0 0 27.04 27.05 0 0 -27.04zm82.19 -41.61l68.65 0c11.49,0 20.81,9.31 20.81,20.8l0 68.66c0,11.49 -9.32,20.8 -20.81,20.8l-68.65 0c-11.49,0 -20.81,-9.31 -20.81,-20.8l0 -68.66c0,-11.49 9.32,-20.8 20.81,-20.8zm47.85 41.61l-27.05 0 0 27.04 27.05 0 0 -27.04zm124.53 432.4l246.18 0 0 -638.38 -246.18 0 0 638.38z"
              /></g
            ></svg
          >
        {/if}
        {#if seeUpdate && !seeUpdateImg}
          <BtnUpdate
            changeUpdate={() => (seeUpdateImg = !seeUpdateImg)}
            relief={true}
            size="w-4 h-4"
          />
        {:else if seeUpdate && seeUpdateImg}
          <BtnCloseUpdate
            changeUpdate={() => (seeUpdateImg = !seeUpdateImg)}
            relief={true}
            size="w-4 h-4"
          />
          <Title type_title={ETypeTitle.H6} title="Modification logo entreprise" />
        {/if}
      {/if}
      <!-- partie input envoie image -->
      {#if seeUpdate && seeUpdateImg}
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
              on:change={loadImage}
              name="companie.logo"
            />
          </div>
        </div>
        <button class={`${loader_img_logo} btn btn-xs btn-primary`} on:click={uploadImg}
          >Envoyer</button
        >
      {/if}
    </section>

    {#if !seeUpdate}
      <!-- affichage des donnée de l'entreprise -->
      <section>
        <!-- denomination de l'entreprise -->
        <p class="text-center my-2 font-semibold text-3xl">
          {`${firstToUppperCase($current_user_store.companie.denomination)}`}
        </p>

        <!-- information de l'entreprise -->
        <section class="mt-8">
          <section>
            <!-- cadre adresse -->
            <div>
              <p class="text-secondary font-semibold mb-2 text-xl">Adresse</p>
              <div class="pl-2 text-lg font-light">
                <p>{$current_user_store.companie.address}</p>
                <p>
                  {$current_user_store.companie.code_post}
                  {firstToUppperCase($current_user_store.companie.city)}
                </p>
              </div>
            </div>

            <!-- info divers -->
            <hr class="my-4" />
            <div>
              <p class="text-secondary font-semibold mb-2 text-xl">Infos</p>
              <p class="text-lg" />

              <!-- siret -->
              <div class="flex items-center text-lg">
                <p class="mr-4"><span>Siret: </span>{$current_user_store.companie.siret}</p>
              </div>

              <!-- code naf -->
              <div class="flex items-center text-lg">
                <p class="mr-4"><span>Code Naf: </span>{$current_user_store.companie.code_naf}</p>
              </div>
            </div>
          </section>
        </section>
      </section>
    {:else}
      <!-- partie modification -->

      <form
        class="py-8 flex flex-col items-center justify-center w-full"
        on:submit|preventDefault={(e) => updateUser(e, $current_user_store.id)}
      >
        <!-- title -->
        <div class="mb-6">
          <Title type_title={ETypeTitle.H6} title="Modification de l'entreprise" />
        </div>

        <!-- partie input -->
        <div class="w-full">
          <!-- input denomination -->
          <div class={`mt-4`}>
            <Input
              name="companie.denomination"
              placeholder="edf"
              value={$current_user_store.companie.denomination}
            />
          </div>

          <!-- input adresse -->
          <div class={`mt-4`}>
            <Input
              name="companie.address"
              placeholder="16 rue louis michel"
              value={$current_user_store.companie.address}
            />
          </div>

          <!-- input code postal -->
          <div class={`mt-4`}>
            <Input
              name="companie.code_post"
              placeholder="62119"
              value={$current_user_store.companie.code_post}
            />
          </div>

          <!-- input vile -->
          <div class={`mt-4`}>
            <Input
              name="companie.city"
              placeholder="Dourges"
              value={$current_user_store.companie.city}
            />
          </div>

          <!-- input siret -->
          <div class={`mt-4`}>
            <span>Siret</span>
            <Input
              name="companie.siret"
              placeholder="456465"
              value={$current_user_store.companie.siret}
            />
          </div>

          <!-- input code naf -->
          <div class={`mt-4`}>
            <span>Code Naf</span>
            <Input
              name="companie.code_naf"
              placeholder="456"
              value={$current_user_store.companie.code_naf}
            />
          </div>
        </div>
        <!-- btn modifier -->
        <button class={`${loader_update_companie} btn btn-primary btn-sm mt-8`}>Modifier</button>
      </form>
    {/if}
  </Card>
{:else}
  <SpinnerLittle />
{/if}
