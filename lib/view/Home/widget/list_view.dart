import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/files_model.dart';
import 'package:untitled/view/player/player_page.dart';

import '../../../controller/bottom_player_controller.dart';
import '../../../controller/file_list_controller.dart';
import '../../common_widget/soft_control.dart';
class ListViewFiles extends StatelessWidget {
   ListViewFiles({super.key});
  final controller = Get.put(FilesController());
  final bottomController=Get.put(BottomPlayerController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
        child: ListView.builder(
          itemCount: controller.audioFiles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
              },
              child: Container(
                  height: 80,
                  padding: const EdgeInsets.only(left: 20,right: 0),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Obx(
                            () => GestureDetector(
                          onTap: () {
                            if (controller.playedIndex.value == index) {
                              controller.playedIndex.value = 999;
                              bottomController.player.pause();
                              bottomController.isPlaying.value=false;
                            } else {
                              controller.playedIndex.value = index;
                              bottomController.setFilePath(controller.audioFiles[index].path);
                            }
                          },
                          child: Hero(
                            tag: 'TAG$index',
                            child: CircularSoftButton(
                              icon:
                              controller.playedIndex.value == index
                                  ? const Icon(
                                Icons.pause,
                                color: Colors.lightBlue,
                              )
                                  : const Icon(
                                Icons.play_arrow,
                                color: Colors.lightBlue,
                              ),
                              radius: 25,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.playedIndex.value=999;
                          bottomController.pauseSong();
                          Get.to(
                            PlayerPage(
                                tag : 'TAG$index',
                                file: AudioFiles(
                                    size: controller
                                        .audioFiles[index].size,
                                    path: controller
                                        .audioFiles[index].path,
                                    name: controller
                                        .audioFiles[index].name)),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.audioFiles[index].name,
                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(controller.audioFiles[index].size
                                .toString(),
                              style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            controller.addToAlbum(
                                controller.audioFiles[index].path,
                                '${controller.audioFiles[index].name}');
                          },
                          child: CircularSoftButton(
                            radius: 20,
                            icon: const Icon(Icons.more_horiz_rounded,color: Colors.grey,),
                          )
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  )),
            );
          },
        )));
  }
}
