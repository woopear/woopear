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

  deleteImage: gql`
  mutation deleteImage($id: ID!){
    deleteFile(input: {where:{id:$id}}){
      file{
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
  }
  `
}