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
{#if $store_notification?.length > 0}
  <section class=" rounded-lg fixed top-20 right-8 w-full sm:w-5/12 md:w-4/12 z-50">
    <!-- boucle sur le tableau notification -->
    {#each $store_notification as notification}
      <!-- si la notification est de type warning -->
      {#if notification.type === 'warning'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-warning text-white">
          <div class="flex items-center justify-start">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="stroke-current flex-shrink-0 h-8 w-8"
              fill="none"
              viewBox="0 0 24 24"
              ><path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
              /></svg
            >
            <p class="ml-4">{notification.libelle}</p>
          </div>
          <!-- boutton supprimer notification -->
          <div class="ml-auto mb-4">
            <button
              class="btn btn-circle btn-sm sm:btn-sm text-error bg-gray-100 hover:bg-white border-none"
              on:click={() => store_notification.removeNotificationUser(notification.id)}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </section>
        <!-- si la notification est de type error -->
      {:else if notification.type === 'error'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-error text-white">
          <div class="flex items-center justify-start">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="stroke-current flex-shrink-0 h-8 w-8"
              fill="none"
              viewBox="0 0 24 24"
              ><path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"
              /></svg
            >
            <p class="ml-4">{notification.libelle}</p>
          </div>
          <!-- boutton supprimer notification -->
          <div class="ml-auto mb-4">
            <button
              class="btn btn-circle btn-sm sm:btn-sm text-error bg-gray-100 hover:bg-white border-none"
              on:click={() => store_notification.removeNotificationUser(notification.id)}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </section>
        <!-- si la notification est de type success -->
      {:else if notification.type === 'success'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-success text-white">
          <div class="flex items-center justify-start">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="stroke-current flex-shrink-0 h-8 w-8"
              fill="none"
              viewBox="0 0 24 24"
              ><path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
              /></svg
            >
            <p class="ml-4">{notification.libelle}</p>
          </div>
          <!-- boutton supprimer notification -->
          <div class="ml-auto mb-4">
            <button
              on:click={() => store_notification.removeNotificationUser(notification.id)}
              class="btn btn-circle btn-sm sm:btn-sm text-error bg-gray-100 hover:bg-white border-none"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </section>
        <!-- si la notification est de type info -->
      {:else if notification.type === 'info'}
        <section class="mt-2 alert shadow-lg bg-opacity-100 alert-info text-white">
          <div class="flex items-center justify-start">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              class="stroke-current flex-shrink-0 h-8 w-8"
              ><path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
              /></svg
            >
            <p class="ml-4">{notification.libelle}</p>
          </div>
          <!-- boutton supprimer notification -->
          <div class="ml-auto mb-4">
            <button
              on:click={() => store_notification.removeNotificationUser(notification.id)}
              class="btn btn-circle btn-sm sm:btn-sm text-error bg-gray-100 hover:bg-white border-none"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </section>
      {/if}
    {/each}
  </section>
{/if}
