import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../utils/get_util.dart';
import '../../widgets/base/base_app_bar.dart';
import '../detail/components/item_type.dart';
import 'sort_view_model.dart';

class SortPage extends BasePage {
  const SortPage({super.key});

  @override
  State<StatefulWidget> createState() => _SortPageState();
}

class _SortPageState extends BaseState<SortPage> with BasicPage {
  final SortViewModel _sortViewModel = GetUtil.put(SortViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar(titleName: 'sort'.translate());
  }

  @override
  Widget body() {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(AppSize.standardSize),
      child: GetUtil.getX<SortViewModel>(
        builder: (vm) {
          List<String> sortByList = vm.sortByList;

          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'sort_by'.translate(),
                    style: AppTextStyle.baseTextStyle(
                      fontWeightType: FontWeightType.bold,
                      fontSize: AppSize.getTextSize(20),
                    ),
                  ),
                  SizedBox(height: AppSize.getSize(8)),
                  Wrap(
                    runSpacing: AppSize.getSize(16),
                    spacing: AppSize.getSize(16),
                    children: sortByList
                        .map((type) => InkWell(
                              onTap: () {
                                GetUtil.backWithResult(type);
                              },
                              child: ItemType(
                                type: type,
                                fromFilter: true,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ));
  }
}
