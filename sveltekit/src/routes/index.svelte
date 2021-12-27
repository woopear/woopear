<script lang="ts">
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import BtnLinkText from '$lib/models/btn-link-text/components/btn-link-text.svelte';
	import LogoDarkMode from '$lib/models/logo/components/logo-dark-mode.svelte';
	import SubTitleRubric from '$lib/models/sub-title-rubric/components/sub-title-rubric.svelte';
	import TitleRubric from '$lib/models/title-rubric/components/title-rubric.svelte';
</script>

<p>coucou</p>
<LogoDarkMode />

<BoxRubric>
	<TitleRubric title="je suis le title" />
	<SubTitleRubric subTitle="je suis le subtitle" />
	<BtnLinkText myClick={undefined} textBtn="En savoir plus" />
</BoxRubric>
