const config = {
  mode: 'jit',
  content: ['./src/**/*.{html,js,svelte,ts}'],

  theme: {
    extend: {
      fontFamily: {
        sans: ['Montserrat', 'sans-serif']
      }
    }
  },

  plugins: [require('daisyui')],

  daisyui: {
    themes: [
      {
        'woo-claire': {
          primary: '#0090E1',
          'primary-focus': '#40BAFF',
          'primary-content': '#ffffff',
          secondary: '#AD00FF',
          'secondary-focus': '#C854FF',
          'secondary-content': '#ffffff',
          accent: '#FFE500',
          'accent-focus': '#E3CC00',
          'accent-content': '#ffffff',
          neutral: '#36393F',
          'neutral-focus': '#2a2e37',
          'neutral-content': '#ffffff',
          'base-100': '#ffffff',
          'base-200': '#F1F3F4',
          'base-300': '#AFBAC0',
          'base-content': '#313131',
          info: '#0090E1',
          success: '#18AC00',
          warning: '#ff9900',
          error: '#D4213F'
        },
        'woo-dark': {
          primary: '#0090E1',
          'primary-focus': '#40BAFF',
          'primary-content': '#ffffff',
          secondary: '#AD00FF',
          'secondary-focus': '#C854FF',
          'secondary-content': '#ffffff',
          accent: '#FFE500',
          'accent-focus': '#E3CC00',
          'accent-content': '#ffffff',
          neutral: '#ffffff',
          'neutral-focus': '#F1F3F4',
          'neutral-content': '#000000',
          'base-100': '#36393F',
          'base-200': '#2F3136',
          'base-300': '#202225',
          'base-content': '#ffffff',
          info: '#0090E1',
          success: '#18AC00',
          warning: '#ff9900',
          error: '#D4213F'
        }
      }
    ]
  }
};

module.exports = config;
