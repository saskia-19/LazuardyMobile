import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String iconAsset;
  final String label;
  final Function() onTap;
  const MenuItemWidget({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconAsset,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 8,),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}