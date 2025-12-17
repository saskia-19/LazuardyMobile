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
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: 0.5),
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

class SectionWidget extends StatelessWidget {
  final List<Widget> content;
  const SectionWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: BorderSide(
          color: Colors.blue, // Warna border
          width: 2,           // Ketebalan border
        ),
      ),
      shadowColor: Colors.black.withValues(alpha: 0.5),
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
