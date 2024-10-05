import 'package:flutter/material.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../utils/get_util.dart';
import '../base_button.dart';
import '../base_check_box.dart';
import 'country_code_sheet_view_model.dart';
import 'country_model.dart';

class CountryCodeSheet extends StatefulWidget {
  final bool showCountryNameOnly;
  final bool showAllCountry;
  final bool isAllowMultiple;
  final bool hasWorldwide;
  final bool hasAll;
  final List<CountryModel>? selectedCountryList;

  const CountryCodeSheet({
    super.key,
    this.showCountryNameOnly = false,
    this.showAllCountry = false,
    this.isAllowMultiple = false,
    this.hasAll = false,
    this.hasWorldwide = false,
    this.selectedCountryList,
  });

  @override
  State<CountryCodeSheet> createState() => CountryCodeSheetState();
}

class CountryCodeSheetState extends State<CountryCodeSheet> {
  late CountryCodeSheetViewModel _countryCodeSheetViewModel;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _countryCodeSheetViewModel = GetUtil.put(CountryCodeSheetViewModel());
    _countryCodeSheetViewModel.initConfiguration(widget.hasAll, widget.selectedCountryList, widget.showAllCountry, widget.hasWorldwide);

    _controller.addListener(() {
      _countryCodeSheetViewModel.filterCountryList(_controller.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.getScreenHeight(percent: 60),
      padding: EdgeInsets.only(
        top: AppSize.standardSize,
        bottom: AppSize.standardSize,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.getSize(16)),
          topRight: Radius.circular(AppSize.getSize(16)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
            child: TextField(
              controller: _controller,
              style: AppTextStyle.baseTextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: AppTextStyle.baseTextStyle(
                  color: AppColor.gray,
                  fontSize: AppSize.getTextSize(16),
                ),
                filled: true,
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(
            color: AppColor.gray,
            height: AppSize.standardSize,
          ),
          Expanded(
            child: GetUtil.getX<CountryCodeSheetViewModel>(
              builder: (snapshot) {
                List<CountryModel> countryList = snapshot.countryListStream;
                bool isAll = snapshot.isAllStream.value;

                if (countryList.isNotEmpty) {
                  if (widget.isAllowMultiple) {
                    return Column(
                      children: [
                        Visibility(
                          visible: widget.hasAll,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
                            padding: EdgeInsets.all(AppSize.getSize(6)),
                            child: BaseCheckBox(
                              textMessage: 'All',
                              value: isAll,
                              onChanged: (bool? value) {
                                _countryCodeSheetViewModel.toggleAll(value);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: countryList.length,
                            itemBuilder: (context, i) {
                              return Material(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
                                  padding: EdgeInsets.all(AppSize.getSize(6)),
                                  child: BaseCheckBox(
                                    textMessage: '${countryList[i].name!} ${widget.showCountryNameOnly ? "" : countryList[i].phoneCode!}',
                                    value: countryList[i].isSelected ?? false,
                                    onChanged: (bool? value) {
                                      _countryCodeSheetViewModel.toggleCountrySelection(i, value);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: countryList.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            GetUtil.backWithResult(countryList[i]);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
                            padding: EdgeInsets.all(AppSize.getSize(6)),
                            child: Text(
                              '${countryList[i].name!} ${widget.showCountryNameOnly ? '' : countryList[i].phoneCode!}',
                              style: AppTextStyle.baseTextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          Visibility(
            visible: widget.isAllowMultiple,
            child: Container(
              padding: EdgeInsets.only(top: AppSize.getSize(16)),
              child: GetUtil.getX<CountryCodeSheetViewModel>(
                builder: (snapshot) {
                  int length = snapshot.selectedCountryListStream.length;

                  if (length > 0) {
                    return BaseButton(
                        onPressed: () {
                          _countryCodeSheetViewModel.onSelect();
                        },
                        text: '${'Select'} ($length)');
                  } else {
                    return BaseButton(
                      text: 'Select',
                      onPressed: () {
                        _countryCodeSheetViewModel.onSelect();
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
