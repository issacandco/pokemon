import 'package:flutter/material.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../utils/get_util.dart';
import '../base_app_bar.dart';

class DropdownSelectionWidget<T> extends StatelessWidget {
  final String? title;
  final List<T> items;
  final T? initialItem;
  final Function(T) onSelectedItem;
  final String Function(T) displayText;

  const DropdownSelectionWidget({
    super.key,
    this.title,
    required this.items,
    this.initialItem,
    required this.onSelectedItem,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        GetUtil.backWithResult(initialItem);
      },
      child: Scaffold(
        appBar: BaseAppBar(
          hideElevation: true,
          icon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              GetUtil.backWithResult(initialItem);
            },
          ),
          titleName: 'Select a $title',
          centerTitleName: true,
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                onSelectedItem(items[index]);
                GetUtil.backWithResult(items[index]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.standardSize,
                  vertical: AppSize.getSize(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        displayText(items[index]),
                        style: AppTextStyle.baseTextStyle(
                          fontWeightType: FontWeightType.medium,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: initialItem == items[index],
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: AppColor.gray,
              thickness: 1,
            );
          },
          itemCount: items.length,
        ),
      ),
    );
  }
}
