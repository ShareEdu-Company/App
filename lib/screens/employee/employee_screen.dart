import 'package:flutter/material.dart';
import 'package:almaraqischool/utils/constants/urls.dart';
import '../../data/models/main_item_model.dart';
import '../../shared/app_bar_widget.dart';
import '../../shared/main_screen_item.dart';

class EmployeeScreen extends StatelessWidget {
  static const routeName = "/employee";
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientaion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: const AppBarWidget(title: "الموظف", hasBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: orientaion == Orientation.portrait ? 3 : 5,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 16,
          crossAxisSpacing: 10,
          children: _employeeItems.map((guestItem) {
            return MainScreenItem(mainItem: guestItem);
          }).toList(),
        ),
      ),
    );
  }

  static final List<MainItem> _employeeItems = [
    MainItem(
      imageName: "notification",
      title: "الخدمات",
      webLink: AppUrls.empService,
    ),
    MainItem(
      imageName: "transefers",
      title: "المعاملات الإلكترونية",
      webLink: AppUrls.empTrans,
    ),
    MainItem(
      imageName: "msgs",
      title: "بريدي ورسائلي",
      webLink: AppUrls.empMsgs,
    ),
    MainItem(
      imageName: "notification",
      title: "الإشعارات",
      webLink: AppUrls.empNoti,
    ),
    MainItem(
      imageName: "track",
      title: "التتبع",
      webLink: AppUrls.empTrack,
    ),
    MainItem(
      imageName: "setting",
      title: "الإعدادات الأساسية",
      webLink: AppUrls.empSettings,
    ),
  ];
}
