<script lang="ts">
  export let size = 'w-16 h-16';
  export let outline: boolean;
</script>

{#if outline}
  <!-- svg pour profil ou autre composant fixe -->
  <div class="h-fit w-fit p-3 rounded-full flex items-center bg-base-300">
    <svg xmlns="http://www.w3.org/2000/svg" class={`${size}`} viewBox="0 0 24 24" fill="none">
      <path
        d="M5 21C5 17.134 8.13401 14 12 14C15.866 14 19 17.134 19 21"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
      <path
        d="M12 11C14.2091 11 16 9.20914 16 7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7C8 9.20914 9.79086 11 12 11Z"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
  </div>
{:else}
  <!-- svg pure pour utilisation dans des liens ou bouton -->
  <svg xmlns="http://www.w3.org/2000/svg" class={`${size}`} viewBox="0 0 24 24" fill="none">
    <path
      d="M5 21C5 17.134 8.13401 14 12 14C15.866 14 19 17.134 19 21"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    />
    <path
      d="M12 11C14.2091 11 16 9.20914 16 7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7C8 9.20914 9.79086 11 12 11Z"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    />
  </svg>
{/if}
