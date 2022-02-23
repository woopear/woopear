<script lang="ts">
  import { session } from '$app/stores';
  import Title from '$lib/modules/components/title/title.svelte';
  import { ETypeTitle } from '$lib/modules/components/title/title.type';
  import { store_notification } from '$lib/modules/notification/store/notification.store';
  import CompanieProfil from '$lib/modules/user/components/companie-profil.svelte';
  import UserProfil from '$lib/modules/user/components/user-profil.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { onMount } from 'svelte';

  onMount(() => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      current_user_store.getUser($session.user.uid);
      store_notification.listenNotificationUser($current_user_store.uid);
    }
  });
</script>

<div class="mb-16">
  <Title title={`Bonjour ${$current_user_store.user_name}`} type_title={ETypeTitle.H4} />
</div>
<!-- box profil -->
<section
  class="w-full flex items-center flex-col lg:place-items-stretch lg:flex-row md:justify-evenly"
>
  <UserProfil />
  <div class="mb-12 lg:hidden" />
  <CompanieProfil />
</section>
