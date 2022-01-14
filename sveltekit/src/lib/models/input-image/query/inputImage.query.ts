import { gql } from 'graphql-request';


export const inputImageQuery ={
  createImage: gql`
  mutation uploadNewImage($file: Upload!){
    upload(file: $file){
      id
      name
      url
      size
      mime
      ext
      hash
      formats
      height
      width
      caption
      alternativeText
    }
  }
  `,

}