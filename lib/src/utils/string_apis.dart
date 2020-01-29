extension EmptyStrings on String {
  bool get isNullEmptyOrWhitespace =>
      this == null || this.isEmpty || this.trim().isEmpty;
}

extension GeneralUtilsObjectExtension on Object {
  /// Returns true if object is:
  /// - null
  bool get isNull => this == null;

  /// Returns true if object is NOT:
  /// - null
  bool get isNotNull => this != null;

  /// Returns true if object is:
  /// - null
  /// - empty (string, list, map)
  bool get isNullOrEmpty =>
      this == null || this == '' || this == [] || this == {};

  /// Returns true if object is:
  /// - null
  /// - empty (string, list, map)
  /// - false
  bool get isNullEmptyOrFalse =>
      this == null || this == '' || this == [] || this == {} || !this;

  /// Returns true if object is:
  /// - null
  /// - empty (string, list, map)
  /// - false
  /// - zero
  bool get isNullEmptyFalseOrZero =>
      this == null ||
      this == '' ||
      this == [] ||
      this == {} ||
      !this ||
      this == 0;
}
