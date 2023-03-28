import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String?> get downloadDirPath async {
  Directory? directory = Directory('/storage/emulated/0/Download');

  if (!await directory.exists()) {
    if (Platform.isAndroid)
      directory = await getExternalStorageDirectory();
    else
      directory = await getApplicationDocumentsDirectory();
  }

  return directory?.path;
}

Future<File?> uploadFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result == null || result.files.single.path == null) return null;
  return File(result.files.single.path!);
}

Future<File> createFile(String path, String fileName, String data) async {
  File jsonFile = File("$path/$fileName");
  if (!(await jsonFile.exists())) await jsonFile.create();

  return await jsonFile.writeAsString(data);
}
