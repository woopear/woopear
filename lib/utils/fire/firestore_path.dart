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

  /// condition gene
  static String conditionGenes() => 'condition_genes';
  static String conditionGene(String idConditionGene) =>
      'condition_genes/$idConditionGene';
  static String conditionGeneArticles(String idConditionGene) =>
      'condition_genes/$idConditionGene/articles';
  static String conditionGeneArticle(
          String idConditionGene, String idArticle) =>
      'condition_genes/$idConditionGene/articles/$idArticle';
  static String conditionGeneArticleContents(
          String idConditionGene, String idArticle) =>
      'condition_genes/$idConditionGene/articles/$idArticle/contents';
  static String conditionGeneArticleContent(
          String idConditionGene, String idArticle, String idContent) =>
      'condition_genes/$idConditionGene/articles/$idArticle/contents/$idContent';
}
