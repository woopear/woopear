<script lang="ts">
  import HomeSvg from '$lib/modules/components/home-svg/home-svg.svelte';
  import Logout from '$lib/modules/logout/components/logout.svelte';
</script>

<nav class="fixed navbar items-start mt-16 p-0 bg-base-200 top-0 bottom-0 left-0 z-20 w-14">
  <ul class="menu text-primary pt-6 overflow-visible max-w-full">
    <li class="relative group">
      <a href="/login">
        <Logout />
      </a>
      <!--<TooltipCustom text="déconnection" />-->
    </li>
    <li class="relative group">
      <a href="/dashboard">
        <HomeSvg size="w-7 h-7" />
      </a>
      <!--<TooltipCustom text="home" />-->
    </li>
  </ul>
</nav>

<style>
  li > a {
    padding: 0.75rem 0.9rem;
  }
</style>
