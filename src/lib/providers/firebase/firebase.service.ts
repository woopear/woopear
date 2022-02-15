// Import the functions you need from the SDKs you need
import { initializeApp } from 'firebase/app';
import { getAnalytics } from 'firebase/analytics';
import { firebaseConfig } from './firebase.const';

// Initialize Firebase
export const fire_app = initializeApp(firebaseConfig);
export const analytics = getAnalytics(fire_app);
