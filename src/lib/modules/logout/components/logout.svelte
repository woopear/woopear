<script lang="ts">
  import { goto } from '$app/navigation';
  import { session } from '$app/stores';
  import { fire_auth } from '$lib/providers/firebase/firebase.service';
  import { signOut } from 'firebase/auth';

  const deconnect = async () => {
    await signOut(fire_auth);
    $session.user = null;
    goto('/connexion');
  };
</script>

<button on:click={deconnect}>Se deconnecter</button>
