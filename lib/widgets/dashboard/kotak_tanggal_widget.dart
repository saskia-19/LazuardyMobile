import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';

class KotakTanggalWidget extends StatelessWidget {
  final String hari;
  final DateTime tanggal;
  final bool isSelected;
  final VoidCallback onTap;
  const KotakTanggalWidget({
    super.key,
    required this.hari,
    required this.tanggal,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primary),
          color: isSelected? AppColor.primary : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              hari,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              '${tanggal.day}',
              style: TextStyle(color: isSelected ? Colors.white : Colors.black87),
            ),
          ],
        ),
      ),
    );  
  }
}
