import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/dimensions.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/utils/style.dart';
import 'package:rapid_loan/core/utils/url.dart';
import 'package:rapid_loan/core/utils/util.dart';
import 'package:rapid_loan/data/controller/account/profile_complete_controller.dart';
import 'package:rapid_loan/data/controller/auth/auth/registration_controller.dart';
import 'package:rapid_loan/data/model/country_model/country_model.dart';
import 'package:rapid_loan/views/components/bottom_sheet/bottom_sheet_bar.dart';
import 'package:rapid_loan/views/components/bottom_sheet/custom_bottom_sheet_plus.dart';
import 'package:rapid_loan/views/components/card/bottom_sheet_card.dart';
import 'package:rapid_loan/views/components/image/my_image_widget.dart';
import 'package:rapid_loan/views/components/text-field/custom_text_field.dart';

class CountryBottomSheet {
  static void bottomSheet(BuildContext context, RegistrationController controller) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * .8,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColor.colorGrey.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: controller.countryList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.countryController.text = controller.countryList[index].country ?? '';
                              controller.setCountryNameAndCode(controller.countryList[index].country ?? '', controller.countryList[index].countryCode ?? '', controller.countryList[index].dialCode ?? '');

                              Navigator.pop(context);
                              controller.setMobileFocus();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: MyColor.getCardBg(), border: Border.all(width: .5, color: MyColor.primaryColor.withOpacity(.1)), boxShadow: MyUtil.getBottomSheetShadow()),
                              child: Text('+${controller.countryList[index].dialCode}  ${controller.countryList[index].country.toString().tr}', style: interRegularDefault.copyWith(color: MyColor.getTextColor())),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  static void profileCompleteCountryBottomSheet(BuildContext context, ProfileCompleteController controller) {
    CustomBottomSheetPlus(
        bgColor: Colors.grey.withOpacity(.2),
        isNeedPadding: false,
        child: StatefulBuilder(builder: (context, setState) {
          if (controller.filteredCountries.isEmpty) {
            controller.filteredCountries = controller.countryList;
          }
          // Function to filter countries based on the search input.
          void filterCountries(String query) {
            if (query.isEmpty) {
              controller.filteredCountries = controller.countryList;
            } else {
              List<Countries> filterData = controller.filteredCountries.where((country) => country.country!.toLowerCase().contains(query.toLowerCase())).toList();
              setState(() {
                controller.filteredCountries = filterData;
              });
            }
          }

          return Container(
            height: MediaQuery.of(context).size.height * .9,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: MyColor.secondaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: MyUtil.getShadow(),
            ),
            child: Column(
              children: [
                const BottomSheetBar(),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: '',
                  hintText: '${MyStrings.searchCountry.tr}${controller.countryList.length}',
                  controller: controller.countryController,
                  textInputType: TextInputType.text,
                  onChanged: filterCountries,
                  prefixicon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var countryItem = controller.filteredCountries[index];

                        return GestureDetector(
                          onTap: () {
                            controller.countryController.text = controller.filteredCountries[index].country ?? '';
                            controller.setCountryNameAndCode(controller.filteredCountries[index].country ?? '', controller.filteredCountries[index].countryCode ?? '', controller.filteredCountries[index].dialCode ?? '');

                            Navigator.pop(context);

                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: BottomSheetCard(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", countryItem.countryCode.toString().toLowerCase()),
                                    height: Dimensions.space25,
                                    width: Dimensions.space40 + 2,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '+${controller.filteredCountries[index].dialCode}  ${controller.filteredCountries[index].country?.tr ?? ''}',
                                    style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        })).show(context);
  }
}
