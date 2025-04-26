import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rapid_loan/core/utils/dimensions.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/style.dart';
import 'package:rapid_loan/views/components/text/label_text_with_instructions.dart';

class CustomTextField extends StatefulWidget {
  final String? instructions;
  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final Function? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onTap;

  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool needRequiredSign;
  final int maxLines;
  final bool animatedLabel;
  final Color fillColor = MyColor.appBarColor;
  final bool isRequired;
// edited /20-7-23
  final Widget? prefixicon;
  final Widget? suffixWidget;
  final BoxConstraints? suffixIconConstraints;
  final bool? isDense;
  // edited /29-7-2023
  final bool isborderNone;
  final Color disableColor;
  const CustomTextField({
    Key? key,
    this.instructions,
    this.labelText,
    this.readOnly = false,
    this.onSubmitted,
    // this.fillColor = MyColor.transparentColor,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needRequiredSign = false,
    this.maxLines = 1,
    this.animatedLabel = false,
    this.isRequired = false,
    this.prefixicon,
    this.suffixWidget,
    this.suffixIconConstraints,
    this.isDense,
    this.isborderNone = false,
    this.disableColor = MyColor.borderColor,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

// build the state
  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.animatedLabel
            ? TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                  labelText: widget.labelText?.tr ?? '',
                  labelStyle: interRegularDefault.copyWith(color: MyColor.getLabelTextColor()),
                  fillColor: widget.fillColor,
                  filled: widget.fillColor == MyColor.transparentColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()),
                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                  ),
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.disableColor)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldEnableBorder()), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  suffixIconConstraints: widget.suffixIconConstraints,
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTextInstruction(
                    text: widget.labelText.toString(),
                    isRequired: widget.isRequired,
                    instructions: widget.instructions,
                  ),
                  const SizedBox(height: Dimensions.textToTextSpace),
                  TextFormField(
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                    //textAlign: TextAlign.left,
                    cursorColor: MyColor.getTextColor(),
                    controller: widget.controller,
                    autofocus: false,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    focusNode: widget.focusNode,
                    validator: widget.validator,
                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                      hintText: widget.hintText != null ? widget.hintText!.tr : '',
                      hintStyle: interRegularLarge.copyWith(
                        color: MyColor.hintTextColor,
                      ),
                      fillColor: MyColor.transparentColor,
                      filled: true,
                      disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.disableColor)),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(Dimensions.mediumRadius)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldEnableBorder()), borderRadius: BorderRadius.circular(Dimensions.mediumRadius)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(Dimensions.mediumRadius)),
                      prefixIcon: widget.prefixicon,
                      isDense: widget.isDense,
                      suffixIconConstraints: widget.suffixIconConstraints,
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : widget.suffixWidget
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                    onChanged: (text) => widget.onChanged!(text),
                    onTap: widget.onTap,
                  )
                ],
              )
        : widget.isborderNone
            ? TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getPrimaryColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,

                decoration: InputDecoration(
                  isDense: widget.isDense,
                  contentPadding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
                  labelText: widget.labelText?.tr,
                  labelStyle: interRegularDefault.copyWith(color: MyColor.getLabelTextColor()),
                  fillColor: MyColor.transparentColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: widget.hintText != null ? widget.hintText!.tr : '',
                  hintStyle: interRegularLarge.copyWith(
                    color: MyColor.hintTextColor,
                  ),
                  prefixIcon: widget.prefixicon,
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),

                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              )
            : TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getHintTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  isDense: widget.isDense,
                  contentPadding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
                  labelText: widget.labelText?.tr,
                  labelStyle: interRegularDefault.copyWith(color: MyColor.getLabelTextColor()),
                  fillColor: MyColor.transparentColor,
                  filled: true,
                  disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.disableColor)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()),
                  ),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder())),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder())),
                  prefixIcon: widget.prefixicon,
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
