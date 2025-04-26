import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/route/route.dart';
import 'package:rapid_loan/core/utils/dimensions.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/utils/style.dart';
import 'package:rapid_loan/data/controller/auth/auth/registration_controller.dart';
import 'package:rapid_loan/views/components/buttons/rounded_button.dart';
import 'package:rapid_loan/views/components/buttons/rounded_loading_button.dart';
import 'package:rapid_loan/views/components/text-field/custom_text_form_field.dart';
import 'package:rapid_loan/views/screens/auth/reset_password/widget/validation_widget.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextFormField(
              isUnderline: true,
              label: MyStrings.firstName,
              fillColor: MyColor.bgColor1,
              controller: controller.firstNameController,
              focusNode: controller.firstNameFocusNode,
              inputType: TextInputType.text,
              nextFocus: controller.lastNameFocusNode,
              hintText: MyStrings.enterYourFirstName,
              maxLines: 1,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return MyStrings.enterYourFirstName.tr;
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                return;
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            CustomTextFormField(
              isUnderline: true,
              label: MyStrings.lastName,
              fillColor: MyColor.bgColor1,
              controller: controller.lastNameController,
              focusNode: controller.lastNameFocusNode,
              inputType: TextInputType.text,
              nextFocus: controller.emailFocusNode,
              hintText: MyStrings.enterYourLastName,
              maxLines: 1,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return MyStrings.enterYourLastName.tr;
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                return;
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            CustomTextFormField(
                isUnderline: true,
                label: MyStrings.email,
                fillColor: MyColor.bgColor1,
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                hintText: MyStrings.enterYourEmail,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return MyStrings.enterYourEmail.tr;
                  } else if (!MyStrings.emailValidatorRegExp.hasMatch(value ?? '')) {
                    return MyStrings.invalidEmailMsg.tr;
                  } else {
                    return null;
                  }
                },
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                onChanged: (value) {
                  return;
                }),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            // CountryTextField(
            //   press: () {
            //     showModalBottomSheet(
            //         isScrollControlled: true,
            //         backgroundColor: Colors.transparent,
            //         context: context,
            //         builder: (BuildContext context) {
            //           return Container(
            //             height: MediaQuery.of(context).size.height * .8,
            //             padding: const EdgeInsets.all(20),
            //             decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
            //             child: Column(
            //               children: [
            //                 const SizedBox(
            //                   height: 8,
            //                 ),
            //                 Center(
            //                   child: Container(
            //                     height: 5,
            //                     width: 100,
            //                     padding: const EdgeInsets.all(1),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(8),
            //                       color: MyColor.bgColor1,
            //                     ),
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   height: 15,
            //                 ),
            //                 Flexible(
            //                   child: ListView.builder(
            //                       itemCount: controller.countryList.length,
            //                       shrinkWrap: true,
            //                       physics: const BouncingScrollPhysics(),
            //                       itemBuilder: (context, index) {
            //                         return Material(
            //                           color: Colors.transparent,
            //                           child: InkWell(
            //                             splashColor: const Color(0x8034b0fc),
            //                             onTap: () {
            //                               controller.countryController.text = controller.countryList[index].country ?? '';
            //                               controller.setCountryNameAndCode(controller.countryList[index].country ?? '', controller.countryList[index].countryCode ?? '', controller.countryList[index].dialCode ?? '');

            //                               Navigator.pop(context);

            //                               FocusScopeNode currentFocus = FocusScope.of(context);
            //                               if (!currentFocus.hasPrimaryFocus) {
            //                                 currentFocus.unfocus();
            //                               }

            //                               controller.mobileFocusNode.requestFocus();
            //                             },
            //                             child: Container(
            //                               padding: const EdgeInsets.all(15),
            //                               margin: const EdgeInsets.all(5),
            //                               decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.circular(4),
            //                                 border: Border.all(color: MyColor.bgColor1),
            //                               ),
            //                               child: Text(
            //                                 '+${controller.countryList[index].dialCode}  ${(controller.countryList[index].country)?.tr}'.tr,
            //                                 style: interBoldDefault,
            //                               ),
            //                             ),
            //                           ),
            //                         );
            //                       }),
            //                 )
            //               ],
            //             ),
            //           );
            //         });
            //   },
            //   text: controller.countryName == null ? MyStrings.selectACountry.tr : (controller.countryName)!.tr,
            // ),

            // controller.countryName == null
            //     ? const SizedBox()
            //     : Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            //           Row(
            //             children: [
            //               Expanded(
            //                 flex: 1,
            //                 child: CustomTextFormField(
            //                   isUnderline: true,
            //                   label: MyStrings.phone,
            //                   controller: TextEditingController(text: '${controller.mobileCode}'),
            //                   inputType: TextInputType.phone,
            //                   fillColor: MyColor.bgColor1,
            //                   disableColor: controller.hasMobileFocus ? MyColor.primaryColor : MyColor.borderColor,
            //                   hintText: MyStrings.enterYourPhoneNo,
            //                   isIcon: true,
            //                   isEnabled: false,
            //                   onChanged: (value) {
            //                     return;
            //                   },
            //                 ),
            //               ),
            //               const SizedBox(
            //                 width: 8,
            //               ),
            //               Expanded(
            //                   flex: 6,
            //                   child: Focus(
            //                     onFocusChange: (hasFocus) {
            //                       controller.changeMobileFocus(hasFocus);
            //                     },
            //                     child: CustomTextFormField(
            //                       isUnderline: true,
            //                       label: '',
            //                       controller: controller.mobileController,
            //                       focusNode: controller.mobileFocusNode,
            //                       inputType: TextInputType.phone,
            //                       fillColor: MyColor.bgColor1,
            //                       hintText: MyStrings.enterYourPhoneNumber,
            //                       isIcon: true,
            //                       onChanged: (value) {
            //                         return;
            //                       },
            //                     ),
            //                   )),
            //             ],
            //           )
            //         ],
            //       ),
            // const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            Visibility(
                visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                child: ValidationWidget(
                  list: controller.passwordValidationRulse,
                )),
            Focus(
              onFocusChange: (hasFocus) {
                controller.changePasswordFocus(hasFocus);
              },
              child: CustomTextFormField(
                  isUnderline: true,
                  label: MyStrings.password,
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  nextFocus: controller.confirmPasswordFocusNode,
                  hintText: MyStrings.enterYourPassword_,
                  isShowSuffixIcon: true,
                  fillColor: MyColor.bgColor1,
                  isPassword: true,
                  inputType: TextInputType.text,
                  validator: (String? value) {
                    return controller.validatPassword(value ?? '');
                  },
                  onChanged: (value) {
                    if (controller.checkPasswordStrength) {
                      controller.updateValidationList(value);
                    }
                  }),
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextFormField(
                isUnderline: true,
                label: MyStrings.confirmPassword,
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                inputAction: TextInputAction.done,
                isPassword: true,
                fillColor: MyColor.bgColor1,
                hintText: MyStrings.confirmYourPassword,
                isShowSuffixIcon: true,
                validator: (String? value) {
                  if (controller.passwordController.text.toLowerCase() != controller.cPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                }),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            controller.needAgree
                ? Visibility(
                    visible: controller.needAgree,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                              activeColor: MyColor.primaryColor,
                              value: controller.agreeTC,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 1.0, color: controller.agreeTC ? MyColor.transparentColor : MyColor.colorGrey),
                              ),
                              onChanged: (value) {
                                controller.updateAgreeTC();
                              }),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Row(
                          children: [
                            Text(MyStrings.iAgreeWith.tr, style: interRegularDefault.copyWith(color: MyColor.colorBlack)),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.privacyScreen);
                              },
                              child: Text(MyStrings.privacyPolicies.tr.toLowerCase(), style: interBoldDefault.copyWith(color: MyColor.primaryColor, decoration: TextDecoration.underline, fontSize: Dimensions.fontSmall, decorationColor: MyColor.primaryColor)),
                            ),
                            const SizedBox(width: 3),
                          ],
                        ),
                      ],
                    ))
                : const SizedBox.shrink(),
            const SizedBox(
              height: 30,
            ),
            controller.submitLoading
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    text: MyStrings.submit,
                    press: () {
                      if (formKey.currentState!.validate()) {
                        controller.signUpUser();
                      }
                    },
                  ),
            const SizedBox(height: Dimensions.space40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(MyStrings.alreadyAccount.tr, style: interRegularDefault),
                TextButton(
                  onPressed: () {
                    Get.offAndToNamed(RouteHelper.loginScreen);
                  },
                  child: Text(
                    MyStrings.signIn.tr,
                    style: interRegularDefault.copyWith(color: MyColor.primaryColor, decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
