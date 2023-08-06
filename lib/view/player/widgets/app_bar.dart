import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import '../../common_widget/soft_control.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.onBackPress});
  final VoidCallback onBackPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            onBackPress();
            Get.back();
          },
          child: CircularSoftButton(
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        NeumorphicText(
          "Player",
          style: const NeumorphicStyle(
              color: Colors.blue,
              depth: 5,
              shadowLightColor: Colors.white,
              shadowDarkColor: Colors.black38,
              surfaceIntensity: 10),
          textStyle: NeumorphicTextStyle(
              fontSize: 20, height: 0, fontWeight: FontWeight.bold),
        ),
        CircularSoftButton(
          icon: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }
}
