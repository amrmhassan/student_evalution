class DBCollections {
  // firestore
  static const String users = 'users';
  static const String attendance = 'attendance';
  static const String behavior = 'behavior';

  // realtime databases
  static const String rooms = 'rooms';
  static const String messages = 'messages';
  static const String createdAt = 'createdAt';
  static const String otherUser = 'otherUser';

  static String getRef(List<String> collections) {
    return collections.join('/');
  }
}
