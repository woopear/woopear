<script lang="ts">
	import BoxRubricColor from '$lib/models/box-rubric/components/box-rubric-color.svelte';
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
	import type { IContact } from '../types/contact.type';

	export let contact: IContact;
</script>

<BoxRubricColor color="bg-[#F3C2FF] dark:bg-[#410052] transition-all duration-300">
	<TitleRubric title="Contactez nous" addStyle="mt-12 text-center" />
	<SubTitleRubric subTitle={`${contact.info} - ${contact.phoneNumber}`} addStyle="text-center" />
	<BoxRubric addStyle="mt-12">
		<p>coucou</p>
	</BoxRubric>
</BoxRubricColor>
