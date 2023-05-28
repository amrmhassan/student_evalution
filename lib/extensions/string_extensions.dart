extension StringExtensions on String {
  String get captalize => substring(0, 1).toUpperCase() + substring(1);
}
