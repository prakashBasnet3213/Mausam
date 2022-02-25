import 'package:flutter/material.dart';
import 'package:mausam/common/constants/custom_popins_text.dart';
import 'package:mausam/presentation/screens/widgets/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String heading;
  final String message;
  const CustomDialog({
    Key? key,
    required this.heading,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customPoppinsText(
              content: heading,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.85),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            customPoppinsText(
              align: TextAlign.center,
              content: message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.85),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "OK",
              ),
            )
          ],
        ),
      ),
    );
  }
}
