


abstract class ValidationErrorsCst {
  ValidationErrorsCst._(); 
  
  
  /// USER NAME
  static const userNameNotTyped = {
    "title": "user name not valid",
    "subject": "you must add a user name! "
  };
  static const userNameIncorrect = {
    "title": "user name incorrect",
    "subject": "try again! "
  };
  static const userNameAlreadyUsed = {
    "title": "user name already used",
    "subject": "try another one!"
  };

  /// EMAIL
  static const emailNotTyped = {
    "title": "email not valid",
    "subject": "you must add an email "
  };
  static const emailIncorrect = {
    "title": "email incorrect",
    "subject": "try again! "
  };
  static const emailAlreadyUsed = {
    "title": "email already used",
    "subject": "try another one!"
  };

  /// PASSWORD
  static const passwordNotTyped = {
    "title": "password not valid",
    "subject": "you must add a user name! "
  };
  static const passwordSmall = {
    "title": "password is small",
    "subject": "add a some characters!"
  };

  /// PHONENUMBER
  static const phoneNumberNotTyped = {
    "title": "phone number not valid",
    "subject": "you must add an email "
  };
  static const phoneNumberIncorrect = {
    "title": "phone number incorrect",
    "subject": "try again! "
  };
  static const phoneNumberAlreadyUsed = {
    "title": "phone number already used",
    "subject": "try another one!"
  };

  /// Link
  static void linkNotTyped(String? webSiteName) => {
        "title": "link not valid",
        "subject": "you must add a ${webSiteName ?? "web site"} link "
      };
  static void linkIncorrect(String? webSiteName) => {
        "title": "${webSiteName ?? "this"} link incorrect",
        "subject": "try again! "
      };
  static void linkAlreadyUsed(String? webSiteName) => {
        "title": "${webSiteName ?? "this"} link already used",
        "subject": "try another one!"
      };
}

/// Probabilities :
// not typed,
// incorrect expression
// alredy used
