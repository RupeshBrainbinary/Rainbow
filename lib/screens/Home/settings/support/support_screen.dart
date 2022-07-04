import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow/common/Widget/text_styles.dart';
import 'package:rainbow/screens/Home/settings/support/support_controller.dart';
import 'package:rainbow/utils/asset_res.dart';
import 'package:rainbow/utils/color_res.dart';
import 'package:rainbow/utils/strings.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);
  SupportController controller = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
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
            children: [
              SizedBox(
                height: Get.height * 0.035,
              ),
              appBar(),
              supports()
            ],
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
                width: Get.width * 0.32,
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    Strings.support,
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

  Widget supports() {
    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.supportList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Column(
                children: [
                  Container(
                    height: 104,
                    width: Get.width * 0.8933,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Container(
                          height: 46,
                          width: 46,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,  gradient: LinearGradient(
                            colors: [
                              ColorRes.color_50369C,
                              ColorRes.color_D18EEE,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                              ),child: Center(
                          child: Container(
                            height: 36.37,width: 22,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AssetRes.duck),)
                            ),
                          ),
                        ),
                        ),
                        Column(children: [
                          Text("12/30/2021",style: textStyleField16w500,),
                          Text("1235CA2B2",style:textStyleField16w ,),
                          Text(Strings.loremIpsum,style:textStyleFont13 ,),
                        ],)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}