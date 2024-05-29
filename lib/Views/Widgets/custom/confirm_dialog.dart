import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class ConfirmTripDialog extends StatelessWidget {
  Function onConfirm;
  Function onCancel;
  String? title;
  ConfirmTripDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),
        Text(
          title ?? 'هل انت متأكد من انشاء الرحلة؟',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                onCancel();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('الغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('تأكيد'),
            ),
          ],
        ),
      ],
    );
  }
}
