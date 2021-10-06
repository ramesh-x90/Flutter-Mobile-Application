class Validator {
  static String? valid(String? value) {
    if (value!.isEmpty) {
      return "can't be empty";
    }
    return null;
  }
}
