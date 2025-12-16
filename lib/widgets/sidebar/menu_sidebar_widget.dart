import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';

class MenuSidebarWidget extends StatelessWidget {
  final String title;
  final String iconAsset;
  const MenuSidebarWidget({
    super.key,
    required this.iconAsset,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      height: 60,
      width: 290,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Image.asset(iconAsset, width: 30, height: 30),
          SizedBox(width: 16),
          Text(title, style: TextStyle(fontSize: 18, color: Colors.black)),
        ],
      ),
    );
  }
}
