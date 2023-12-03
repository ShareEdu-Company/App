import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almaraqischool/screens/login/login_provider.dart';

import '../../data/local_database/local_database.dart';

enum FirstLaunchStatus { authed, notAuthed }

final rootScreenProvider = FutureProvider<FirstLaunchStatus>(
  (ref) async {
    await LocalDatabase.openHiveBox();
    await Future.delayed(const Duration(seconds: 1));
    if (!LocalDatabase.isUserAuthenticated()) {
      return FirstLaunchStatus.notAuthed;
    }
    if (kDebugMode) {
      print("auth status: ${LocalDatabase.isUserAuthenticated()}");
    }

    final int userIndex = LocalDatabase.getUserIndex()!;
    if (userIndex == 1) {
      ref.read(userTypeProvider.notifier).state = UserType.employee;
    } else if (userIndex == 4) {
      ref.read(userTypeProvider.notifier).state = UserType.trackedEmployee;
    } else if (userIndex == 2) {
      ref.read(userTypeProvider.notifier).state = UserType.student;
    } else if (userIndex == 3) {
      ref.read(userTypeProvider.notifier).state = UserType.parent;
    }
    return FirstLaunchStatus.authed;
  },
);
