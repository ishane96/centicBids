import 'package:email_validator/email_validator.dart';

class AuthValidator {
  static String _responseValue;

  static dynamic validateName(String value) {
    _responseValue = null;
    if (value.isNotEmpty) {
      if (value.length < 2) {
        _responseValue = 'Invalid name (Min : 2 Characters)';
      }
    } else {
      _responseValue = 'Please fill name';
    }

    return _responseValue;
  }

  static dynamic validateEmail(String value) {
    _responseValue = null;

    if (value.isNotEmpty) {
      if (!EmailValidator.validate(value)) {
        _responseValue = 'Please check your email.';
      }
    } else {
      _responseValue = 'Please enter your email';
    }
    return _responseValue;
  }

  static dynamic validatePassword(String value) {
    _responseValue = null;
    if (value.isNotEmpty) {
      if (value.length < 8) {
        _responseValue = 'Invalid password (Min : 8 Characters)';
      }
    } else {
      _responseValue = 'Please fill password';
    }

    return _responseValue;
  }

  static dynamic validateRetypePassword(String password, String value) {
    _responseValue = null;
    if (value.isNotEmpty) {
      if (value.length < 8) {
        _responseValue = 'Invalid retype password (Min : 8 Characters)';
      } else {
        if (password != value) {
          _responseValue = 'Mismatching passwords, Please recheck';
        }
      }
    } else {
      _responseValue = 'Please fill same password';
    }

    return _responseValue;
  }
}
