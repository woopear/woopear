<script lang="ts">
  import { session } from '$app/stores';
  import { onMount } from 'svelte';
  import { store_notification } from '../store/notification.store';

  onMount(async () => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      store_notification.listenNotificationUser($session.user.uid);
    }
  });
</script>

<!-- si le tableau de notification n'est pas vide -->
{#if $store_notification.length > 0}
  <section class=" rounded-lg fixed top-20 right-8 w-full sm:w-5/12 md:w-4/12 z-50">
    <!-- boucle sur le tableau notification -->
    {#each $store_notification as notification}
      <!-- si la notification est de type warning -->
      {#if notification.type === 'warning'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-warning text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
        <!-- si la notification est de type error -->
      {:else if notification.type === 'error'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-error text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
        <!-- si la notification est de type success -->
      {:else if notification.type === 'success'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-success text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
        <!-- si la notification est de type info -->
      {:else if notification.type === 'info'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-info text-white">
          <div>
            <span>{notification.libelle}</span>
          </div>
        </section>
      {/if}
    {/each}
  </section>
{/if}
