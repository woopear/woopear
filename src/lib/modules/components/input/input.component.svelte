<script lang="ts">
  export let span_text: string = '';
  export let input_text: string = '';
</script>

<section class="form-control">
  <span>{span_text}</span>
  <input type="text" class="input input-bordered" value={input_text} />
</section>
