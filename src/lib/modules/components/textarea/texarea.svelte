<script lang="ts">
  export let rows = 4;
  export let width = 'w-full lg:w-6/12';
  export let name = '';
  export let value = '';
  export let placeholder = 'Mon contenu';
</script>

<textarea {name} class={`${width} block rounded-lg p-2 textarea`} bind:value {placeholder} {rows} />
