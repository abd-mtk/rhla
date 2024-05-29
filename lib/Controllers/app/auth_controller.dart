import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/App/Default/login_screen.dart';

import '../../Views/App/Default/select_mode_screen.dart';
import '../../main.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = true;
  bool showConfirmPassword = true;

  void togglePassword() {
    showPassword = !showPassword;
    update();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  void saveUserData() async {
    prefs!.setString('email', emailController.text);
    prefs!.setString('password', passwordController.text);
    prefs!.setString('uid', FirebaseAuth.instance.currentUser!.uid);
  }

  void saveUserDataFirbase() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'email': emailController.text,
      'password': passwordController.text,
    }, SetOptions(merge: true)).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        saveUserData();
        saveUserDataFirbase();
        Get.offAllNamed(SelectModeScreen.routeName);
      } else {
        Get.snackbar(
          '                        خطأ في تسجيل الدخول',
          '                               الرجاء تفعيل البريد الالكتروني',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.verified_user,
            color: Colors.white,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          '                        خطأ في تسجيل الدخول',
          '                            البريد الالكتروني غير موجود',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          '                        خطأ في تسجيل الدخول',
          '                                  كلمة المرور غير صحيحة',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.lock,
            color: Colors.white,
          ),
        );
      } else {
        Get.snackbar(
          '                        خطأ في تسجيل الدخول',
          '             المحاولة مرة ثانية بعد التتحقق من البيانات',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        );
      }
    }
  }

  // sign up using email and password  and verify email by sending email verification
  void register() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          '                         خطأ في كلمة المرور',
          '                                كلمة المرور غير متطابقة',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.lock,
            color: Colors.white,
          ),
        );
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((UserCredential value) =>
                {value.user?.sendEmailVerification()});
        Get.snackbar(
          '                           تم التسجيل بنجاح',
          '                          الرجاء تفعيل البريد الالكتروني',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
        );
        Get.offAllNamed(LoginScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          '                         خطأ في كلمة المرور',
          '                                      كلمة المرور ضعيفة',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.lock,
            color: Colors.white,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          '                   خطأ في البريد الالكتروني',
          '                          البريد الالكتروني موجود مسبقا',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          '                   خطأ في البريد الالكتروني',
          '                             البريد الالكتروني غير صحيح',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
        );
      } else {
        Get.snackbar(
          '                                                  خطأ',
          '           المحاولة مرة ثانية بعد التتحقق من البيانات',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
          icon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    prefs!.clear();
    Get.offAllNamed('/loginScreen');
  }
}
