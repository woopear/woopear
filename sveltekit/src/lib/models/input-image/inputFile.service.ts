import { inputImageAction } from './stores/inputImage.action';
import { inputImageApi } from "./stores/inputImage.api";
import { inputImageGetter } from './stores/inputImage.getter';
import { inputImageMutation } from './stores/inputImage.mutation';



export const inputImageService = {
  ...inputImageGetter,
  ...inputImageMutation,
  ...inputImageAction,
  ...inputImageApi
}