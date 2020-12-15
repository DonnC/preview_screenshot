/// save device-preview screenshot to external storage of device
import 'dart:io';
import 'dart:typed_data';

import 'package:ext_storage/ext_storage.dart';
import 'permissions_service.dart';

Future<String> savePreviewScreenshot({Uint8List bytes, String directory: 'DevicePreviewScreenshots'}) async {
  final bool _permissionStorage = await hasConfirmedStoragePermission();

  if (_permissionStorage) {
    final extDirectory = await ExtStorage.getExternalStorageDirectory();
    final dirName    = await Directory('$extDirectory/$directory').create(recursive: true);
    final fname     = 'screenshot-${DateTime.now().toIso8601String()}.png';
    final fileP     = '${dirName.path}/$fname';

    final File file = File(fileP);

    final _result = await file.writeAsBytes(bytes, mode: FileMode.writeOnly);

    return _result.path;
  }

  else {
    await askStoragePermission();
    return '';
  }
}
