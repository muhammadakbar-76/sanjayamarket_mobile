import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.bottomMargin = 0,
    this.isObscure = false,
    required this.label,
    required this.hint,
    this.inputFormatters,
    this.validator,
    this.controller,
  }) : super(key: key);

  final bool isObscure;

  final double bottomMargin;

  final String label;

  final String hint;

  final TextEditingController? controller;

  final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: tBlackText.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            obscureText: isObscure,
            cursorColor: cBlackColor,
            inputFormatters: inputFormatters,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: defaultBorder),
              errorBorder: OutlineInputBorder(
                borderRadius: defaultBorder,
                borderSide: BorderSide(
                  color: cRedColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: defaultBorder,
                borderSide: BorderSide(
                  color: cGreenColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
