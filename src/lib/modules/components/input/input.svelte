<script lang="ts">
  export let value = '';
  export let placeholder = '';
  export let name = '';
</script>

<input type="text" {name} {placeholder} class="input text-base w-full" bind:value />
