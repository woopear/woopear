<script lang="ts">
  import HomeSvg from '$lib/modules/components/home-svg/home-svg.svelte';
  import TooltipCustom from '$lib/modules/components/tooltip/tooltip-custom.svelte';
  import UserSvg_2 from '$lib/modules/components/user-svg/user-svg-2.svelte';
  import Logout from '$lib/modules/logout/components/logout.svelte';
  import { ERole } from '$lib/modules/role/role.type';
  import { current_user_store } from '$lib/modules/user/user.store';
</script>

<nav class="fixed navbar items-start mt-16 p-0 bg-base-200 top-0 bottom-0 left-0 z-20 w-14">
  <ul class="menu text-primary pt-6 overflow-visible max-w-full">
    <li class="relative group">
      <a href="/login">
        <Logout />
      </a>
      <TooltipCustom text="déconnection" />
    </li>
    <li class="relative group">
      <a href="/dashboard">
        <HomeSvg size="w-7 h-7" />
      </a>
      <!--<TooltipCustom text="home" />-->
    </li>
    {#if $current_user_store.role.libelle === ERole.ADMIN}
      <li class="relative group">
        <a href="/dashboard">
          <UserSvg_2 size="w-7 h-7" />
        </a>
        <TooltipCustom text="utilisateurs" />
      </li>
    {/if}
  </ul>
</nav>

<style>
  li > a {
    padding: 0.75rem 0.9rem;
  }
</style>
