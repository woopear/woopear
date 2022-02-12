// TODO : METTRE LES DONNEES DANS .ENV

// Import the functions you need from the SDKs you need
import { initializeApp } from 'firebase/app';
import { getAnalytics } from 'firebase/analytics';
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
	apiKey: 'AIzaSyCk3EsBMGuKen3ReU88chxg7tb_7ogS0Gw',
	authDomain: 'woopear-24a22.firebaseapp.com',
	projectId: 'woopear-24a22',
	storageBucket: 'woopear-24a22.appspot.com',
	messagingSenderId: '993782046139',
	appId: '1:993782046139:web:14da553cb1b360da6ef89e',
	measurementId: 'G-E0WGBWKH5Y'
};

// Initialize Firebase
export const fire_app = initializeApp(firebaseConfig);
export const analytics = getAnalytics(fire_app);
