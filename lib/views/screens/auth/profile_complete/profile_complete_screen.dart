import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erosta_loans/core/utils/dimensions.dart';
import 'package:erosta_loans/core/utils/my_color.dart';
import 'package:erosta_loans/core/utils/my_strings.dart';
import 'package:erosta_loans/core/utils/style.dart';
import 'package:erosta_loans/core/utils/url.dart';
import 'package:erosta_loans/data/controller/account/profile_complete_controller.dart';
import 'package:erosta_loans/data/repo/account/profile_repo.dart';
import 'package:erosta_loans/data/services/api_service.dart';
import 'package:erosta_loans/views/components/appbar/custom_appbar.dart';
import 'package:erosta_loans/views/components/buttons/rounded_button.dart';
import 'package:erosta_loans/views/components/buttons/rounded_loading_button.dart';
import 'package:erosta_loans/views/components/image/my_image_widget.dart';
import 'package:erosta_loans/views/components/text-field/custom_text_field.dart';
import 'package:erosta_loans/views/components/will_pop_widget.dart';
import 'package:erosta_loans/views/screens/auth/profile_complete/widget/image_widget.dart';
import 'package:erosta_loans/views/screens/auth/registration/widget/country_bottom_sheet.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(
      apiClient: Get.find(),
    ));
    final controller = Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          appBar: CustomAppBar(
            title: MyStrings.profileComplete.tr,
            isShowBackBtn: true,
            fromAuth: false,
            isProfileCompleted: true,
          ),
          body: GetBuilder<ProfileCompleteController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.space12,
                    ),
                    CustomImageWidget(isEdit: false, imagePath: controller.imageFile?.path ?? '', onClicked: () {}),
                    const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                    CustomTextField(
                      labelText: MyStrings.username.tr,
                      hintText: MyStrings.enterYourUsername.tr,
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.usernameFocusNode,
                      controller: controller.usernameController,
                      nextFocus: controller.mobileNoFocusNode,
                      onChanged: (value) {
                        return;
                      },
                      validator: (value) {
                        if (value != null && value.toString().isEmpty) {
                          return MyStrings.enterYourFirstName.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                    GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        CountryBottomSheet.profileCompleteCountryBottomSheet(context, controller);
                      },
                      child: Container(
                        width: context.width,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: MyColor.borderColor, width: 1)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (controller.countryCode != null) ...[
                                  MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink.replaceAll('{countryCode}', controller.countryCode.toString().toLowerCase()),
                                    height: Dimensions.space25,
                                    width: Dimensions.space40 + 2,
                                    radius: 2,
                                  ),
                                  const SizedBox(width: Dimensions.space10),
                                  Text(controller.countryName ?? '', style: interRegularDefault.copyWith()),
                                ] else ...[
                                  Text(MyStrings.selectACountry, style: interRegularDefault.copyWith()),
                                ],
                              ],
                            ),
                            const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: MyColor.colorGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                    CustomTextField(
                      labelText: MyStrings.enterYourPhoneNumber,
                      hintText: MyStrings.enterYourPhoneNumber,
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.mobileNoFocusNode,
                      controller: controller.mobileNoController,
                      nextFocus: controller.addressFocusNode,
                      onChanged: (value) {
                        return;
                      },
                      validator: (value) {
                        if (value != null && value.toString().isEmpty) {
                          return MyStrings.enterYourLastName.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                    CustomTextField(
                      labelText: MyStrings.address,
                      hintText: MyStrings.enterYourAddress,
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.addressFocusNode,
                      controller: controller.addressController,
                      nextFocus: controller.stateFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                    CustomTextField(
                      labelText: MyStrings.state,
                      hintText: MyStrings.enterYourState,
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.stateFocusNode,
                      controller: controller.stateController,
                      nextFocus: controller.cityFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                    CustomTextField(
                      labelText: MyStrings.city.tr,
                      hintText: MyStrings.enterYourCity,
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.cityFocusNode,
                      controller: controller.cityController,
                      nextFocus: controller.zipCodeFocusNode,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                    CustomTextField(
                      labelText: MyStrings.zipCode.tr,
                      hintText: MyStrings.enterYourCountryZipCode,
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      focusNode: controller.zipCodeFocusNode,
                      controller: controller.zipCodeController,
                      onChanged: (value) {
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space35),
                    controller.submitLoading
                        ? const RoundedLoadingBtn()
                        : RoundedButton(
                            text: MyStrings.updateProfile.tr,
                            textColor: MyColor.colorWhite,
                            press: () {
                              if (formKey.currentState!.validate()) {
                                controller.updateProfile();
                              }
                            },
                            color: MyColor.getPrimaryColor(),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
