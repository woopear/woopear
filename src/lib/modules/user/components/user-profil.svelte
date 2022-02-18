<script lang="ts">
  import { session } from '$app/stores';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Card from '$lib/modules/components/card/card.svelte';
  import Input from '$lib/modules/components/input/input.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { firstToUppperCase } from '$lib/providers/format/format.service';
  import { current_user_store } from '../user.store';

  let seeUpdate = false;
  let seeUpdateImg = false;
  const margin_top_input = '4';

  const updateUser = () => {
    console.log('je suis dans modifier user');
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
    <section class="flex flex-col items-center justify-center">
      {#if $current_user_store.avatar}
        <!-- section si image est dispo -->
        {#if !seeUpdateImg}
          <img src={`${$current_user_store.avatar}`} alt="image profil user" />
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
        {/if}
      {/if}
      {#if seeUpdate && seeUpdateImg}
        <div class="flex justify-center mt-4">
          <div class="mb-3 w-96">
            <input
              class="form-control
          block
          w-full
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
          m-0
          focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              id="formFileSm"
              type="file"
            />
          </div>
        </div>
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
                  <div data-tip="modifier mon email" class="tooltip tooltip-left tooltip-secondary">
                    <BtnUpdate changeUpdate={undefined} relief={false} size="h-3 w-3" />
                  </div>
                </div>

                <!-- partie mot de passe -->
                <div class="flex">
                  <p class="mr-2">mot de passe ******</p>
                  <div
                    data-tip="modifier mon mot de passe"
                    class="tooltip tooltip-left tooltip-secondary"
                  >
                    <BtnUpdate changeUpdate={undefined} relief={false} size="h-3 w-3" />
                  </div>
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
          on:submit|preventDefault={updateUser}
          class="py-8 flex flex-col items-center justify-center w-full"
        >
          <!-- title -->
          <div class="mb-6">
            <Title type_title={ETypeTitle.H6} title="Modification du profil" />
          </div>

          <!-- partie input -->
          <div class="w-full">
            <!-- first_name -->
            <div class={`mt-${margin_top_input}`}>
              <Input
                name="first_name"
                placeholder="Prénom"
                value={$current_user_store.first_name}
              />
            </div>

            <!-- last_name -->
            <div class={`mt-${margin_top_input}`}>
              <Input name="last_name" placeholder="Nom" value={$current_user_store.last_name} />
            </div>

            <!-- address -->
            <div class={`mt-${margin_top_input}`}>
              <Input name="address" placeholder="Addresse" value={$current_user_store.address} />
            </div>

            <!-- code_post -->
            <div class={`mt-${margin_top_input}`}>
              <Input
                name="code_post"
                placeholder="Code postal"
                value={$current_user_store.code_post}
              />
            </div>

            <!-- city -->
            <div class={`mt-${margin_top_input}`}>
              <Input name="city" placeholder="Ville" value={$current_user_store.city} />
            </div>

            <!-- phone_number -->
            <div class={`mt-${margin_top_input}`}>
              <Input
                name="Numéro de téléphone"
                placeholder="prénom"
                value={$current_user_store.phone_number}
              />
            </div>
          </div>

          <!-- btn modifier -->
          <button class="btn btn-primary btn-sm mt-8">Modifier</button>
        </form>
      </section>
    {/if}
  </Card>
{:else}
  <SpinnerLittle />
{/if}
