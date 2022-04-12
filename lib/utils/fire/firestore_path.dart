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
  static String presentationContent(String idPresentation, String idContent) =>
      'presentations/$idPresentation/contents/$idContent';

  /// footer
  static String footers() => 'footers';
  static String footer(String idFooter) => 'footers/$idFooter';
  static String footerMenus(String idFooter) => 'footers/$idFooter/menus';
  static String footerMenu(String idFooter, String idFooterMenu) =>
      'footers/$idFooter/menus/$idFooterMenu';

  /// content
  static String contents() => 'contents';
  static String content(String idContent) => 'contents/$idContent';

  /// condition generale
  static String conditionsGene() => 'conditions_generales';
  static String conditionGene(String idConditionGene) =>
      'conditions_generales/$idConditionGene';

  /// article condition generale
  static String articlesConditionGene(String idConditionGene) =>
      'conditions_generales/$idConditionGene/articles_conditions_generales';
  static String articleConditionGene(
          String idConditionGene, String idArticleConditionGene) =>
      'conditions_generales/$idConditionGene/articles_conditions_generales/$idArticleConditionGene';
}
