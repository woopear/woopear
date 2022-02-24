<script lang="ts">
  export let id: string;
</script>

{#if id}
  <section class="mb-12">
    <!-- title -->
    <section class="font-light mb-4 flex items-center">
      <slot name="title" />
      <span class="ml-4">
        <slot name="btn-delete" />
      </span>
    </section>

    <!-- content -->
    <slot name="input-content" />
  </section>
{/if}
