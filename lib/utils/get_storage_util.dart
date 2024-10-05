import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

typedef StorageBuilder<S> = S Function(Map<String, dynamic> storageData);

class GetStorageUtil {
  GetStorageUtil._();

  static Future<bool> initGetStorage([String containerName = Constants.appName]) {
    return GetStorage.init(containerName);
  }

  static Future<void> saveIntoGetStorage({required String key, dynamic value, String? containerName = Constants.appName}) {
    return GetStorage(containerName!).write(key, value);
  }

  static T? readFromGetStorage<T>({required String key, String? containerName = Constants.appName}) {
    return GetStorage(containerName!).read<T>(key);
  }

  static Future<void> removeByKey({required String key, String? containerName = Constants.appName}) {
    return GetStorage(containerName!).remove(key);
  }

  static Future<void> eraseGetStorage({String? containerName = Constants.appName}) {
    return GetStorage(containerName!).erase();
  }

  /// Get storage data is Map<String, dynamic>, cannot directly convert Map to Model (Object)
  /// This function is to prevent '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type {}
  /// NOTE: If no key found, this function will return null
  /// example: getStorageDataByKey<YourModel>('key', (storageData) => YourModel.fromJson(storageData));
  static T? getStorageDataByKey<T>(String key, StorageBuilder<T> builder, {String? containerName}) {
    var storageData = readFromGetStorage(
      key: key,
      containerName: containerName,
    );
    return storageData != null
        ? storageData is T
        ? storageData
        : storageData is Map<String, dynamic>
        ? builder.call(storageData)
        : storageData
        : null;
  }

  static List<String>? readStringListFromGetStorage({required String key, String? containerName}) {
    var storageData = readFromGetStorage<List<dynamic>>(key: key, containerName: containerName);
    return storageData?.map((e) => e.toString()).toList();
  }

  static List<T>? readListFromGetStorage<T>({required String key, String? containerName}) {
    var storageData = readFromGetStorage<List<dynamic>>(key: key, containerName: containerName);
    if (storageData == null) return null;
    try {
      return storageData.map((e) => e as T).toList();
    } catch (e) {
      return null;
    }
  }
}
