const config = {
	content: ['./src/**/*.{html,js,svelte,ts}'],

	theme: {
		extend: {
			fontFamily: {
				sans: ['"M PLUS Rounded 1c"', '"sans-serif"']
			},
			colors: {
				fondPrincipalClaire: '#ffffff',
				fondPrincipalDark: '#331133',
				colorone: '#0057FF',
				colortwo: '#CC00FF',
				colorthree: '#FFB800',
				colorfour: '#19B500'
			}
		}
	},

	plugins: []
};

module.exports = config;
