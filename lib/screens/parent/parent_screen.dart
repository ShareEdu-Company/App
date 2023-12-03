import 'package:flutter/material.dart';
import 'package:almaraqischool/utils/constants/urls.dart';

import '../../data/models/main_item_model.dart';
import '../../shared/app_bar_widget.dart';
import '../../shared/main_screen_item.dart';

class ParentScreen extends StatelessWidget {
  static const routeName = "/parent";
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientaion = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: const AppBarWidget(title: "ولي الأمر", hasBackButton: false),
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
      imageName: "service",
      title: "الخدمات التعليمية",
      webLink: AppUrls.parService,
    ),
    MainItem(
      imageName: "fees",
      title: "الرسوم الدراسية",
      webLink: AppUrls.parFees,
    ),
    MainItem(
      imageName: "track",
      title: "التتبع",
      webLink: AppUrls.parTrack,
    ),
    MainItem(
      imageName: "notification",
      title: "الإشعارات",
      webLink: AppUrls.parNoti,
    ),
    MainItem(
      imageName: "autoCall",
      title: "النداء الآلي",
      webLink: AppUrls.parAutoCall,
    ),
    MainItem(
      imageName: "problems",
      title: "الشكاوى الأكاديمية",
      webLink: AppUrls.parProblems,
    ),
    MainItem(
      imageName: "contacts",
      title: "دليل الهواتف",
      webLink: AppUrls.parCallUS,
    ),
  ];
}
