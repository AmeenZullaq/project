abstract class AppValidators {
  static String? validateEmail(String? email) {
    var regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!regExp.hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characturs';
    }
    return null;
  }

  static String? validateUserName(String? userName) {
    if (userName == null || userName.isEmpty) {
      return 'UserName is required';
    }
    if (userName.length < 3) {
      return 'UserName must be at least 3 characturs';
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    // var regExp = RegExp(r'^\d{10}$');
    var regExp = RegExp(r'^(\+963|0)?[1-9]\d{8}$');

    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    }
    if (!regExp.hasMatch(phoneNumber)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Otp is required';
    }
    if (value.length != 6) {
      return 'Otp must be 6 digits';
    }
    return null;
  }
}
