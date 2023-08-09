import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:untitled/model/audio_file_model.dart';

import 'package:untitled/view/player/player_page.dart';

import '../../../view_model/controller/bottom_player_controller.dart';
import '../../../view_model/controller/file_list_controller.dart';
import '../../common_widget/soft_control.dart';

class ListViewFiles extends StatelessWidget {
  ListViewFiles({super.key});

  final controller = Get.put(FilesController());
  final bottomController = Get.put(BottomPlayerController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.audioFiles.isEmpty ?Expanded(
      child: Center(
        child: SizedBox(
          height: 15,
          width: 15,
          child: const CircularProgressIndicator(color: Colors.blue,),
        ),
      ),
    ) :const Expanded(
        child: AnimatedFileList()));
  }
}
class AnimatedFileList extends StatefulWidget {
  const AnimatedFileList({super.key});
  @override
  State<AnimatedFileList> createState() => _AnimatedFileListState();
}

class _AnimatedFileListState extends State<AnimatedFileList> {
  final controller = Get.put(FilesController());
  final bottomController = Get.put(BottomPlayerController());
  final GlobalKey<AnimatedListState> _key=GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      for (int i = 0; i < controller.audioFiles.length; i++) {

        _insertItemWithDelay(i);
      }
    });
  }

  void _insertItemWithDelay(int index) {
    Timer(Duration(milliseconds: index * 50), () {
      _key.currentState!.insertItem(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      padding: EdgeInsets.zero,
      key: _key,
      initialItemCount: 0,
      itemBuilder: (context, index,animation) {
        final slideAnimation = Tween<Offset>(
          begin: index % 2 == 0 ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.0,
            1.0,
            curve: Curves.easeOut, // You can change the animation curve here
          ),
        ));

        return SlideTransition(
            position:  slideAnimation,
        key: UniqueKey(),
        child :  GestureDetector(
            child: Obx(() => Container(
                height: 80,
                padding: const EdgeInsets.only(left: 20, right: 0),
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: controller.playedIndex.value == index ? Colors.lightBlueAccent.withOpacity(.2)  : null,
                child: Row(
                  children: [
                    Obx(
                          () => GestureDetector(
                        onTap: () {
                          if (controller.playedIndex.value == index) {
                            controller.playedIndex.value = 999;
                            bottomController.player.pause();
                            bottomController.isPlaying.value = false;
                          } else {
                            controller.playedIndex.value = index;
                            bottomController.setFilePath(
                                controller.audioFiles[index].path);
                          }

                        },
                        child: Hero(
                          tag: 'TAG$index',
                          child: CircularSoftButton(
                            lightColor: controller.playedIndex.value == index ? Colors.white38 :Colors.white38,
                            icon: controller.playedIndex.value == index
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
                        controller.playedIndex.value = 999;
                        bottomController.pauseSong();
                        Get.to(
                          PlayerPage(
                              tag: 'TAG$index',
                              file: AudioFiles(
                                  size: controller.audioFiles[index].size,
                                  path: controller.audioFiles[index].path,
                                  name: controller.audioFiles[index].name)),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.audioFiles[index].name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(
                                () => Text(
                              controller.audioLength.isNotEmpty && index<controller.audioLength.length
                                  ? controller.audioLength[index]
                                  : "",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
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
                          lightColor: controller.playedIndex.value == index ? Colors.white38 :Colors.white38,
                          radius: 20,
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.grey,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                )),)
        )
        );
      },
    );
  }
}
