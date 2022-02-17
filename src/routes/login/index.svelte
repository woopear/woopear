<script lang="ts" context="module">
  import { browser } from '$app/env';

  export const load = async ({ session }) => {
    // si navigateur on test si stuff contient user si oui on va sur dashboard
    if (browser) {
      if (session.user) {
        return {
          status: 302,
          redirect: '/dashboard'
        };
      }
    }
    return {};
  };
</script>

<script lang="ts">
  import Login from '$lib/modules/login/components/login.svelte';
</script>

<Login />
