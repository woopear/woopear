<script lang="ts">
	import { page } from '$app/stores';
	import { beforeUpdate } from 'svelte';

	beforeUpdate(() => {
		console.log($page);
	});
</script>

<p>new mot de passe</p>
