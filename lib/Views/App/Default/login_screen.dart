import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/app/auth_controller.dart';
import '../../Widgets/Inputs/input_field.dart';
import 'register_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const routeName = '/loginScreen';

  AuthController controller = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/permission.png'),
              width: 200,
              height: 200,
            ),
            const Gap(50),
            GetBuilder<AuthController>(builder: (_) {
              return InputField(
                defultValue: "",
                hintText: 'البريد الالكتروني',
                prefixicon: Icons.email,
                suffixicon: null,
                inputController: controller.emailController,
                showPassword: false,
                maxchar: 64,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
              );
            }),
            GetBuilder<AuthController>(builder: (_) {
              return InputField(
                defultValue: "",
                hintText: 'كلمة المرور',
                maxchar: 64,
                prefixicon: Icons.lock,
                suffixicon: controller.showPassword
                    ? IconButton(
                        onPressed: () {
                          controller.togglePassword();
                        },
                        icon: const Icon(
                          Icons.visibility_off,
                          size: 25,
                          color: Colors.grey,
                        ))
                    : IconButton(
                        onPressed: () {
                          controller.togglePassword();
                        },
                        icon: const Icon(
                          Icons.visibility,
                          size: 25,
                          color: Colors.grey,
                        )),
                inputController: controller.passwordController,
                showPassword: controller.showPassword,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('تسجيل الدخول'),
                ),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed(RegisterScreen.routeName);
                  },
                  child: const Text(
                    'انشاء حساب ',
                  ),
                ),
                const Text(
                  'ليس لديك حساب؟',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
