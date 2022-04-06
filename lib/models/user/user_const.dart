class UserConst {
  /// connexion user
  static String connexionTitle = "Connexion Woopear";
  static String connexionMessageSucces = 'Connexion réussis';
  static String connexionMessageEmailError = "Erreur identifiant";
  static String connexionMessagePasswordError = 'Erreur mot de passe';
  static String connexionMessageError = "Impossible de vous connecter";
  static String connexionLabelInputEmail = "Identifiant *";
  static String connexionLabelInputPassword = "Mot de passe *";
  static String connexionBtn = "SE CONNECTER";
  static String connexionBtnPasswordForgot = "Mot de passe oublié ?";
  static String connexionTooltipBtn = "Connecter vous";
  static String connexionInfoForm = "* Champs obligatoire";

  /// creation user
  static String createTitle = 'Créer mon compte Woopear';
  static String createMessageSucces = 'Création réussis';
  static String createMessageRoleError = "Vous devez selectionner un role";
  static String createMessageEmailError = "L'email existe déjà";
  static String createMessageSendEmailError =
      "Impossible d'envoyer l'email de connexion";
  static String createMessagePasswordError =
      'Le mot de passe fourni est trop faible';
  static String createMessageError = "Impossible de creer l'utilisateur";
  static String createLabelInputEmail = "Adresse email *";
  static String createLabelInputPassword = "Mot de passe *";
  static String createLabelInputFirstName = "Prénom *";
  static String createLabelInputLastName = "Nom *";
  static String createLabelInputAddress = "Addresse *";
  static String createLabelInputCodePost = "Code postal *";
  static String createLabelInputCity = "Ville *";
  static String createLabelInputPhoneNumber = "Téléphone";
  static String createBtn = "CREER MON COMPTE";
  static String createTooltipBtn = "Créer un utilisateur";
  static String createBtnResetInput = "EFFACER LE FORMULAIRE";
  static String createTooltipBtnResetInput = "Effacer tous le formulaire";
  static String createInfoForm = "* Champs obligatoire";
  static String createPlaceholderDropdownRole = "Selectionnez un role *";
  static String createBtnSeeFormCompanie = "Ajouter une entreprise";
  static String createBtnCloseFormCompanie = "Fermer";
  static String createUrlRedirectSendMail =
      "http://localhost:60589/#/create/account";

  /// creation companie
  static String createCompanieTitleForm = "Ajout d'une entreprise";
  static String createCompanieInputDenomination = "Dénomination *";
  static String createCompanieInputSiret = "Numéro de siret *";
  static String createCompanieInputCodeNaf = "Code naf *";
  static String createCompanieInputAddressCompanie = "Addresse";
  static String createCompanieInputCodePostCompanie = "Code postal";
  static String createCompanieInputCityCompanie = "Ville";
  static String createCompanieInputLogoCompanie = "Image entreprise";

  /// mot de passe oublier
  static String forgotMessageError = "Une erreur est suvenue rééssayer !";
  static String forgotMessageSucces = "Email envoyé avec succès !";
  static String forgotInputEmail = "Votre addresse e-mail *";
  static String forgotTextInfoForm = "Recevez un e-mail, pour modiifer votre mot de passe.";
  static String forgotInfoForm = "* Champs obligatoire";
  static String forgotBtn= "ENVOYER";
}
