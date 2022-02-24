<script lang="ts">
  import { session } from '$app/stores';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import ConditionTable from '$lib/modules/condition/components/condition-gen-table.svelte';
  import ConditionGenTypeTable from '$lib/modules/condition/components/condition-gen-type-table.svelte';
  import { condition_gen_store } from '$lib/modules/condition/condition.store';
  import { condition_gen_selected_store } from '$lib/modules/condition/store/condition-gen-selected.store';
  import { presentation_store } from '$lib/modules/presentation/presentation.store';
  import SpinnerLittle from '$lib/modules/spinner/components/spinner-little.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { beforeUpdate, onMount } from 'svelte';

  let loader = false;

  onMount(async () => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      current_user_store.getUser($session.user.uid);
    } else {
      // TODO : gerer probleme de connexion user ou de connexion
    }

    // si présentation n'est pas encore request on request
    if ($presentation_store.length === 0) {
      await presentation_store.getPresentation();
    }

    // si condition gen n'est pas encore request on request
    if ($condition_gen_store.length === 0) {
      condition_gen_store.listenConditionGen();
      loader = true;
    } else {
      loader = true;
    }
  });
</script>

<section class="w-full flex-1 sm:pl-6 sm:pt-6 sm:pb-6">
  <div class="mb-12">
    <Title title="Liste des conditions générales" type_title={ETypeTitle.H4} />
  </div>
  {#if loader}
    <!-- partie condition gen -->
    <ConditionTable />
  {:else}
    <SpinnerLittle />
  {/if}
</section>
