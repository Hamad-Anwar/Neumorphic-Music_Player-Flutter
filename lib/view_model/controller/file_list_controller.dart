import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/utils/utils.dart';
import 'package:path/path.dart' as path;

import '../../model/audio_file_model.dart';

class FilesController extends GetxController {
  final audioFiles = [].obs;
  final audioLength = [].obs;
  RxInt playedIndex = 999.obs;

  Future<void> getFiles(String _path) async {
    Utils.permissionRequest().then((value) async {
      if (value) {
        audioFiles.clear();
        audioLength.clear();
        Directory directory = Directory(_path);
        List<FileSystemEntity> files = await directory.list().toList();
        var temp = files
            .where((file) => (file.path.endsWith('.mp3') ||
                (file.path.endsWith('.wav')) ||
                (file.path.endsWith('.au')) ||
            (file.path.endsWith('.aac')) ||
                (file.path.endsWith('.smi'))))
            .toList();
        for (int i = 0; i < temp.length; i++) {
          String name = path.basename(temp[i].path);
          name = name.substring(0, name.indexOf('.'));
          if (name.length > 20) {
            name = name.substring(0, 19);
          }
          Utils.getFileLength(temp[i].path);
          audioFiles.add(AudioFiles(
              name: name,
              path: temp[i].path,
              size: File(temp[i].path).lengthSync()));
        }
      } else {
        Utils.permissionRequest();
      }
    }).onError((error, stackTrace) {});
  }

  Future<void> addToAlbum(String filePath, String fileName) async {
    if (File(filePath).existsSync()) {}

    var dir = await getApplicationDocumentsDirectory();
    File(filePath).copySync('${dir.path}/$fileName.mp3');
    if (File('${dir.path}/$fileName').existsSync()) {
    } else {}
  }
}
