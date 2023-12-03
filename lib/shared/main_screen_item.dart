import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:almaraqischool/screens/web_view_screen/web_view_screen.dart';
import '../data/models/main_item_model.dart';

class MainScreenItem extends StatelessWidget {
  final MainItem mainItem;
  const MainScreenItem({
    super.key,
    required this.mainItem,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        if (kDebugMode) {
          print("web link ${mainItem.webLink}");
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              pageUrl: mainItem.webLink,
              title: mainItem.title,
              isGuestPage: true,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 110,
        height: 125,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: const Color(0xff0E4D68),
            // width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/${mainItem.imageName}.png"),
            const SizedBox(height: 8),
            Text(
              mainItem.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff0E4D68),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
