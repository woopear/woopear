<script lang="ts">
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { onMount } from 'svelte';
  import { fly } from 'svelte/transition';
  import BoxCount from './box-count.svelte';

  // pour stocker les jours, heure, minute, second
  let j;
  let h;
  let m;
  let s;

  // pour afficher / cacher le compteur
  let load_counter = false;

  /**
   * fonction qui recupere
   * @param date_end
   */
  const counter = (date_end: Date): void => {
    // date du moment de chargement de la page
    const date = new Date();
    // calcule du temps entre les deux dates
    const time = new Date(date_end.getTime() - date.getTime());
    // affectation jour, heure, minute, second
    j = time.getDate();
    h = time.getHours();
    m = time.getMinutes();
    s = time.getSeconds();
  };

  onMount(() => {
    // date prévue de sortie du site
    const date_end = new Date('2022/02/27');

    // toute les seconds
    setInterval(() => {
      counter(date_end);
      load_counter = true; // on met à true cela affiche le compteur, apres qu'il soit init
    }, 1000);
  });
</script>

<!-- waiting -->
<section class="w-full h-96 flex flex-col lg:flex-row">
  <!-- partie title -->
  <section class="text-center flex flex-col flex-1 items-center justify-center lg:items-end">
    <!-- title -->
    <div class="w-full md:w-11/12 lg:w-9/12 xl:w-7/12 md:m-auto lg:m-0 lg:mr-12">
      <Title type_title={ETypeTitle.H1} title="woopear.fr" />
      <p class="text-2xl">est en construction</p>
    </div>
  </section>

  <!-- partie conteur -->
  <section class="flex flex-col items-center lg:mr-32 justify-center flex-1">
    <!-- si compteur est init -->
    {#if load_counter}
      <section transition:fly={{ duration: 500 }}>
        <!-- sub title -->
        <div class="mb-2 text-center text-primary">
          <Title type_title={ETypeTitle.H4} title="Bientôt" />
        </div>

        <!-- le compteur -->
        <div class="grid grid-flow-col gap-5 text-center auto-cols-max">
          <!-- jour -->
          <BoxCount text_box="J" value_count={j} />

          <!-- heure -->
          <BoxCount text_box="H" value_count={h} />

          <!-- minute -->
          <BoxCount text_box="M" value_count={m} />

          <!-- second -->
          <BoxCount text_box="S" value_count={s} />
        </div>
      </section>
    {/if}
  </section>
</section>
