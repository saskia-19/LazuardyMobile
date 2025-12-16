import 'package:flutter/material.dart';

class HeaderDashboardWidget extends StatelessWidget {
  final String username;
  final BuildContext builderContext;

  const HeaderDashboardWidget({
    super.key,
    required this.username,
    required this.builderContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(builderContext).padding.top + 8,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Scaffold.of(builderContext).openDrawer(),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFFEEEEEE),
                        radius: 22,
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo $username',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Aktif',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.black54,
                      ),
                      onPressed: () => print('Open notifications'),
                    ),
                  ]
                )
              );
  }
}