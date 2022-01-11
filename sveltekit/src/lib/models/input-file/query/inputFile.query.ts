import { gql } from 'graphql-request';


export const inputFileQuery ={
  /** 
   * modifier le file
  */

  updateInputFile: gql`
  mutation UpdateFile($id:Id!, $info:FileInfoInput! ){
    updateFileInfo(id: $id, info: $info){
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
  `
}