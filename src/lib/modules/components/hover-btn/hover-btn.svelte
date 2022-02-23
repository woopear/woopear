<script lang="ts">
  import { theme_mode_store } from '$lib/modules/theme-mode/theme-mode.store';

  // pour afficher un relief sur le btn ou pas
  export let relief = false;

  // on fonction du theme on change la couleur du relief
  $: contour = $theme_mode_store === 'woo-claire' ? 'btn-contour-claire' : 'btn-contour-dark';
</script>

{#if relief}
  <!-- avec relief -->
  <div class={`h-fit w-fit p-1 rounded-full flex items-center hover:bg-base-200 ${contour}`}>
    <slot />
  </div>
{:else}
  <!-- sans relief -->
  <div class={`h-fit w-fit p-1 rounded-full flex items-center hover:bg-base-300`}>
    <slot />
  </div>
{/if}

<style>
  .btn-contour-claire {
    border-radius: 50px;
    background: linear-gradient(145deg, #ffffff, #d9dbdc);
    box-shadow: 5px 5px 10px #abadad, -5px -5px 10px #ffffff;
  }

  .btn-contour-dark {
    border-radius: 50px;
    background: linear-gradient(145deg, #32343a, #2a2c31);
    box-shadow: 5px 5px 10px #212326, -5px -5px 10px #3d3f46;
  }
</style>
