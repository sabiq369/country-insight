import 'package:country_insights/common/connectivity_service.dart';
import 'package:country_insights/common/no_internert_page.dart';
import 'package:country_insights/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:svg_flutter/svg.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final ConnectivityController _connectivityController =
      Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_connectivityController.isConnected.value) {
        final DashboardController dashboardController =
            Get.put(DashboardController());
        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Country Insight',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
                child: dashboardController.onLoad.value
                    ? Center(
                        child: Lottie.asset("assets/images/loading.json"),
                      )
                    : dashboardController.countryDetails.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/images/no_data_found.json"),
                              const Text('No Data Found!')
                            ],
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: DataTable(
                                  columns: const <DataColumn>[
                                    DataColumn(label: Text('No')),
                                    DataColumn(label: Text('Common Name')),
                                    DataColumn(label: Text('Official Name')),
                                    DataColumn(label: Text('Currency Name')),
                                    DataColumn(label: Text('Country Flag')),
                                  ],
                                  rows: List.generate(
                                    dashboardController.countryDetails.length,
                                    (index) {
                                      return DataRow(cells: <DataCell>[
                                        cell(text: '${index + 1}'),
                                        cell(
                                            text: dashboardController
                                                .countryDetails[index]
                                                .name!
                                                .common),
                                        cell(
                                            text: dashboardController
                                                .countryDetails[index]
                                                .name!
                                                .official),
                                        cell(
                                          text: () {
                                            switch (dashboardController
                                                .countryDetails[index]
                                                .name!
                                                .common) {
                                              case 'Germany':
                                                return 'EUR Euro';
                                              case 'India':
                                                return 'INR Indian Rupee';
                                              case 'Israel':
                                                return 'ILS Israeli new shekel';
                                              case 'Sri Lanka':
                                                return 'LKR Sri Lankan rupee';
                                              case 'Italy':
                                                return 'EUR Euro';
                                              case 'Taiwan':
                                                return 'TWD New Taiwan dollar';
                                              case 'North Korea':
                                                return 'KPW North Korean won';
                                              default:
                                                return 'No Currency Found';
                                            }
                                          }(),
                                        ),
                                        cell(
                                            text: dashboardController
                                                .countryDetails[index]
                                                .flags!
                                                .svg,
                                            showFlag: true)
                                      ]);
                                    },
                                  )),
                            ),
                          )),
            floatingActionButton: Row(
              children: [
                const SizedBox(width: 35),
                if (dashboardController.countryDetails.isNotEmpty &&
                    !dashboardController.onLoad.value)
                  FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    sortButton(
                                        onPress: () =>
                                            dashboardController.sortAZ(),
                                        text: 'Sort A-Z'),
                                    const SizedBox(height: 5),
                                    sortButton(
                                        onPress: () =>
                                            dashboardController.sortRegion(),
                                        text: 'Region'),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.black,
                    child: const Icon(
                      Icons.filter_alt,
                      color: Colors.white,
                    ),
                  ),
                const Spacer(),
                if (!dashboardController.onLoad.value)
                  FloatingActionButton(
                    onPressed: () => dashboardController.apiCall(),
                    backgroundColor: Colors.black,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        );
      } else {
        return const NoInternetPage();
      }
    });
  }

  borderSide() {
    return const BorderSide(
      color: Colors.black,
    );
  }

  textData({required String text}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: borderSide(),
          left: borderSide(),
          bottom: borderSide(),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  cell({required String text, bool showFlag = false}) {
    return showFlag
        ? DataCell(SvgPicture.network(
            text,
            fit: BoxFit.fill,
            width: 50,
          ))
        : DataCell(Text(text));
  }

  sortButton({required String text, required void Function()? onPress}) {
    return TextButton(
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ));
  }
}
