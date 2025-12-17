import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/dashboard/topbar_widget.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [
          TopbarWidget(
            content: [
              Text(
                'Presensi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          )
        ],
      ),
    );
  }
}
