import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../view_model/controller/bottom_player_controller.dart';
import '../../../view_model/controller/file_list_controller.dart';
import '../../common_widget/soft_control.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  final controller = Get.put(BottomPlayerController());
  final listController = Get.put(FilesController());
  late AnimationController _animationController;
  late Animation<Offset> _slideInAnimation;
  late Animation<Offset> _slideOutAnimation;

  @override
  void initState() {
    // TODO: implement initState
    // controller.setFilePath(controller.filePath.value);
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animationController.forward();
    animationController.addListener(() {
      controller.setProgress();

      if (animationController.isCompleted && controller.isPlaying.isTrue) {
        animationController.repeat();
      }
      if (controller.isPlaying.isFalse) {
        listController.playedIndex.value = 999;
        animationController.stop();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideInAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Slide from bottom to top
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut, // You can change the animation curve here
    ));

    _slideOutAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0), // Slide from top to bottom
      end: Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut, // You can change the animation curve here
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.reverse().then((value) {});
    _animationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationController.status == AnimationStatus.reverse
          ? _slideOutAnimation
          : _slideInAnimation,
      child: Stack(
        children: [
          Container(
            height: 80,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            height: 80,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          controller.fileName.value,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 15,
                        width: MediaQuery.sizeOf(context).width - 200,
                        child: Obx(
                          () => LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            lineHeight: 4,
                            percent: controller.progress.value,
                            progressColor: Colors.blue,
                            backgroundColor: Colors.white,
                            barRadius: const Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    listController.playedIndex.value = 999;
                    controller.pauseSong();
                  },
                  child: CircularSoftButton(
                    radius: 25,
                    lightColor: Colors.white24,
                    icon: const Icon(
                      Icons.pause,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
