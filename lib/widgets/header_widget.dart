import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/pages/auth/login_page.dart';

class LogoHeaderWidget extends StatelessWidget {
  final double logoHeight;
  final double spacing;
  final bool withTextLogo;
  final String image;

  const LogoHeaderWidget({
    super.key,
    this.logoHeight = 80,
    this.spacing = 32,
    this.withTextLogo = false,
    this.image = 'assets/images/logo_lazuardi_noText.png',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(image, height: logoHeight),

              if (withTextLogo) ...[
                const SizedBox(width: 12),
                const Text(
                  'Bimbel Lazuardy',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: spacing),
      ],
    );
  }
}

class HeaderTextWidget extends StatelessWidget {
  final String textHeader;
  final String? textSubHeader;
  final String? textLink;

  const HeaderTextWidget({
    super.key,
    required this.textHeader,
    this.textSubHeader,
    this.textLink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textHeader,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.fontPrimary,
          ),
        ),

        if (textSubHeader != null) ...[
          const SizedBox(height: 8),
          Text(
            textSubHeader!,
            style: TextStyle(fontSize: 14, color: AppColor.inactiveTextField),
          ),
          SizedBox(width: 4),
          if(textLink != null)...[
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text(
                textLink!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
            ),
          ]
        ],
      ],
    );
  }
}
