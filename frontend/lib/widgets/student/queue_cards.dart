import 'package:flutter/material.dart';

class QueueCards extends StatelessWidget {
  final int currentQueue;
  final String waitingTime;

  const QueueCards({
    super.key,
    required this.currentQueue,
    required this.waitingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _infoCard(
            icon: Icons.groups_rounded,
            title: "Current Queue",
            value: "$currentQueue",
            subtitle: "People Waiting",
            iconColor: Colors.green,
            cardColor: Colors.green.shade50,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _infoCard(
            icon: Icons.access_time_rounded,
            title: "Waiting Time",
            value: waitingTime,
            subtitle: "Estimated",
            iconColor: Colors.orange,
            cardColor: Colors.orange.shade50,
          ),
        ),
      ],
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color iconColor,
    required Color cardColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}