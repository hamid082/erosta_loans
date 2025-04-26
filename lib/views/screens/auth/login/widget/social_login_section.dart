import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_loan/core/utils/my_color.dart';
import 'package:rapid_loan/core/utils/my_images.dart';
import 'package:rapid_loan/core/utils/my_strings.dart';
import 'package:rapid_loan/core/utils/style.dart';
import 'package:rapid_loan/data/controller/auth/auth/social_login_controller.dart';
import 'package:rapid_loan/data/repo/auth/social_login_repo.dart';
import 'package:rapid_loan/views/components/buttons/custom_outlined_button.dart';

class SocialLoginSection extends StatefulWidget {
  const SocialLoginSection({super.key});

  @override
  State<SocialLoginSection> createState() => _SocialLoginSectionState();
}

class _SocialLoginSectionState extends State<SocialLoginSection> {
  @override
  void initState() {
    Get.put(SocialLoginRepo(apiClient: Get.find()));
    Get.put(SocialLoginController(repo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialLoginController>(builder: (controller) {
      return Visibility(
        visible: controller.checkSocialAuthActiveOrNot(provider: 'all'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Center(
              child: Text(
                MyStrings.or.tr,
                style: interLightDefault.copyWith(color: MyColor.bodyTextColor),
              ),
            ),
            if (controller.checkSocialAuthActiveOrNot(provider: 'google')) ...[
              const SizedBox(height: 15),
              CustomOutlinedBtn(
                btnText: MyStrings.signInWithGoogle.tr,
                onTap: () {
                  controller.signInWithGoogle();
                },
                isLoading: controller.isGoogleSignInLoading,
                textColor: MyColor.getPrimaryTextColor(),
                radius: 24,
                height: 55,
                icon: Image.asset(
                  MyImages.google,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
            if (controller.checkSocialAuthActiveOrNot(provider: 'linkedin')) ...[
              const SizedBox(height: 15),
              CustomOutlinedBtn(
                btnText: MyStrings.signInWithLinkedin.tr,
                onTap: () {
                  controller.signInWithLinkedin(context);
                },
                isLoading: controller.isLinkedinLoading,
                textColor: MyColor.getPrimaryTextColor(),
                radius: 24,
                height: 55,
                icon: Image.asset(
                  MyImages.linkedin,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
            if (controller.checkSocialAuthActiveOrNot(provider: 'facebook') && 99 == 1) ...[
              const SizedBox(height: 15),
              CustomOutlinedBtn(
                btnText: MyStrings.signInWithFacebook.tr,
                onTap: () {},
                textColor: MyColor.getPrimaryTextColor(),
                radius: 24,
                height: 55,
                icon: Image.asset(
                  MyImages.facebook,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
