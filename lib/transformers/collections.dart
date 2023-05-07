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

  // groups
  static const String groupsMaps = 'groupsMaps';
  static const String groups = 'groups';
  static const String teachersGroups = 'teachers';
  static const String studentsGroups = 'students';

  // home work
  static const String homeWorks = 'homeWorks';

  static String getRef(List<String> collections) {
    return collections.join('/');
  }
}
