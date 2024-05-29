import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/app/select_mode_controller.dart';

// ignore: must_be_immutable
class SelectModeScreen extends StatelessWidget {
  SelectModeScreen({super.key});
  static const String routeName = '/selectModeScreen';
  SelectModeControler selectModeControler = Get.put(SelectModeControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديد نوع الحساب'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GetBuilder<SelectModeControler>(builder: (_) {
                return InkWell(
                  onTap: () {
                    selectModeControler.selectDriver();
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/driver.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'سائق',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<SelectModeControler>(
                builder: (_) {
                  return InkWell(
                    onTap: () {
                      selectModeControler.selectPassenger();
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/passenger.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'راكب',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
