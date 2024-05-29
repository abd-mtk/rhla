import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/app/auth_controller.dart';
import '../../Constants/colors/colors.dart';
import '../../Widgets/Inputs/input_field.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const String routeName = '/registerScreen';
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("انشاء حساب جديد"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/checklist.png'),
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
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                  maxchar: 64,
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
                            color: primeColor,
                          ))
                      : IconButton(
                          onPressed: () {
                            controller.togglePassword();
                          },
                          icon: const Icon(
                            Icons.visibility,
                            size: 25,
                            color: primeColor,
                          )),
                  inputController: controller.passwordController,
                  showPassword: controller.showPassword,
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                );
              }),
              GetBuilder<AuthController>(builder: (_) {
                return InputField(
                  textDirection: TextDirection.ltr,
                  hintText: ' تأكيد كلمة المرور',
                  defultValue: "",
                  maxchar: 64,
                  prefixicon: Icons.lock_clock_outlined,
                  suffixicon: controller.showConfirmPassword
                      ? IconButton(
                          onPressed: () {
                            controller.toggleConfirmPassword();
                          },
                          icon: const Icon(
                            Icons.visibility_off,
                            size: 25,
                            color: primeColor,
                          ))
                      : IconButton(
                          onPressed: () {
                            controller.toggleConfirmPassword();
                          },
                          icon: const Icon(
                            Icons.visibility,
                            size: 25,
                            color: primeColor,
                          )),
                  inputController: controller.confirmPasswordController,
                  showPassword: controller.showConfirmPassword,
                  textAlign: TextAlign.left,
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.register();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        Gap(10),
                        Text(
                          'انشاء حساب',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
