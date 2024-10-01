import 'package:country_insights/common/connectivity_service.dart';
import 'package:country_insights/common/no_internert_page.dart';
import 'package:country_insights/views/dashboard/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final ConnectivityController _connectivityController =
      Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_connectivityController.isConnected.value) {
        Future.delayed(
          const Duration(seconds: 3),
          () => Get.off(() => Dashboard()),
        );
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Lottie.asset("assets/images/splash_screen.json"),
            ),
          ),
        );
      } else {
        return const NoInternetPage();
      }
    });
  }
}
