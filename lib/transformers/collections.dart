class DBCollections {
  static const String users = 'users';
  static const String rooms = 'rooms';
  static const String attendance = 'attendance';
  static const String behavior = 'behavior';

  static String getRef(List<String> collections) {
    return collections.join('/');
  }
}
