bool validateEmailForm(String value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  return (regex.hasMatch(value));
}

bool validatePasswordLength(String value, [int length = 6]) {
  return (value.length >= length);
}

bool validateConfirmPassword(String value, String confirmation) {
  return (value.trim() == confirmation.trim());
}
