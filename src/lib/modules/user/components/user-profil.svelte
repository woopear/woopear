<script lang="ts">
  import { session } from '$app/stores';

  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import { firstToUppperCase } from '$lib/providers/format/format.service';
  import { current_user_store } from '../user.store';
</script>

{#if $current_user_store && $current_user_store.uid}
  <section
    class="my-12 card py-4 px-4 md:px-12 bg-base-200 w-full sm:w-9/12 md:w-6/12 lg:w-4/12 shadow-lg"
  >
    <!-- image profil -->
    <section class="flex justify-center">
      {#if $current_user_store.avatar}
        <img src={`${$current_user_store.avatar}`} alt="image profil user" />
      {:else}
        <UserSvg outline={true} />
      {/if}
    </section>
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
          <p>{$current_user_store.phone_number}</p>
          <p>{$session.user.email}</p>
          <p>mot de passe ******</p>
        </div>
      </section>
    </section>
    <!-- lien utils changement d'email, changement mot de passe -->
  </section>
{/if}
