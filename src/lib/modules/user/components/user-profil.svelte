<script lang="ts">
  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import { firstToUppperCase } from '$lib/providers/format/format.service';
  import { current_user_store } from '../user.store';
</script>

{#if $current_user_store && $current_user_store.uid}
  <section class="my-12 card py-4 px-4 md:px-12 bg-base-200">
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
        <p>Nom : <strong>{$current_user_store.last_name}</strong></p>
        <p>Prénom : <strong>{$current_user_store.first_name}</strong></p>
      </section>
    </section>
    <!-- lien utils changement d'email, changement mot de passe -->
  </section>
{/if}
