import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:almaraqischool/data/models/main_item_model.dart';
import 'package:almaraqischool/shared/main_screen_item.dart';
import 'package:almaraqischool/utils/constants/urls.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';
import '../../shared/app_bar_widget.dart';

class GuestScreen extends StatelessWidget {
  static const String routeName = "/guest";
  GuestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final orientaion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBarWidget(
        title: LocaleKeys.guestRegister.tr(),
        hasBackButton: true,
        hasTrackingButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: orientaion == Orientation.portrait ? 2 : 4,
          childAspectRatio: 1.5,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 16,
          crossAxisSpacing: 10,
          children: _guestItems.map((guestItem) {
            return MainScreenItem(mainItem: guestItem);
          }).toList(),
        ),
      ),
    );
  }

  final List<MainItem> _guestItems = [
    MainItem(
      imageName: "about_school",
      title: LocaleKeys.visAboutUs.tr(),
      webLink: AppUrls.visAboutUs,
    ),
    MainItem(
      imageName: "teacher",
      title: LocaleKeys.visSchoolAccess.tr(),
      webLink: AppUrls.visSchoolAccess,
    ),
    MainItem(
      imageName: "contacts",
      title: LocaleKeys.visCallUS.tr(),
      webLink: AppUrls.visCallUS,
    ),
    MainItem(
      imageName: "registraion",
      title: LocaleKeys.visRegistraion.tr(),
      webLink: AppUrls.visRegistraion,
    ),
    MainItem(
      imageName: "guests",
      title: LocaleKeys.visBook.tr(),
      webLink: AppUrls.visBook,
    ),
    MainItem(
      imageName: "tawzif",
      title: LocaleKeys.visEmployment.tr(),
      webLink: AppUrls.visEmployment,
    ),
    MainItem(
      imageName: "images",
      title: LocaleKeys.visPhotoalbum.tr(),
      webLink: AppUrls.visPhotoalbum,
    ),
    MainItem(
      imageName: "news",
      title: LocaleKeys.visNews.tr(),
      webLink: AppUrls.visNews,
    ),
  ];
}
