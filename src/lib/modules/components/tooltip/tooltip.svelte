<script lang="ts">
  export let data: string;
  export let direction = 'tooltip-bottom';
</script>

{#if data}
  <div data-tip={data} class={`${direction} tooltip tooltip-secondary z-50`}>
    <slot />
  </div>
{/if}
