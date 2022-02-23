<script lang="ts">
  import { session } from '$app/stores';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Card from '$lib/modules/components/card/card.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';
  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { createObjectAsFormData, firstToUppperCase } from '$lib/providers/format/format.service';
  import { current_user_store } from '../user.store';
  import type { IUser } from '../user.type';

  // voir modification update user
  let seeUpdate = false;
  // voir modification image
  let seeUpdateImg = false;
  // change le flex du input file
  $: flex_img = seeUpdateImg ? 'flex-col items-center' : '';
  // taille de la marge du haut des input du formulaire
  const margin_top_input = '4';
  // stock le file du input
  let img_file;
  // loader pour btn update image avatar
  let loader_img_avatar = '';
  // loader pour btn update user
  let loader_update_user = '';

  /**
   * modification user
   * @param e => event formulaire
   * @param id => id du current user
   */
  const updateUser = async (e, id) => {
    loader_update_user = 'loading';
    // creation des données
    const data = createObjectAsFormData<IUser>(e.target);
    // creation du user_name
    data.user_name = data.first_name + ' ' + data.last_name;
    // modification du user
    await current_user_store.updateUser(id, data);
    // on ferme le volet de modification
    seeUpdate = !seeUpdate;
    loader_update_user = '';
  };

  /**
   * stocke le file dans une varibale
   * @param e => event change
   */
  const loadImage = (e) => {
    img_file = e.target.files[0];
  };

  /**
   * upload l'avatar du current user
   */
  const uploadImg = async () => {
    loader_img_avatar = 'loading';
    if (img_file) {
      await current_user_store.uploadAvatarUser(img_file, $current_user_store.id);
      // on ferme le volet de modification image
      seeUpdateImg = !seeUpdateImg;
    } else {
      // TODO : gerer erreur de fichier non charger
    }
    loader_img_avatar = '';
  };
</script>

{#if $current_user_store && $current_user_store.uid}
  <Card>
    <!-- partie btn update -->
    <section class="flex justify-end">
      {#if seeUpdate}
        <BtnCloseUpdate changeUpdate={() => (seeUpdate = !seeUpdate)} relief={true} />
      {:else}
        <BtnUpdate changeUpdate={() => (seeUpdate = !seeUpdate)} relief={true} />
      {/if}
    </section>

    <!-- image profil -->

    <section class={`flex ${flex_img} justify-center`}>
      {#if $current_user_store.avatar}
        <!-- section si image est dispo -->
        {#if !seeUpdateImg}
          <img
            class="w-24 h-24 rounded-full mt-8 mb-2"
            src={`${$current_user_store.avatar}`}
            alt="profil user"
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
          <h1 class="text-sm font-semibold mt-8">Modification image profil</h1>
        {/if}
      {:else}
        <!-- section si image est pas dispo -->
        {#if !seeUpdateImg}
          <UserSvg outline={true} />
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
          <Title type_title={ETypeTitle.H6} title="Modification image profil" />
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
            />
          </div>
        </div>
        <button class={`${loader_img_avatar} btn btn-xs btn-primary`} on:click={uploadImg}
          >Envoyer</button
        >
      {/if}
    </section>

    {#if !seeUpdate}
      <!-- section affichage -->
      <section>
        <!-- partie username full -->
        <p class="text-center my-2 font-semibold text-2xl">
          {`${firstToUppperCase($current_user_store.first_name)} ${firstToUppperCase(
            $current_user_store.last_name
          )}`}
        </p>

        <!-- information -->
        <section class="mt-8">
          <section>
            <!-- cadre adresse -->
            <div>
              <p class="text-secondary font-semibold mb-2 text-xl">Adresse</p>
              <div class="pl-2 text-lg font-light">
                <p>{$current_user_store.address}</p>
                <p>{$current_user_store.code_post} {firstToUppperCase($current_user_store.city)}</p>
              </div>
            </div>

            <!-- cadre info divers -->
            <hr class="my-4" />
            <div>
              <p class="text-secondary font-semibold mb-2 text-xl">Infos</p>
              <div class="pl-2 text-lg font-light">
                <p>{$current_user_store.phone_number}</p>

                <!-- partie email -->
                <div class="flex">
                  <p class="mr-2">{$session.user ? $session.user.email : ''}</p>
                  <Tooltip data="modifier mon email" direction="tooltip-left">
                    <BtnUpdate changeUpdate={undefined} relief={false} size="h-3 w-3" />
                  </Tooltip>
                </div>

                <!-- partie mot de passe -->
                <div class="flex">
                  <p class="mr-2">mot de passe ******</p>
                  <Tooltip data="modifier mon mot de passe" direction="tooltip-left">
                    <BtnUpdate changeUpdate={undefined} relief={false} size="h-3 w-3" />
                  </Tooltip>
                </div>
              </div>
            </div>
          </section>
        </section>
      </section>
    {:else}
      <!-- section update -->
      <section>
        <form
          on:submit|preventDefault={(e) => updateUser(e, $current_user_store.id)}
          class="py-8 flex flex-col items-center justify-center w-full"
        >
          <!-- title -->
          <div class="mb-6">
            <Title type_title={ETypeTitle.H6} title="Modification du profil" />
          </div>

          <!-- partie input -->
          <div class="w-full">
            <!-- first_name -->
            <div class={`mt-4`}>
              <Input
                name="first_name"
                placeholder="Prénom"
                value={$current_user_store.first_name}
              />
            </div>

            <!-- last_name -->
            <div class={`mt-4`}>
              <Input name="last_name" placeholder="Nom" value={$current_user_store.last_name} />
            </div>

            <!-- address -->
            <div class={`mt-4`}>
              <Input name="address" placeholder="Addresse" value={$current_user_store.address} />
            </div>

            <!-- code_post -->
            <div class={`mt-4`}>
              <Input
                name="code_post"
                placeholder="Code postal"
                value={$current_user_store.code_post}
              />
            </div>

            <!-- city -->
            <div class={`mt-4`}>
              <Input name="city" placeholder="Ville" value={$current_user_store.city} />
            </div>

            <!-- phone_number -->
            <div class={`mt-4`}>
              <Input
                name="phone_number"
                placeholder="Numéro de téléphone"
                value={$current_user_store.phone_number}
              />
            </div>
          </div>

          <!-- btn modifier -->
          <button class={`${loader_update_user} btn btn-primary btn-sm mt-8`}>Modifier</button>
        </form>
      </section>
    {/if}
  </Card>
{:else}
  <SpinnerLittle />
{/if}
