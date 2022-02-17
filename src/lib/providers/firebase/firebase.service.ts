import { fire_base_config } from './firebase.const';
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';

// init fire base
export const fire_app = initializeApp(fire_base_config);
// init fire auth
export const fire_auth = getAuth(fire_app);
// init fire firestore
export const fire_db = getFirestore(fire_app);
