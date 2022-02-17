<script lang="ts" context="module">
  export const load = async ({ url, session }) => {
    // on test si la connexion user est toujours active
    // on attends d'etre sur d'avoir la réponse et on affecte le stuff.user
    const testConnexion = async () => {
      return new Promise((res, rej) => {
        onAuthStateChanged(fire_auth, (user) => {
          if (user) {
            session.user = user;
            res(true);
          } else {
            session.user = user;
            res(true);
          }
        });
      });
    };

    // execute test connexion
    await testConnexion();

    // si navigateur et si déconnecter et si l'url est non public on redirige
    if (browser) {
      if (!session.user && !public_page.includes(url.pathname)) {
        console.log('deconnecter');
        return {
          status: 302,
          redirect: '/login'
        };
      }
    }

    // retourne props + promise
    return {
      props: {
        promise: new Promise((res, rej) => res(true))
      }
    };
  };
</script>

<script lang="ts">
  import '../app.css';
  import Main from '$lib/modules/main/components/main.svelte';
  import HeaderHome from '$lib/modules/header/component/header-home.component.svelte';
  import Footer from '$lib/modules/footer/component/footer.component.svelte';
  import { fire_auth } from '$lib/providers/firebase/firebase.service';
  import { browser } from '$app/env';
  import { onAuthStateChanged } from 'firebase/auth';
  import { public_page } from '$lib/providers/public-page/public-page.service';
  import { onMount } from 'svelte';

  // activation du loader
  let loader: boolean;
  // promise de la fonction load
  export let promise;

  onMount(async () => {
    loader = false;
    // on attends que le load ai finis
    await promise;
    loader = true;
  });
</script>

<!-- header -->
<HeaderHome />

{#if loader}
  <Main>
    <slot />
  </Main>
{:else}
  <!-- TODO : implementer loader -->
  en chargement ...
{/if}

<!-- footer -->
<Footer />
