import 'package:shared_preferences/shared_preferences.dart';
import 'package:pioneer_project/models/user.dart';

class UserPreferenceController {
  Future<void> saveUser({required User user, required String token}) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
    await prefs.setString('role', user.role);
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Optional: get full user object
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final id = prefs.getInt('user_id');
    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');
    final role = prefs.getString('role'); // 👈

    if (id != null && name != null && email != null && role != null) {
      return User(id: id, name: name, email: email, role: role); // 👈
    }
    return null;
  }

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
