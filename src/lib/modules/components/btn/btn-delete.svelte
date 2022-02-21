<script lang="ts">
  import DeleteSvg from '../delete-svg/delete-svg.svelte';
  import HoverBtn from '../hover-btn/hover-btn.svelte';

  export let changeUpdate;
  export let size = 'w-6 h-6'; // size du svg
  export let color = 'text-error'; // color du svg
  export let relief = false;
</script>

<HoverBtn {relief}>
  <button on:click={changeUpdate} class={`${color}`}>
    <DeleteSvg {size} />
  </button>
</HoverBtn>
