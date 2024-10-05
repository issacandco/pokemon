import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../widgets/base/base_button.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '404 Not Found',
          style: AppTextStyle.baseTextStyle(
            fontWeightType: FontWeightType.bold,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Oops! The page you are looking for does not exist.',
                style: AppTextStyle.baseTextStyle(fontSize: AppSize.getTextSize(18)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSize.getSize(10)),
              BaseButton(
                onPressed: () {
                  Get.back(); // Navigate back to the previous screen
                },
                text: 'Go Back',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
