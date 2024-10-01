import 'package:country_insights/common/api.dart';
import 'package:country_insights/views/splash_screen/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Services {
  final Dio _dio = Dio();

  getCountryList({required String countryName}) async {
    try {
      var response = await _dio.get('${Api.specificCountry}$countryName');
      if (response.statusCode == 200) {
        return response.data[0];
      }
    } catch (e) {
      Get.offAll(() => SplashScreen());
    }
  }
}
