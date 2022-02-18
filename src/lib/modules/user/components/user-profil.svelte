<script lang="ts">
  import { session } from '$app/stores';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import Card from '$lib/modules/components/card/card.svelte';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import { firstToUppperCase } from '$lib/providers/format/format.service';
  import { current_user_store } from '../user.store';

  let seeUpdate = false;

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
    <section class="flex justify-center">
      {#if $current_user_store.avatar}
        <img src={`${$current_user_store.avatar}`} alt="image profil user" />
      {:else}
        <UserSvg outline={true} />
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
              <p class="text-lg">{$current_user_store.phone_number}</p>
              <!-- partie email -->
              <div class="flex items-center text-lg">
                <p class="mr-4">{$session.user ? $session.user.email : ''}</p>
                <BtnUpdate changeUpdate={undefined} relief={true} size="h-4 w-4" />
              </div>
              <!-- partie mot de passe -->
              <div class="flex items-center text-lg">
                <p class="mr-4">mot de passe ******</p>
                <BtnUpdate changeUpdate={undefined} relief={true} size="h-4 w-4" />
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
          class="py-8 flex flex-col items-center justify-center"
        >
          <Title type_title={ETypeTitle.H6} title="Modification du profil" />

          <!-- btn modifier -->
          <button class="btn btn-primary btn-sm mt-8">Modifier</button>
        </form>
      </section>
    {/if}
  </Card>
{/if}
