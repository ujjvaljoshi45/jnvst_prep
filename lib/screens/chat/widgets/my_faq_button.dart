import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jnvst_prep/utils/colors.dart';

class MyFaqButton extends StatelessWidget {
  const MyFaqButton({
    super.key,
    required this.context,
    required this.str,
    required this.onPressCallback,
  });

  final BuildContext context;
  final String str;
  final Function() onPressCallback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(
              Size(MediaQuery.sizeOf(context).width, 50)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
          backgroundColor: const WidgetStatePropertyAll(lightLevender),
          side: const WidgetStatePropertyAll(BorderSide(color: levender)),
          elevation: const WidgetStatePropertyAll(2.5),
          enableFeedback: true,
          alignment: Alignment.centerLeft,
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: onPressCallback,
        child: Text(
          str,
          textAlign: TextAlign.start,
          style: const TextStyle(color: levender),
        ));
  }
}
