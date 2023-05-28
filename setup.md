

# you need to add photos for classes and grades in the file lib\core\constants\classes_images.dart
# you need to add the groups from the admin screen if not added
# you need to add initial users in the lib\data\fake_users.dart then add them from the admin screen(never add them directly from firebase)
# add time table from the admin screen and it will show accordingly for teachers and students
# a teacher can have multiple grades but a single class(math, biology...)
# to edit the student grades or teacher class you need to edit the enum TeacherClass or enum StudentGrade in the lib\models\user_model.dart
-- after adding a new element in the previous step you must do the following 
1) add the right id for the property you added for example   
@HiveField(2)
biology,     
@HiveField(3)
newClass,     
2) after adding all elements just run this command in the terminal (in the project path)
flutter packages pub run build_runner build --delete-conflicting-outputs

# in case of any questions or error just text me to help +201147497502