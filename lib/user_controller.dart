import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final RxString email = ''.obs;
  final RxString token = ''.obs;

  Future<void> checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedToken = prefs.getString('token');

    if (savedEmail != null && savedToken != null) {
      email.value = savedEmail;
      token.value = savedToken;
      Get.offAllNamed('/home');
    } else {
 Get.offAllNamed('/get_started');
    }
  }

  Future<void> loginUser(String email, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('token', token);
    this.email.value = email;
    this.token.value = token;
    
    Get.offAllNamed('/home');
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('token');
    email.value = '';
    token.value = '';
=    Get.offAllNamed('/get_started');
  }
}
