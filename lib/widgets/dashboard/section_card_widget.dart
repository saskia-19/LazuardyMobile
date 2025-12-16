import 'package:flutter/material.dart';

class SectionCardWidget extends StatelessWidget {
  final List<Widget> content;

  const SectionCardWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content,
        ),
      ),
    );
  }
}
