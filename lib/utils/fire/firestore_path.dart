class FirestorePath {
  /// profil
  static String profils() => 'profils';
  static String profil(String idProfil) => 'profils/$idProfil';

  /// users
  static String users() => 'users';
  static String user(String uid) => 'users/$uid';

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
