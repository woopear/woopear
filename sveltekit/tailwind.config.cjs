const config = {
	content: ['./src/**/*.{html,js,svelte,ts}'],

	theme: {
		extend: {
			fontFamily: {
				sans: ['"Nunito Sans"', '"sans-serif"']
			},
			colors: {
				fondPrincipalClaire: '#f5f5f7',
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
