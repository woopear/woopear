<script lang="ts">
  import { ETypeTitle } from './title.type';

  // donne un type h1, h2, h3 etc ....
  export let type_title: ETypeTitle;
  // le titre de la balise
  export let title: string;
</script>

<!-- si title et type title sont définis -->
{#if type_title && title}
  {#if type_title === ETypeTitle.H1}
    <h1 class="text-5xl font-bold">{title}</h1>
  {:else if type_title === ETypeTitle.H2}
    <h2 class="text-5xl font-thin">{title}</h2>
  {:else if type_title === ETypeTitle.H3}
    <h3 class="text-3xl font-bold">{title}</h3>
  {:else if type_title === ETypeTitle.H4}
    <h4 class="text-3xl font-light">{title}</h4>
  {:else if type_title === ETypeTitle.H5}
    <h5 class="text-2xl font-bold">{title}</h5>
  {:else if type_title === ETypeTitle.H6}
    <h6 class="text-2xl font-light">{title}</h6>
  {/if}
{/if}
