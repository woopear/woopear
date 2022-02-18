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
