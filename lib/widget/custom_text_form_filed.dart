import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/image_assets.dart';
import '../core/constant/color.dart';
import '../core/utils/language/language_controller.dart';

class CustomTextForm extends StatelessWidget {
  final String? hintText;
  final IconData? iconPrefixData;
  final IconData? iconSuffixData;
  final Color? iconPrefixColor;
  final Color? iconSuffixColor;
  final TextEditingController? mycontroller;
  final String? Function(String?)? valid;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool obscuretext;
  final String? labelText;
  final void Function()? onTapPrefixIcon;
  final void Function()? onTapSuffixIcon;
  final void Function(String? newValue)? onSave;
  final bool autoFocus;
  final TextEditingController? controller;
  final IconData? suffixIconData;
  final void Function()? onTapSuffixIcontimer;
  final TextInputType? keyboardType;

  final LanguageController _languageController = Get.put(
    LanguageController(),
  );

  CustomTextForm({
    Key? key,
    this.hintText,
    this.iconPrefixData,
    this.iconSuffixData,
    this.mycontroller,
    this.valid,
    this.readOnly = false,
    this.obscuretext = false,
    this.labelText,
    this.onTapPrefixIcon,
    this.onTapSuffixIcon,
    this.onSave,
    this.keyboardType = TextInputType.text,
    this.iconPrefixColor,
    this.iconSuffixColor,
    this.autoFocus = false,
    this.onChanged,
    this.controller,
    this.suffixIconData,
    this.onTapSuffixIcontimer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autofocus: autoFocus,
        cursorColor: AppColor.white,
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: AppColor.grayColor,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        obscureText: obscuretext,
        validator: valid,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onSaved: onSave,
        decoration: InputDecoration(
          focusColor: AppColor.appgreen,
          hoverColor: AppColor.appgreen,
          alignLabelWithHint: true,
          filled: true,
          floatingLabelStyle: const TextStyle(
            color: AppColor.appgreen,
          ),
          labelStyle: const TextStyle(
            color: AppColor.white,
          ),
          fillColor: AppColor.white,
          labelText: labelText,
          hintText: hintText,
          helperStyle: TextStyle(
            color: AppColor.appgreen,
            fontFamily: AppImageAsset.fontNeoSansArabic,
            fontSize: 15,
            locale: Locale(_languageController.selectedLanguage),
          ),
          hintStyle: const TextStyle(
            color: AppColor.appgreen,
            fontFamily: AppImageAsset.fontNeoSansArabic,
            fontSize: 13,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          suffixIcon: InkWell(
            onTap: onTapSuffixIcontimer,
            child: Icon(
              suffixIconData,
              color: iconSuffixColor,
            ),
          ),
          prefixIcon: InkWell(
            onTap: onTapPrefixIcon,
            child: Icon(
              iconPrefixData,
              color: iconPrefixColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
