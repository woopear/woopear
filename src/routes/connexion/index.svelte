<script lang="ts" context="module">
  export const load = ({ session }) => {
    console.log('SESSION FRONT CONNEXION', session);

    if (session.user) {
      return {
        status: 302,
        redirect: '/dashboard'
      };
    }

    return {};
  };
</script>

<script lang="ts">
  import Connexion from '$lib/modules/connexion/components/connexion.svelte';
</script>

<section>
  <!-- connexion user simple (email, pwd) -->
  <Connexion />
</section>
