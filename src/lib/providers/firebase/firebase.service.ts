import { fire_base_config } from './firebase.const';
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';
import { getStorage, ref } from 'firebase/storage';

// init fire base
export const fire_app = initializeApp(fire_base_config);
// init fire auth
export const fire_auth = getAuth(fire_app);
// init fire firestore
export const fire_db = getFirestore(fire_app);
// init fire storage
export const fire_storage = getStorage(fire_app);
// init ref storage path => /
export const ref_storage = ref(fire_storage);
// init ref storage path => /avatars
export const ref_storage_avatar = ref(fire_storage, 'avatars');
