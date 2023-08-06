import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/file_list_controller.dart';
import 'package:untitled/view/Home/widget/app_bar.dart';
import 'package:untitled/view/Home/widget/bottom_player.dart';
import 'package:untitled/view/Home/widget/list_view.dart';
import '../../controller/bottom_player_controller.dart';
import '../../res/app_path.dart';
import '../../res/constants.dart';

class AudioList extends StatefulWidget {
  final String path;
  const AudioList({super.key,this.path=AppPaths.musicPath});
  @override
  State<AudioList> createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  final controller = Get.put(FilesController());
  final bottomController=Get.put(BottomPlayerController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getFiles(widget.path);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
              children: [
                const CustomAppBar(),
                ListViewFiles()
              ],
            ),),
            Positioned(
                bottom: 1,
              left: 1,
              right: 1,
                  child:Obx(() =>  bottomController.isPlaying.value?  const BottomPlayer() :Container(
                    height: 1,
                    color: Colors.orange,
                  ))),

          ],
        )
      ),
    );
  }
}
