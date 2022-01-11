<script lang="ts">
	import BoxPartRubric from '$lib/models/box-part-rubric/components/box-part-rubric.svelte';
	import BoxRubric from '$lib/models/box-rubric/components/box-rubric.svelte';
	import LogoPencil from '$lib/models/logo/components/logo-pencil.svelte';
	import TitlePartRubric from '$lib/models/title-part-rubric/components/title-part-rubric.svelte';
	import { filterStringService } from '$lib/providers/filter-string/filter-string.service';
	import { userStore } from '../stores/user.store';
</script>

{#if $userStore.userCurrent.id}
	<BoxRubric addStyle="w-72" addStyleDiv="p-4">
		<!-- title box -->
		<div class="flex justify-between items-center">
			<h1 class="font-bold text-lg">Mon profil</h1>
			<LogoPencil handlerClick={undefined} />
		</div>

		<!-- partie affichage -->
		<section>
			<section class="flex flex-col items-center my-4">
				<!-- img -->
				<div
					class="rounded-full bg-cover bg-center h-16 w-16 mb-2"
					style={$userStore.userCurrent.avatar
						? `background-image: url("${import.meta.env.VITE_URL_API_IMG}${
								$userStore.userCurrent.avatar.url
						  }");`
						: "background-image: url('../../../../../static/image-found.png');"}
				/>
				<!-- user name -->
				<p>{$userStore.userCurrent.username.toUpperCase()}</p>
			</section>
			<section>
				<!-- user email -->
				<BoxPartRubric>
					<TitlePartRubric text="email : " />
					<p>{$userStore.userCurrent.email}</p>
				</BoxPartRubric>
				<!-- user adresse -->
				<BoxPartRubric>
					<TitlePartRubric text="adresse : " />
					<p>{$userStore.userCurrent.adresse}</p>
					<p>
						{$userStore.userCurrent.codePost}
						{filterStringService.firstToUppperCase($userStore.userCurrent.city)}
					</p>
				</BoxPartRubric>
				<!-- user tel -->
				<BoxPartRubric>
					<TitlePartRubric text="Numéro : " />
					<p>{$userStore.userCurrent.phoneNumber}</p>
				</BoxPartRubric>
			</section>
		</section>

		<!-- partie modification -->
	</BoxRubric>
{/if}
