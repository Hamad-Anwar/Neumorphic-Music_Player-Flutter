
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:untitled/model/audio_file_model.dart';
import 'package:untitled/view/common_widget/soft_control.dart';
import 'package:untitled/view/player/widgets/app_bar.dart';
import '../../res/constants.dart';
import '../../view_model/controller/player_controller.dart';

class PlayerPage extends StatefulWidget {
  final AudioFiles file;
  final String tag;
  const PlayerPage({super.key, required this.file, required this.tag});

  @override
  PlayerPageState createState() => PlayerPageState();
}

class PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animationController.forward();
    animationController.addListener(() {
      controller.angle.value = animationController.value;

        controller.setProgress();

      if (animationController.isCompleted && controller.isPlaying.isTrue) {
        animationController.repeat();
      }
      if (controller.isPlaying.isFalse) {
        animationController.stop();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    animationController.dispose();
  }


  void onBackPress(){
    animationController.stop();
    controller.player.stop();
    controller.isPlaying.value = false;
  }

  @override
  Widget build(BuildContext context) {
    controller.setFilePath(widget.file.path);
    return WillPopScope(
      onWillPop: () async {
        onBackPress();
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CustomAppBar(onBackPress: onBackPress),
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 150,
                    height: MediaQuery.of(context).size.width - 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width),
                      gradient: LinearGradient(
                        colors: [shadowColor, lightShadowColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            offset: const Offset(8, 6),
                            blurRadius: 12),
                        BoxShadow(
                            color: lightShadowColor,
                            offset: const Offset(-8, -6),
                            blurRadius: 12),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Obx(
                            () => Transform.rotate(
                          angle: 6.3 * controller.angle.value,
                          child: CircleAvatar(
                              backgroundImage:
                              Image.asset('assets/test4.png',fit: BoxFit.fill,).image),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                widget.file.name,
                style: TextStyle(fontSize: 28, color: textColor),
              ),
              Text(
                'Future',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              const SizedBox(height: 32),
              Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    width: double.infinity,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: lightShadowColor,
                            offset: const Offset(1, 4)),
                        BoxShadow(
                            color: shadowColor, offset: const Offset(-1, -4)),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 2,
                      bottom: 2,
                      left: 30,
                      child: SizedBox(
                        height: 30,
                        width: MediaQuery.sizeOf(context).width - 60,
                        child: Obx(
                          () => LinearPercentIndicator(
                            lineHeight: 15,
                            percent: controller.progress.value,
                            progressColor: Colors.lightBlue,
                            backgroundColor: Colors.transparent,
                            barRadius: const Radius.circular(20),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Obx(
                      () => Text(
                        controller.currentLength.value,
                        style: TextStyle(fontSize: 20, color: textColor),
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.totalLength.value,
                        style: TextStyle(fontSize: 20, color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.seekBack();
                    },
                    child: CircularSoftButton(
                      radius: 20,
                      icon: const Icon(Icons.skip_previous),
                    ),
                  ),
                  Obx(
                    () => Hero(
                      tag: widget.tag,
                      child: GestureDetector(
                        onTap: () {
                          controller.setPlay();
                          if (controller.isPlaying.isTrue) {
                            animationController.forward();
                          } else {
                            animationController.stop();
                          }
                        },
                        child: controller.isPlaying.value
                            ? CircularSoftButton(
                                icon: Icon(
                                  Icons.pause,
                                  size: 48,
                                  color: seekBarDarkColor,
                                ),
                                radius: 48,
                              )
                            : CircularSoftButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 48,
                                  color: seekBarDarkColor,
                                ),
                                radius: 48,
                              ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.seekForward(),
                    child: CircularSoftButton(
                      radius: 20,
                      icon: const Icon(Icons.skip_next),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.volume_down_rounded,
                    color: Colors.grey,
                    size: 25,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(
                        height: 10,
                        child: Obx(
                          () => Slider(
                            min: 0,
                            max: 1,
                            activeColor: Colors.blue,
                            inactiveColor: Colors.grey.withOpacity(.5),
                            value: controller.volume.value,
                            onChanged: (value) {
                              controller.volume.value = value;
                              controller.setVol();
                            },
                          ),
                        )),
                  )),
                  const Icon(
                    Icons.volume_up_rounded,
                    color: Colors.grey,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
