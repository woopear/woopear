<script lang="ts">
  import AddSvg from '../add-svg/add-svg.svelte';
  import HoverBtn from '../hover-btn/hover-btn.svelte';

  export let changeUpdate;
  export let relief = false;
  export let size = 'h-6 w-6';
  export let color = 'text-secondary';
</script>

<HoverBtn {relief}>
  <button class={`${color}`} on:click={changeUpdate}>
    <AddSvg {size} />
  </button>
</HoverBtn>
