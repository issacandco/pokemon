import 'package:get/get.dart';

import '../../../utils/get_util.dart';
import 'country_model.dart';

class CountryCodeSheetViewModel extends GetxController {
  RxList<CountryModel> countryListStream = <CountryModel>[].obs;
  List<CountryModel> fullCountryList = [];
  RxList<CountryModel> selectedCountryListStream = <CountryModel>[].obs;

  RxBool isAllStream = false.obs;

  bool hasAll = false;

  void initConfiguration(bool hasAll, List<CountryModel>? selectedCountryList, bool? showAllCountry, bool? hasWorldwide) async {
    List<CountryModel>? countryList;

    countryList = [CountryModel(id: 0, name: 'Malaysia', abbreviation: 'MY', phoneCode: '+60'), CountryModel(id: 0, name: 'Singapore', abbreviation: 'SG', phoneCode: '+65')];

    fullCountryList = countryList;

    if (hasAll && selectedCountryList != null && selectedCountryList.isEmpty) {
      this.hasAll = hasAll;
      isAllStream.value = true;
      for (var element in fullCountryList) {
        element.isSelected = true;
      }
      selectedCountryListStream.value = fullCountryList;
    } else {
      if (selectedCountryList != null && selectedCountryList.isNotEmpty) {
        selectedCountryListStream.value = selectedCountryList;
        for (CountryModel selectedCountry in selectedCountryListStream) {
          for (CountryModel country in fullCountryList) {
            if (country.id == selectedCountry.id) {
              country.isSelected = true;
            }
          }
        }
      }
    }

    if (hasWorldwide != null && hasWorldwide == false) {
      fullCountryList.removeWhere((element) => element.id == 251);
    }

    countryListStream.value = fullCountryList;
  }

  void filterCountryList(String keyword) {
    countryListStream.value = fullCountryList.where((element) => element.name!.toLowerCase().contains(keyword) || (element.phoneCode != null && element.phoneCode!.toLowerCase().contains(keyword))).toList();
  }

  void toggleCountrySelection(index, value) {
    countryListStream[index].isSelected = value;

    if (hasAll) {
      if (getSelectedCountries().length == countryListStream.length) {
        isAllStream.value = true;
      } else {
        isAllStream.value = false;
      }
    }

    selectedCountryListStream.value = getSelectedCountries();
    countryListStream.refresh();
  }

  void toggleAll(flag) {
    isAllStream.value = flag;

    for (var element in countryListStream) {
      element.isSelected = flag;
    }

    selectedCountryListStream.value = getSelectedCountries();
    countryListStream.refresh();
  }

  void onSelect() {
    if (isAllStream.value) {
      GetUtil.backWithResult(<CountryModel>[]);
    } else {
      GetUtil.backWithResult(getSelectedCountries());
    }
  }

  List<CountryModel> getSelectedCountries() {
    List<CountryModel> selectedCountries = [];

    for (CountryModel countryModel in fullCountryList) {
      if (countryModel.isSelected != null && countryModel.isSelected!) {
        selectedCountries.add(countryModel);
      }
    }

    return selectedCountries;
  }
}
