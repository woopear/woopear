<script type="ts">
  import { themeModeStore } from '../../theme-mode/theme-mode.store';

  // boolean mode dark en fonction du themeMode
  $: btnDark = $themeModeStore === 'woo-claire' ? false : true;

  // fonction pour switch de mode dark a mode light
  const switchTheme = () => {
    // condition qui verifier dans quel théme on se trouve
    if ($themeModeStore === 'woo-claire') {
      themeModeStore.set('woo-dark');
      btnDark = true;
      document.querySelector('#baliseHtml').setAttribute('data-theme', $themeModeStore);
      localStorage.setItem('woo-dark', $themeModeStore);
    } else {
      themeModeStore.set('woo-claire');
      btnDark = false;
      document.querySelector('#baliseHtml').setAttribute('data-theme', $themeModeStore);
      localStorage.setItem('woo-dark', $themeModeStore);
    }
  };
</script>

<section>
  <header class="h-16 bg-primary flex justify-between items-center px-6 md:px-44">
    <!-- btn home -->
    <div data-tip="Accueil" class="tooltip tooltip-bottom tooltip-secondary">
      <button class="text-white">
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
            d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
          />
        </svg>
      </button>
    </div>

    <!-- switch dark mode -->
    <div class="flex items-center">
      <button class="text-white" on:click={switchTheme}>
        {#if btnDark}
          <li data-tip="mode claire" class="tooltip tooltip-bottom tooltip-secondary">
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
                d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"
              />
            </svg>
          </li>
        {:else}
          <li data-tip="mode foncé" class="tooltip tooltip-bottom tooltip-secondary">
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
                d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"
              />
            </svg>
          </li>
        {/if}
      </button>
    </div>
  </header>
</section>
