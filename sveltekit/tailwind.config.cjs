const config = {
	content: ['./src/**/*.{html,js,svelte,ts}'],

	theme: {
		colors: {
			fondPrincipalClaire: '#ffffff',
			fondPrincipalDark: '#331133',
			color1: '#0057FF',
			color2: '#CC00FF',
			color3: '#FFB800',
			color4: '#19B500'
		},
		extend: {
			fontFamily: {
				sans: ['Roboto', 'sans-serif']
			}
		}
	},

	plugins: []
};

module.exports = config;
