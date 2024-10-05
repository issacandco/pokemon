import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum StorageEnum {
  temporaryDirectory,
  applicationDocumentsDirectory,
  externalStorageDirectory,
}

extension StorageUtilExtension on StorageEnum {
  String get description {
    switch (this) {
      case StorageEnum.temporaryDirectory:
        return 'temporaryDirectory';
      case StorageEnum.applicationDocumentsDirectory:
        return 'applicationDocumentsDirectory';
      case StorageEnum.externalStorageDirectory:
        return 'externalStorageDirectory';
      default:
        return 'UNKNOWN';
    }
  }
}

class GeneralUtil {
  /// Hides the keyboard.
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  /// Hides the status bar.
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  /// Makes the status bar transparent.
  static void transparentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  /// Changes the status bar color.
  static void changeStatusBarColor({Color? color}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color ?? Colors.transparent,
      ),
    );
  }

  /// Shows the status bar.
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  /// Creates a folder in the specified storage location.
  static Future<String?> createFolder(String folderName, StorageEnum storageEnum) async {
    Directory? directory;
    try {
      switch (storageEnum) {
        case StorageEnum.temporaryDirectory:
          directory = await getTemporaryDirectory();
          break;
        case StorageEnum.applicationDocumentsDirectory:
          directory = await getApplicationDocumentsDirectory();
          break;
        case StorageEnum.externalStorageDirectory:
          directory = await getExternalStorageDirectory();
          break;
      }
      final Directory directoryFolder = Directory('${directory!.path}/$folderName/');
      if (await directoryFolder.exists()) {
        return directoryFolder.path;
      } else {
        final Directory createDirectory = await directoryFolder.create(recursive: true);
        return createDirectory.path;
      }
    } catch (e) {
      debugPrint('Error creating folder: $e');
      return null;
    }
  }

  /// Deletes the specified file.
  static Future<void> deleteFile(File? file) async {
    if (file == null) return;
    try {
      if (await file.exists()) await file.delete();
    } catch (e) {
      debugPrint('Error deleting file: $e');
    }
  }

  /// Gets the device size.
  static Size getDeviceSize(BuildContext context) {
    var pixelRatio = View.of(context).devicePixelRatio;
    var logicalScreenSize = View.of(context).physicalSize / pixelRatio;
    return logicalScreenSize;
  }

  /// Gets the current locale.
  static String getCurrentLocale(BuildContext context) {
    Locale? locale = Localizations.maybeLocaleOf(context);
    return locale?.toString() ?? Intl.systemLocale;
  }
}
