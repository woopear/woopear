<script lang="ts">
  import { store_notification } from '../notification.store';
</script>

<section
  class=" alert shadow-lg alert-error rounded-lg fixed top-10 right-8 w-full sm:w-5/12 md:w-4/12 z-50"
>
  <div>
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="stroke-current flex-shrink-0 h-6 w-6"
      fill="none"
      viewBox="0 0 24 24"
      ><path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"
      /></svg
    >
    <span>Error! Task failed successfully.</span>
  </div>
</section>
