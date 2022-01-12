import { gql } from 'graphql-request';


export const inputImageQuery ={
  /** 
   * modifier le Image
  */

  updateInputImage: gql`
    mutation UpdateImage($id:Id!, $info:fileInfoInput! ){
    updateImageInfo(id: $id, info: $info){
      id
      created_at
      name
      alternativeText
      caption
      width
      height
      formats
      hash
      ext
    }
  }
  `,

  createImage: gql`
  mutation uploadNewImage($Image: Upload!){
    upload(Image: $Image){
      id
      name
      alternativeText
      formas
    }
  }
  `
}