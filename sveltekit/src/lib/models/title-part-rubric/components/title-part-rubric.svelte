<script lang="ts">
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';

	export let text: string;
</script>

<h4 class="font-bold">{filterStringService.firstToUppperCase(text)}</h4>
