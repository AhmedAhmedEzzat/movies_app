import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_assets.dart';

import '../theme/color_pallete.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  final bool isPassword;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;



   const CustomTextFormField(
      {super.key, this.hintText, this.prefixIcon, this.controller, this.onChanged, this.onFieldSubmitted, this.validator ,this.isPassword=false, this.maxLines=1, this.minLines,});


  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      cursorColor: ColorPallete.primaryColor,
      validator: widget.validator,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: widget.isPassword ? obscureText : false,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorPallete.textWhiteColor,
        fontFamily: 'Roboto',
      ),
      decoration: InputDecoration(

        filled: true,
        fillColor: ColorPallete.secBackgroundColor,
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: widget.prefixIcon,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 40,
          maxWidth: 40,
        ),

        hintText: widget.hintText,
        hintStyle:  TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorPallete.textWhiteColor,
          fontFamily: 'Roboto',
        ),
        suffixIcon: widget.isPassword ? GestureDetector(
          onTap: (){
            setState(() {
              obscureText=!obscureText;
            });
          },
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: ColorPallete.textWhiteColor,
          ),
        ): null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPallete.secBackgroundColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPallete.secBackgroundColor,
            width: 1.5,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPallete.secBackgroundColor,
            width: 1.5,),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.5,),
        ),


      ),);
  }
}





