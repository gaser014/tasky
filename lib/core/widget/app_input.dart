import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../unit/app_strings.dart';
import 'app_image.dart';

class AppInput extends StatefulWidget {
  final String label;
  final String? image;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final Function(String?)? onChanged;
  final bool isPassword;
  final Widget? widget;
  final bool isEnable;
  final Widget? suffixIcon;

  const AppInput({
    super.key,
    this.onChanged,
    required this.label,
    this.image,
    required this.validator,
    required this.controller,
    this.isEnable = true,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.widget,
    this.suffixIcon,
    this.isPassword = false,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleY: widget.isPassword ? .7 : 1,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w,),
        child: TextFormField(
          obscureText: widget.isPassword && isPasswordHidden,
          controller: widget.controller,
          style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xff7F7F7F),
                )
              ,
          autofillHints: widget.autofillHints,
          validator: widget.validator,

          textAlignVertical: TextAlignVertical.center,
          keyboardType: widget.keyboardType,
          enabled: widget.isEnable,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xffBABABA),
                width: 1.w,
              ),
            ),
            filled: true,
            fillColor:  Colors.white,
            hintText: widget.label,
            hintStyle:TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7F7F7F),
                  ),
            icon: widget.widget,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(isPasswordHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_rounded,size: 20.w,
                      color: const Color(0xffBABABA),
                      ),
                    ),
                    onPressed: () {
                      isPasswordHidden = !isPasswordHidden;
                      setState(() {});
                    },
                  )
                : widget.suffixIcon,
            prefixIcon: (widget.image?.isNotEmpty ?? true)
                ? null
                : Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: AppImage(
                      path: widget.image!,
                      width: 20.w,
                      height: 20.h,
                      fit: BoxFit.scaleDown,
                    )),
          ),
        ),
      ),
    );
  }
}
class CountryPhone extends StatelessWidget {
   const CountryPhone({super.key,required this.phoneController});
  final TextEditingController? phoneController;

  @override
  Widget build(BuildContext context) {
    return      Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: IntlPhoneField(
        controller: phoneController,
        dropdownIcon: Transform.rotate(
            angle: -1.57,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 12,
              ),
            )),
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffAFAFAF),
        ),

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xffBABABA),
              width: 1.w,
            ),
          ),
          fillColor: Colors.white,
          hintText: DataString.phoneExample,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xffAFAFAF),
          ),
          prefixIcon: null,
        ),
        showCursor: false,
        initialCountryCode: 'EG',
        onChanged: (phone) {},
      ),
    );
  }
}

