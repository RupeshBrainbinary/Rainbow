import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow/common/Widget/app_dropdown.dart';
import 'package:rainbow/common/Widget/text_styles.dart';
import 'package:rainbow/screens/auth/register/register_controller.dart';
import 'package:rainbow/screens/auth/register/widget/register_form.dart';
import 'package:rainbow/utils/asset_res.dart';
import 'package:rainbow/utils/color_res.dart';
import 'package:rainbow/utils/strings.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Get.width * 0.02667),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0733),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: ColorRes.color_4F359B,
          ),
          child: GetBuilder<RegisterController>(
            id: 'register_screen',
            builder: (controller) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// top bar area
                      SizedBox(height: Get.height * 0.0616),
                      Image.asset(
                        AssetRes.rainBowLogo,
                        height: Get.height * 0.05541,
                      ),
                      SizedBox(height: Get.height * 0.0308),
                      Text(Strings.register,
                          style: textStyleFont30WhiteExtraBold),
                      SizedBox(height: Get.height * 0.02094),

                      /// form
                      RegisterForm(),
                    ],
                  ),
                  !controller.martialStatusDropdown
                      ? const SizedBox()
                      : Positioned(
                    top: 10,
                          child: AppDropdown(
                            paramList: controller.martialStatusList,
                            onTap: controller.onStatusChange,
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
