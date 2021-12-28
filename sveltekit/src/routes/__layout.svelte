<script lang="ts">
	import '../app.css';
	import Header from '$lib/models/header/components/header.svelte';
	import Footer from '$lib/models/footer/components/footer.svelte';
	import PageTransition from '$lib/models/page-transition/components/page-transition.svelte';
	import MenuFloat from '$lib/models/menu-float/components/menu-float.svelte';
	import { page } from '$app/stores';
</script>

<MenuFloat />

<Header />

<PageTransition refresh={$page.path}>
	<slot />
</PageTransition>

<Footer />
