import 'dart:async';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/view/common_widget/soft_control.dart';
import '../../res/constants.dart';
import '../audio_list/file_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AudioList(),
            ));
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircularSoftButton(
              radius: 50,
              icon: const Icon(
                Icons.play_arrow_rounded,
                size: 50,
                color: Colors.blue,
              ),
            ),
          ),
          NeumorphicText(
            "Music",
            style: const NeumorphicStyle(
                color: Colors.blue,
                depth: 5,
                shadowLightColor: Colors.white,
                shadowDarkColor: Colors.black38,
                surfaceIntensity: 10),
            textStyle: NeumorphicTextStyle(
                fontSize: 35, height: 0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
