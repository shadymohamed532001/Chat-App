import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormFiled extends StatelessWidget {
  CustomTextFormFiled(
      {super.key, this.controller ,this.type ,this.LabelText, this.HintText, this.SuffixIcon, required this.obscureText,this.prefixIcon,this.validator,this.onFieldSubmitted,this.onChanged});
  String? LabelText;
  TextEditingController? controller ;
  String? HintText;
  Widget? SuffixIcon;
  TextInputType? type ;
  bool obscureText ;
  Widget? prefixIcon;
  Function(String)? onChanged;
  Function(String)? onFieldSubmitted;
  String? Function(String?)? validator ;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      style: TextStyle(
        color: Colors.white
      ),
      validator: validator,
      onFieldSubmitted:onFieldSubmitted ,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
          suffixIcon: SuffixIcon,
          prefixIcon: prefixIcon,
          labelText: LabelText,
          labelStyle: const TextStyle(color: Colors.white),
          hintText: HintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.white)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
