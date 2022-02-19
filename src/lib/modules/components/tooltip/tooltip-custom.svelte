<script lang="ts">
  export let text = '';
</script>

{#if text}
  <div class="absolute w-fit z-40 left-3 -top-7 flex-col items-center hidden mb-6 group-hover:flex">
    <p class="p-2 text-xs font-bold text-white bg-secondary shadow-lg">{text}</p>
    <div class="w-3 h-3 -mt-2 -left-0 rotate-45 bg-secondary" />
  </div>
{/if}
