<script lang="ts">
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Card from '$lib/modules/components/card/card.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
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
  let loader_update_user = '';

  /**
   * modification de l'entreprise
   * @param e => event formulaire
   * @param id => id du current user
   */
  const updateUser = async (e, id) => {
    loader_update_user = 'loading';
    // création du formData
    const form_data = createObjectAsFormData<IUser>(e.target);

    // modifier le user
    await current_user_store.updateUser(id, form_data);

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
    console.log(img_file);
  };

  /**
   * upload l'avatar du current user
   */
  const uploadImg = async () => {
    loader_img_logo = 'loading';

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
      {#if $current_user_store?.companie.logo !== ''}
        <img src={`${$current_user_store.companie.logo}`} alt="logo de la companie" />
      {:else}
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
            <Input
              name="companie.siret"
              placeholder="Dourges"
              value={$current_user_store.companie.siret}
            />
          </div>
        </div>
        <!-- btn modifier -->
        <button class={`${loader_update_user} btn btn-primary btn-sm mt-8`}>Modifier</button>
      </form>
    {/if}
  </Card>
{:else}
  <SpinnerLittle />
{/if}
