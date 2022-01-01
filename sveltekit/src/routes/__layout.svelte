<script lang="ts">
	import '../app.css';
	import Header from '$lib/models/header/components/header.svelte';
	import Footer from '$lib/models/footer/components/footer.svelte';
	import PageTransition from '$lib/models/page-transition/components/page-transition.svelte';
	import MenuFloat from '$lib/models/menu-float/components/menu-float.svelte';
	import { page } from '$app/stores';
	import Error from '$lib/models/error/components/error.svelte';
	import Notification from '$lib/models/notification/components/notification.svelte';
</script>

<Error />
<Notification />

<Header />

<PageTransition refresh={$page.path}>
	<MenuFloat />
	<slot />
</PageTransition>

<Footer />
