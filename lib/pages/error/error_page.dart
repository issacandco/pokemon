import 'package:flutter/material.dart';

import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../utils/error_handling_util.dart';
import '../../widgets/base/base_button.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Error',
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
                ErrorHandlingUtil.defaultSystemErrorMessage,
                style: AppTextStyle.baseTextStyle(fontSize: AppSize.getTextSize(18)),
              ),
              SizedBox(height: AppSize.getSize(10)),
              Text(
                errorMessage,
                style: AppTextStyle.baseTextStyle(
                  fontSize: AppSize.getTextSize(16),
                  color: Colors.red,
                ),
              ),
              SizedBox(height: AppSize.getSize(20)),
              BaseButton(
                onPressed: () {
                  Navigator.pop(context);
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
