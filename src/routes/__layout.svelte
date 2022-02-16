<script>
  import '../app.css';
  import Main from '$lib/modules/main/components/main.svelte';
  import HeaderHome from '$lib/modules/header/header-home.component.svelte';
  import Footer from '$lib/modules/footer/footer.component.svelte';
</script>

<!-- header -->
<HeaderHome />

<!-- main -->
<Main>
  <slot />
</Main>

<!-- footer -->
<Footer />
