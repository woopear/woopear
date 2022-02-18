<script lang="ts">
  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import { current_user_store } from '../user.store';
</script>

{#if $current_user_store && $current_user_store.uid}
  <section class="my-12 card py-4 px-4 md:px-12 bg-base-200">
    <!-- image profil -->
    <section>
      {#if $current_user_store.avatar}
        <img src={`${$current_user_store.avatar}`} alt="image profil user" />
      {:else}
        <UserSvg outline={true} />
      {/if}
    </section>
    <!-- information -->
    <!-- lien utils changement d'email, changement mot de passe -->
  </section>
{/if}
