import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LocalStorageService extends GetxService {
  static final storage = FlutterSecureStorage();

  static void write(String v) async {
    await storage.write(key: 'token', value: v);
  }

  static void remove(String value) async {
    await storage.delete(key: 'token');
  }
  static Future<String?> getToken() async {
   return await storage.read(key: 'token');
  }
  static Future<String?> getUid() async {
    return await storage.read(key: 'userID');
  }
  static Future<String?> writeUid(String value) async {
    await storage.write(key: 'userID',value: value);
  }
}
