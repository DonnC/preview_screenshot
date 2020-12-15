/// handle all app permission requests here
import 'package:permission_handler/permission_handler.dart';

Future<void> askStoragePermission() async {
  await Permission.storage.request();
}

Future<bool> hasConfirmedStoragePermission() async {
  final PermissionStatus storage = await Permission.storage.status;

  return storage.isGranted;
}