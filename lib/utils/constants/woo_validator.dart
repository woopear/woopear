class WooValidator {
  /// text error de validation input profil + user + companie
  static String errorInputEmail = "Veuillez entrer un email valide";
  static String errorInputPassword = "Veuillez entrer un mot de passe valide";
  static String errorInputFirstName = "Veuillez entrer un prénom valide";
  static String errorInputLastName = "Veuillez entrer un nom valide";
  static String errorInputAddresse = "Veuillez entrer une addresse valide";
  static String errorInputCodePost = "Veuillez entrer un code postal valide";
  static String errorInputCity = "Veuillez entrer une ville valide";
  static String errorInputDenomination = "Veuillez entrer une dénomination valide";
  static String errorInputSiret = "Veuillez entrer un numero de siret valide";
  static String errorInputCodeNaf = "Veuillez entrer un code naf valide";
  static String errorInputPhoneNumber = "Veuillez entrer un numéro de téléphone";

  /// text error de validation input presentation + presentation content
  static String errorInputTitlePresentation = "Veuillez entrer un titre valide";

  /// regex pour validator email
  static final RegExp _emailRegex =
      RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");

  /// validator pour les input text basic
  /// test si null ou si isEmpty
  static validatorInputTextBasic({String? textError, String? value}) {
    if (value == null || value.isEmpty) {
      return textError;
    }
    return null;
  }

  /// validator le contenue du input email
  /// test si null ou si isEmpty et la regex
  static validateEmail({String? textError, String? value}) {
    if (value == null || value.isEmpty || !_emailRegex.hasMatch(value)) {
      return textError;
    }
    return null;
  }

  /// validator le contenue du input password
  /// test si value est superieur à 6 caractere
  static validatePassword({String? textError, String? value}) {
    return value!.length < 6 ? textError : null;
  }
}
