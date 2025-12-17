import 'package:flutter/material.dart';

class TopbarWidget extends StatelessWidget {
  final List<Widget> content;
  const TopbarWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content
      ),
    );
  }
}
