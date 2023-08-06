import 'package:flutter/material.dart';
import '../../res/constants.dart';

class CircularSoftButton extends StatelessWidget {
  double? radius;
  final Widget? icon;
  final Color lightColor;
  CircularSoftButton({super.key,  this.radius, this.icon, this.lightColor=Colors.white}){
    if (radius == null || radius! <= 0) radius = 32;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(radius! / 2),
      child: Stack(
        children: <Widget>[
          Container(
            width: radius! * 2,
            height: radius! * 2,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius!),
              boxShadow: [
                BoxShadow(
                    color: shadowColor, offset: Offset(8, 6), blurRadius: 12),
                BoxShadow(
                    color: lightColor,
                    offset: Offset(-8, -6),
                    blurRadius: 12),
              ],
            ),
          ),
          Positioned.fill(child: icon!),
        ],
      ),
    );
  }
}
