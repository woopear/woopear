//import adapter from '@sveltejs/adapter-auto';
import adapter from '@sveltejs/adapter-static';
//import adapter from '@sveltejs/adapter-node';
//import adapter from 'svelte-adapter-firebase';
import preprocess from 'svelte-preprocess';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  // Consult https://github.com/sveltejs/svelte-preprocess
  // for more information about preprocessors
  preprocess: [
    preprocess({
      postcss: true
    })
  ],

  kit: {
    adapter: adapter({ assets: 'build' })
  }
};

export default config;
