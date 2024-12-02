import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField({
    super.key,
    required this.Hinttext,
    required this.prefixicon,
    required this.Controller,
    required this.isPassword,
    this.validator,
  });

  final String Hinttext;
  final IconData prefixicon;
  final TextEditingController Controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool showpassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.isPassword ? !showpassword : false,
      controller: widget.Controller,
      decoration: InputDecoration(
          hintText: widget.Hinttext,
          prefixIcon: Icon(widget.prefixicon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showpassword = !showpassword;
                    });
                  },
                  icon: showpassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off))
              : null,
          focusColor: const Color.fromARGB(255, 47, 133, 219),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 47, 133, 219), width: 2),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2))),
    );
  }
}
