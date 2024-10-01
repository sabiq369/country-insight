import 'package:country_insights/services/services.dart';
import 'package:country_insights/views/dashboard/model/country_list.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxList<dynamic> countryDetails = [].obs;
  List<String> countries = [
    'germany',
    'india',
    'israel',
    'lanka',
    'italy',
    'china',
    'korea',
  ];
  RxBool onLoad = false.obs;
  apiCall() async {
    if (onLoad.value) return;
    onLoad.value = true;
    countryDetails.clear();
    for (int i = 0; i < countries.length; i++) {
      var data = await Services().getCountryList(countryName: countries[i]);
      if (data != null) {
        countryDetails.add(CountryDetailsModel.fromJson(data));
      }
    }
    onLoad.value = false;
  }

  sortAZ() {
    countryDetails.sort((a, b) {
      final aCommon = a.name?.common ?? '';
      final bCommon = b.name?.common ?? '';

      return aCommon.compareTo(bCommon);
    });
    Get.back();
  }

  sortRegion() {
    countryDetails.sort((a, b) {
      final aCommon = a.region ?? '';
      final bCommon = b.region ?? '';
      return aCommon.compareTo(bCommon);
    });
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    apiCall();
  }
}
