<script lang="ts">
  import AdvertisingSvg from '$lib/modules/components/advertising-svg/advertising-svg.svelte';
  import ConditionSvg from '$lib/modules/components/condition-svg/condition-svg.svelte';

  import HomeSvg from '$lib/modules/components/home-svg/home-svg.svelte';
  import PresentationSvg from '$lib/modules/components/presentation-svg/presentation-svg.svelte';
  import ProductSvg from '$lib/modules/components/product-svg/product-svg.svelte';
  import TeamSvg from '$lib/modules/components/team-svg/team-svg.svelte';
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
    <!-- si current user est de role admin -->
    {#if $current_user_store?.role}
      {#if $current_user_store.role.libelle === ERole.ADMIN}
        <!-- user -->
        <li class="relative group">
          <a href="/dashboard/users">
            <UserSvg_2 size="w-7 h-7" />
          </a>
          <TooltipCustom text="utilisateurs" />
        </li>
        <!-- advertising -->
        <li class="relative group">
          <a href="/dashboard/advertisings">
            <AdvertisingSvg size="w-7 h-7" />
          </a>
          <TooltipCustom text="publicités" />
        </li>
        <!-- condition general -->
        <li class="relative group">
          <a href="/dashboard/conditions">
            <ConditionSvg size="w-7 h-7" />
          </a>
          <TooltipCustom text="conditions" />
        </li>
        <!-- presentation -->
        <li class="relative group">
          <a href="/dashboard/presentation">
            <PresentationSvg size="w-7 h-7" />
          </a>
          <TooltipCustom text="présentation" />
        </li>
        <!-- products -->
        <li class="relative group">
          <a href="/dashboard/products">
            <ProductSvg size="w-7 h-7" />
          </a>
          <TooltipCustom text="productions" />
        </li>
        <!-- team -->
        <li class="relative group">
          <a href="/dashboard/teams">
            <TeamSvg size="w-7 h-7" />
          </a>
          <TooltipCustom text="équipe" />
        </li>
      {/if}
    {/if}
  </ul>
</nav>

<style>
  li > a {
    padding: 0.75rem 0.9rem;
  }
</style>
