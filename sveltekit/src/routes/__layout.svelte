<script context="module" lang="ts">
	import '../app.css';
	import Header from '$lib/models/header/components/header.svelte';
	import Footer from '$lib/models/footer/components/footer.svelte';
	import PageTransition from '$lib/models/page-transition/components/page-transition.svelte';
	import MenuFloat from '$lib/models/menu-float/components/menu-float.svelte';
	import { page } from '$app/stores';
	import Error from '$lib/models/error/components/error.svelte';
	import Notification from '$lib/models/notification/components/notification.svelte';
	import type { IFooterReceved } from '$lib/models/footer/types/footer.type';
	import type { IPresentationReceved } from '$lib/models/presentation/types/presentation.type';
	import type { IContactReceved } from '$lib/models/contact/types/contact.type';
	import InfoBulle from '$lib/models/info-bulle/components/info-bulle.svelte';
	import ForgotPassword from '$lib/models/forgot-password/components/forgot-password.svelte';

	// eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types
	export const load = async ({ fetch }) => {
		const resFooter = await fetch('/api/footer.json');
		const resPrenstation = await fetch('/api/presentation.json');
		const resContact = await fetch('/api/contact.json');
		if (resFooter.ok && resPrenstation.ok && resContact.ok) {
			const { footer } = (await resFooter.json()) as IFooterReceved;
			const { presentation } = (await resPrenstation.json()) as IPresentationReceved;
			const { contact } = (await resContact.json()) as IContactReceved;

			return {
				props: {
					footer,
					presentation,
					contact
				}
			};
		} else {
			return {
				props: {
					error: `Impossible de charger /api/footer`
				}
			};
		}
	};
</script>

<script lang="ts">
	export let footer;
	export let presentation;
	export let contact;
</script>

<Error />
<Notification />
<InfoBulle infoBulleError={true} />
<InfoBulle infoBulleError={false} />
<ForgotPassword />

<Header />

<PageTransition refresh={$page.path}>
	<MenuFloat />
	<slot />
</PageTransition>

<Footer {footer} {contact} {presentation} />
