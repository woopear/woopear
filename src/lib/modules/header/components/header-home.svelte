<script type="ts">
  import Tooltip from '$lib/modules/components/tooltip/tooltip.svelte';
  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import WoopearSvg from '$lib/modules/components/woopear-svg/woopear-svg.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { theme_mode_store } from '../../theme-mode/theme-mode.store';
  import {
    see_menu_dashboard_store,
    action_menu_sand_store
  } from '$lib/modules/menu-dashboard/menu-dashboard.store';
  import { public_page } from '$lib/providers/public-page/public-page.service';
  import { page } from '$app/stores';

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

  /**
   * affiche ou cache le menu dashboard
   */
  const switchMenuSand = () => {
    console.log('coucou');

    if ($action_menu_sand_store === 'active-sand') {
      // on cache le menu
      see_menu_dashboard_store.disable();
      // on désactive le menu sand
      action_menu_sand_store.disable();
    } else {
      // on affiche le menu
      see_menu_dashboard_store.active();
      // on active le menu sand
      action_menu_sand_store.active();
    }
  };
</script>

<header
  class="z-50 fixed w-full h-16 bg-primary flex justify-between items-center px-8 sm:px-24 md:px-36"
>
  <!-- btn home -->
  <div class="flex items-center">
    <!-- menu sandwich -->
    {#if !public_page.includes($page.url.pathname)}
      <button class="mr-10 cursor-pointer sm:hidden block" on:click={switchMenuSand}>
        <div class={`${$action_menu_sand_store}`}>
          <div />
          <div />
          <div />
        </div>
      </button>
    {/if}
    <Tooltip data="accueil">
      <a href="/" class="text-white">
        <WoopearSvg size="w-10 h-10" />
      </a>
    </Tooltip>
  </div>

  <section class="flex justify-center items-center">
    <!-- switch dark mode -->
    <button class=" text-white flex items-center" on:click={switchTheme}>
      {#if btnDark}
        <Tooltip data="mode claire">
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
        </Tooltip>
      {:else}
        <Tooltip data="mode foncé">
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
        </Tooltip>
      {/if}
    </button>

    <!-- nav -->
    <nav class="ml-4 md:ml-8">
      <ul class="flex items-center">
        <Tooltip data="mon compte">
          <li>
            <!-- lien page connexion -->
            <a href="/login" class="text-white">
              <!-- si image avatar existe on affiche sinon on affiche svg par defaut -->
              {#if $current_user_store.avatar}
                <img
                  class="w-7 h-7 rounded-full"
                  src={`${$current_user_store.avatar}`}
                  alt="profil user"
                />
              {:else}
                <UserSvg outline={false} size="w-7 h-7" />
              {/if}
            </a>
          </li>
        </Tooltip>
      </ul>
    </nav>
  </section>
</header>

<style>
  .sand {
    width: 50px;
    height: 50px;
    position: relative;
  }

  .sand > div {
    background-color: white;
    position: absolute;
    height: 2px;
    width: 80%;
    transition: all 0.3s;
  }

  .sand :nth-child(1) {
    top: 14px;
  }

  .sand :nth-child(2) {
    top: 24px;
  }

  .sand :nth-child(3) {
    top: 34px;
  }

  .active-sand {
    width: 50px;
    height: 50px;
    position: relative;
  }

  .active-sand > div {
    background-color: white;
    position: absolute;
    height: 2px;
    width: 80%;
    transition: all 0.3s;
  }

  .active-sand :nth-child(1) {
    top: 24px;
    transform: rotate(-225deg);
  }

  .active-sand :nth-child(2) {
    opacity: 0;
    top: 24px;
  }

  .active-sand :nth-child(3) {
    top: 24px;
    transform: rotate(225deg);
  }
</style>
