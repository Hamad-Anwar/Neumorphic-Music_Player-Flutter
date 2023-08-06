import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FolderController extends GetxController {
  final folderList = [].obs;

  Future<void> getList() async {
    final audioQuery = OnAudioQuery();
    List<String> folders = await audioQuery.queryAllPath();
    folderList.clear();
    for (var folder in folders) {
      folderList.add(folder);
    }
  }
}
