class Validator {
  static String? valid(String? value) {
    if (value!.isEmpty) {
      return "can't be empty";
    }
    return null;
  }

  static String? emailvalid(String? value) {
    bool emailvalidate = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (!emailvalidate) {
      return "invalid email address";
    }
    return null;
  }

  static String? dropdownvalid(var value) => value == null
      ? 'Select a item'
      : (value == 'admin')
          ? 'no access'
          : null;
}
