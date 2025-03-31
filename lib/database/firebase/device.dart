
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

Future<String> getDeviceId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? deviceId = prefs.getString('deviceId');

  if (deviceId == null) {
    deviceId = Uuid().v4();
    await prefs.setString('deviceId', deviceId);
  }

  return deviceId;
}