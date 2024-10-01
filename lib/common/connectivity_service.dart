import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_insights/common/no_internert_page.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> event) {
    if (event.contains(ConnectivityResult.none)) {
      isConnected.value = false;
      // Get.to(() => NoInternetPage());
    } else {
      // Get.back();
      isConnected.value = true;
    }
  }

  void noData() => Get.to(() => const NoInternetPage());
}

class DependencyInjection {
  static void init() {
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
  }
}
