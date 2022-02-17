import { fire_base_config } from './firebase.const';
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';

export const fire_app = initializeApp(fire_base_config);
export const fire_auth = getAuth(fire_app);
