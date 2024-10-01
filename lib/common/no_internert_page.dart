import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset(
            "assets/images/no_internet.json",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            reverse: true,
          ),
        ),
      ),
    );
  }
}
