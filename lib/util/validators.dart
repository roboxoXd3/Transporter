class Validators {
  static String required(String value, {String errorText}) {
    if (value == null || value.isEmpty) {
      return errorText ?? 'This field cannot be empty';
    }
    return null;
  }

  static String isNumeric(String value, {String errorText}) {
    if (value == null || double.tryParse(value) == null) {
      return errorText ?? 'This field must be numeric';
    }
    return null;
  }

  static String isURL(String value, {String errorText}) {
    if (!Uri.parse(value).isAbsolute) {
      return errorText ?? 'This field requires a valid URL address';
    }
    return null;
  }

  static String mustEmail(String value, {String errorText}) {
    if (Validators.required(value) != null) {
      return Validators.required(value, errorText: errorText);
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return errorText ?? 'This field requires a valid email address';
    }
    return null;
  }

  static String mustNumeric(String value, {String errorText}) {
    if (Validators.required(value) != null) {
      return Validators.required(value, errorText: errorText);
    }
    if (Validators.isNumeric(value) != null) {
      return Validators.isNumeric(value, errorText: errorText);
    }
    return null;
  }

  static String mustURL(String value, {String errorText}) {
    if (Validators.required(value) != null) {
      return Validators.required(value, errorText: errorText);
    }
    if (Validators.isURL(value) != null) {
      return Validators.isURL(value, errorText: errorText);
    }
    return null;
  }
}
