<script lang="ts">
  import { session } from '$app/stores';
  import BtnCloseUpdate from '$lib/modules/components/btn/btn-close-update.svelte';
  import BtnUpdate from '$lib/modules/components/btn/btn-update.svelte';
  import BtnUser from '$lib/modules/components/btn/btn-user.svelte';
  import UserSvg from '$lib/modules/components/user-svg/user-svg.svelte';
  import Logout from '$lib/modules/logout/components/logout.svelte';
  import CompanieProfil from '$lib/modules/user/components/companie-profil.svelte';
  import UserProfil from '$lib/modules/user/components/user-profil.svelte';
  import { current_user_store } from '$lib/modules/user/user.store';
  import { onMount } from 'svelte';

  onMount(() => {
    // si session.user existe
    // on lance l'ecouteur sur le document user
    if ($session.user) {
      current_user_store.getUser($session.user.uid);
    }
  });
</script>

<p>connecter</p>

<Logout />
<UserProfil />
<CompanieProfil />
<!-- test sans relief -->
<div class="card px-12 py-4 bg-base-200 shadow-xl">
  <div class="card-action">
    <div class="flex justify-end">
      <BtnCloseUpdate changeUpdate={undefined} />
    </div>
    <BtnUpdate changeUpdate={undefined} />
    <UserSvg outline={true} />
    <BtnUser changeUpdate={undefined} size="w-6 h-6" color="text-primary" />
  </div>
</div>

<!-- test avec relief -->
<div class="card mt-12 px-12 py-4 bg-base-200 shadow-xl">
  <div class="card-action">
    <div class="flex justify-end">
      <BtnCloseUpdate relief={true} changeUpdate={undefined} />
    </div>
    <BtnUpdate relief={true} changeUpdate={undefined} />
    <UserSvg outline={true} />
    <BtnUser relief={true} changeUpdate={undefined} size="w-6 h-6" color="text-primary" />
  </div>
</div>
