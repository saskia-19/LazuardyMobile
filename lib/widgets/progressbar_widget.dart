import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';

class ProgressbarWidget extends StatelessWidget {
  final double progressValue;
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  const ProgressbarWidget({
    super.key,
    required this.progressValue,
    this.height = 20,
    this.backgroundColor = AppColor.progressBarBackground,
    this.progressColor = AppColor.progressBarValue,
  });

  @override
  Widget build(BuildContext context) {
    final double clampedProgress = progressValue.clamp(0.0, 1.0);
    final int percentage = (clampedProgress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$percentage',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: progressColor,
          ),
        ),
        Container(
          height: 2,
          width: 25,
          color: progressColor,
        ),

        const SizedBox(height: 4),

        ClipRRect(
          borderRadius: BorderRadius.circular(height/2),
          child: Container(
            height: height,
            color: backgroundColor,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: clampedProgress,
              child: Container(
                color: progressColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
