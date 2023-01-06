import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {Key? key,
      this.obscureText,
      this.inputFormatters,
      this.onChanged,
      this.keyboardType,
      this.initialValue,
      this.controller,
      this.prefix,
      this.icon,
      this.onSubmitted,
      this.padding,
      this.hintText,
      this.onTap})
      : super(key: key);

  final bool? obscureText;
  final Function(String)? onChanged;
  final bool? icon;
  final dynamic inputFormatters;
  final dynamic keyboardType;
  final Widget? prefix;
  final String? hintText;
  final String? initialValue;
  final EdgeInsets? padding;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.only(right: 20, left: 20, top: 8, bottom: 5),
      child: SizedBox(
        height: 45,
        child: TextFormField(
          autofocus: false,
          obscureText: obscureText != null ? obscureText! : false,
          keyboardType: keyboardType,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.white),
          onChanged: onChanged,
          controller: controller,
          initialValue: initialValue ?? null,
          onFieldSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            prefixIcon: prefix,
            fillColor: Colors.black26,
            filled: true,
            contentPadding: const EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white54, fontSize: 23),
            suffixIcon: GestureDetector(
                onTap: onTap,
                child: icon == false
                    ? SizedBox()
                    : Icon(Icons.search, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
