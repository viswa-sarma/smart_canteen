import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome back, Admin 👋",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Here's what's happening in your canteen today.",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 30),

          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;

              if (constraints.maxWidth > 1100) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth > 600) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.3,
                children: const [
                  DashboardStatCard(
                    title: "Today's Orders",
                    value: "124",
                    icon: Icons.receipt_long,
                  ),
                  DashboardStatCard(
                    title: "Pending Orders",
                    value: "12",
                    icon: Icons.pending_actions,
                  ),
                  DashboardStatCard(
                    title: "Current Queue",
                    value: "23",
                    icon: Icons.groups,
                  ),
                  DashboardStatCard(
                    title: "Today's Revenue",
                    value: "₹8,540",
                    icon: Icons.currency_rupee,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Dashboard Stat Card
class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Temporary page used until actual screens are created.
class AdminPlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const AdminPlaceholderPage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 60,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "This page will be implemented next.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}