class Validations {
  static String? validateEmail(String inputString) {
    //checks empty string
    final value = checkEmpty(inputString);
    if (value != null) {
      return value;
    }

    //if empty then it won't proceed to below lines of code.
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    final hasMatch = emailRegex.hasMatch(inputString);

    return hasMatch ? null : "Please ! Provide valid email format";
  }

  static String? isValidName(String inputString) {
    //checks empty string
    final value = checkEmpty(inputString);
    if (value != null) {
      return value;
    }

    //if empty then it won't proceed to below lines of code.
    if (inputString.length < 3) {
      return 'Please enter your full name as in IC/Passport';
    } else if (!RegExp(r'^[a-zA-Z -]*$').hasMatch(inputString)) {
      return 'Name cannot contain numbers or special characters except hyphen';
    }
    return null;
  }

  static String? validatePassword(String inputString) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
    );
    final hasMatch = passwordRegex.hasMatch(inputString);

    return hasMatch ? null : "Please! Provide stronger password";
  }

  static String? checkEmpty(String inputString) {
    if (inputString.isEmpty) {
      return "The Field cannot be empty";
    }
    return null;
  }
}
