import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jnvst_prep/utils/colors.dart';
import 'package:jnvst_prep/utils/styles.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {super.key,
      required this.controller,
      required this.sendMessage,
      required this.focusNode});
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function() sendMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
      child: Card(
        color: levender,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: controller,
                  style: hintTextStyle.copyWith(fontWeight: FontWeight.w600),
                  cursorColor: Colors.deepPurple,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                      hintStyle: hintTextStyle,
                      border: InputBorder.none,
                      hintText: 'type something...'),
                ),
              ),
            ),
            IconButton(
                onPressed: sendMessage,
                icon: FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.white,
                  size: 16.sp,
                ))
          ],
        ),
      ),
    );
  }
}
