<script lang="ts">
  // valeur à afficher (est modifier par le parent)
  export let value_count;
  // le text afficher en dessous de la box du chiffre
  export let text_box: string;
</script>

<!-- box d'affichage des chiffre du compteur -->
<div class="flex flex-col p-2 bg-neutral rounded-box text-neutral-content">
  <span class="font-mono text-5xl countdown">
    <span style={`--value:${value_count}`} />
  </span>
  {text_box}
</div>
