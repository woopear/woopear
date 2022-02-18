<script>
  import HoverBtn from '../hover-btn/hover-btn.svelte';
  import UserSvg from '../user-svg/user-svg.svelte';

  export let changeUpdate;
  export let size = 'w-16 h-16'; // size du svg
  export let color = 'text-white'; // color du svg
  export let relief = false;
</script>

<HoverBtn {relief}>
  <button on:click={changeUpdate} class={`${color}`}>
    <UserSvg outline={false} bind:size />
  </button>
</HoverBtn>
