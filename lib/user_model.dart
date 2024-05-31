import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  String confirmPassword;

  @HiveField(4)
  String phoneNumber;

  @HiveField(5)
  String address;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.address,
  });

  static Future<bool> validateUser(String email, String password) async {
  try {
    final box = await Hive.openBox<User>('users');
    final user = box.values.firstWhere(
      (user) => user.email == email && user.password == password,
    );
    return user != null;
  } catch (e) {
    // Tangani kesalahan di sini, misalnya tampilkan pesan atau log
    print('Error validating user: $e');
    return false;
  }
}

  toJson() {}
}
