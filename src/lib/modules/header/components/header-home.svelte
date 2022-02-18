<script type="ts">
  import WoopearSvg from '$lib/modules/components/woopear-svg/woopear-svg.svelte';
  import { theme_mode_store } from '../../theme-mode/theme-mode.store';

  // boolean mode dark en fonction du themeMode
  $: btnDark = $theme_mode_store === 'woo-claire' ? false : true;

  /**
   * fonction pour switch de mode dark a mode light
   */
  const switchTheme = () => {
    // condition qui verifier dans quel théme on se trouve
    if ($theme_mode_store === 'woo-claire') {
      theme_mode_store.set('woo-dark');
      btnDark = true;
      document.querySelector('#baliseHtml').setAttribute('data-theme', $theme_mode_store);
      localStorage.setItem('woo-dark', $theme_mode_store);
    } else {
      theme_mode_store.set('woo-claire');
      btnDark = false;
      document.querySelector('#baliseHtml').setAttribute('data-theme', $theme_mode_store);
      localStorage.setItem('woo-dark', $theme_mode_store);
    }
  };
</script>

<header
  class="fixed w-full h-16 bg-primary flex justify-between items-center px-8 sm:px-24 md:px-36"
>
  <!-- btn home -->
  <section data-tip="Accueil" class="tooltip tooltip-bottom tooltip-secondary">
    <a href="/" class="text-white">
      <WoopearSvg size="w-10 h-10" />
    </a>
  </section>

  <!-- switch dark mode -->
  <button class=" text-white flex items-center" on:click={switchTheme}>
    {#if btnDark}
      <div data-tip="mode claire" class="tooltip tooltip-bottom tooltip-secondary">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-7 w-7"
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
      </div>
    {:else}
      <div data-tip="mode foncé" class="tooltip tooltip-bottom tooltip-secondary">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-7 w-7"
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
      </div>
    {/if}
  </button>

  <!-- TODO : pour le logo connexion
    faire que quand il est connecter il aura une image de profil
    et quand il est pas connecter il y aura une image de profil par defaut
    cette image sera deja dans le stockage firebase -->
  <!-- nav -->
</header>
