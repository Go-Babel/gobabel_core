bool shouldAutomaticallyBeConsideredAValidString(String value) {
  final RegExp namePattern = RegExp(r'^[A-Z][a-z]+$');
  return namePattern.hasMatch(value);
}
