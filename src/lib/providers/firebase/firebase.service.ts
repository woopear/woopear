// Import the functions you need from the SDKs you need
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
//import { getAnalytics } from 'firebase/analytics';
import { firebaseConfig } from './firebase.const';

// init Firebase
export const fire_app = initializeApp(firebaseConfig);
// init auth
export const fire_auth = getAuth();
// init analytic
//export const analytics = getAnalytics(fire_app);
