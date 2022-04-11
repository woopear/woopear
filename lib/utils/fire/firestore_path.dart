class FirestorePath {
  /// profil
  static String profils() => 'profils';
  static String profil(String idProfil) => 'profils/$idProfil';

  /// users
  static String users() => 'users';
  static String user(String uid) => 'users/$uid';

  /// presentation
  static String presentations() => 'presentations';
  static String presentation(String idPresentation) =>
      'presentations/$idPresentation';
  static String presentationContents(String idPresentation) =>
      'presentations/$idPresentation/contents';
  static String presentationContent(String idPresentation, String idContent) => 'presentations/$idPresentation/contents/$idContent';
}
