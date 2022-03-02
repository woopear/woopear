<script lang="ts">
  import AddSvg from '../add-svg/add-svg.svelte';
  import Tooltip from '../tooltip/tooltip.svelte';

  export let handlerClick;
  export let data = '';
</script>

<section
  on:click={handlerClick}
  class="cursor-pointer mt-6 mb-12 w-full btn btn-primary rounded-lg h-10 flex justify-center items-center"
>
  <Tooltip {data}>
    <AddSvg style="font-bold text-base-200" />
  </Tooltip>
</section>
