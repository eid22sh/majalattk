/// class of input validation
/// validate diffrent type of inputs

class Validator {
  ///email regular expression
  static RegExp _mailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  ///phone regular expression
  static RegExp _phoneRegExp =
      RegExp(r'^\d$'); /*RegExp(r"^(?:){6,14}[0-9]$");*/

  ///validate String inputs if it is empty
  static String validateText(String value) {
    if (value.isEmpty) {
      return "* Required";
    }
    return null;
  }

  /// validate email input
  static String validateEmail(String email) {
    if (email.isEmpty) {
      return "* Required";
    }
    if (!_mailRegExp.hasMatch(email)) {
      return "Email not valide";
    }
    return null;
  }

  ///validate phone numbers
  static String validatePhone(String phone) {
    if (phone.isEmpty) {
      return "* Required";
    } else if (!_phoneRegExp.hasMatch(phone)) {
      if (phone.length < 7 || phone.length > 10) return "Not phone number";
    }
    return null;
  }

  ///validate password input
  static String validatePassword(String password) {
    if (password.isEmpty) {
      return "* Required";
    } else if (password.length < 6) {
      return "Password must have 6 digits";
    }
    return null;
  }
}
