import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow/common/Widget/text_field.dart';
import 'package:rainbow/screens/Home/settings/payment/add_cart/add_cart_controller.dart';

import '../../../../../common/Widget/buttons.dart';
import '../../../../../common/Widget/text_styles.dart';
import '../../../../../utils/asset_res.dart';
import '../../../../../utils/color_res.dart';
import '../../../../../utils/strings.dart';

class AddCartScreen extends StatelessWidget {
  AddCartScreen({Key? key}) : super(key: key);
  AddCartController controller = Get.put(AddCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddCartController>(
        builder: (controller) => SafeArea(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorRes.color_50369C,
                  ColorRes.color_D18EEE,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.0906),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Billing Information",
                          style: gilroyMediumTextStyle(
                              fontSize: 18, letterSpacing: -0.55),
                        ),
                        SizedBox(
                          height: Get.height * 0.0431,
                        ),

                        AppTextFiled(
                          controller: controller.fullNameController,
                          title: "Full Name",
                          hintText: "Natalie NAra",
                        ),
                        // SizedBox(height: Get.height *0.0184,),
                        AppTextFiled(
                          controller: controller.addressController,
                          title: "Address",
                          hintText: "3819 Lynden Road",
                        ),
                        SizedBox(
                          height: Get.height * 0.0184,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextFiled(
                                controller: controller.cityController,
                                title: "City",
                                hintText: "Canada",
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.05866,
                            ),
                            Expanded(
                              child: AppTextFiled(
                                controller: controller.postalCodeController,
                                title: "Postal Code",
                                hintText: "L0B 1M0",
                              ),
                            ),
                          ],
                        ),
                        AppTextFiled(
                          controller: controller.countryController,
                          title: "country",
                          hintText: "3819 Lynden Road",
                        ),
                        Text(
                          "Card Information",
                          style: gilroyMediumTextStyle(
                              fontSize: 18, letterSpacing: -0.55),
                        ),
                        SizedBox(
                          height: Get.height * 0.0431034,
                        ),
                        AppTextFiled(
                          controller: controller.nameOnCardController,
                          title: "Name on card",
                          hintText: "Aycan Doganlar",
                        ),
                        AppTextFiled(
                          controller: controller.cardNmberController,
                          title: "Card number",
                          hintText: "1234 4567 7890 1234",
                        ),
                        SizedBox(
                          height: Get.height * 0.0184,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextFiled(
                                  controller: controller.expiryDateController,
                                  title: "Expiry date",
                                  hintText: "02/24",
                                  textInputType: TextInputType.number),
                            ),
                            SizedBox(
                              width: Get.width * 0.05866,
                            ),
                            Expanded(
                              child: AppTextFiled(
                                controller: controller.cvvController,
                                title: "CVV",
                                hintText: ". . .",
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SubmitButton(
                          text: "Add Card",
                          onTap: controller.addCart,
                        ),
                        SizedBox(
                          height: Get.width * 0.05866,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AssetRes.backIcon,
                  height: 16,
                  width: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: Get.width * 0.3,
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    Strings.addCard,
                    style: textStyleFont18White,
                  )),
              SizedBox(
                width: Get.width * 0.05,
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
        ],
      ),
    );
  }
}
