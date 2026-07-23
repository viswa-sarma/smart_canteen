import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        "title": "Dashboard",
        "icon": Icons.dashboard_outlined,
      },
      {
        "title": "Orders",
        "icon": Icons.receipt_long_outlined,
      },
      {
        "title": "Menu",
        "icon": Icons.restaurant_menu_outlined,
      },
      {
        "title": "Queue",
        "icon": Icons.groups_outlined,
      },
      {
        "title": "Inventory",
        "icon": Icons.inventory_2_outlined,
      },
      {
        "title": "Students",
        "icon": Icons.person_rounded,
      },
    ];

    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          /// Logo
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.restaurant_rounded,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Smart Canteen",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Admin Panel",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          const SizedBox(height: 16),

          /// Menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Material(
                    color: isSelected
                        ? Colors.green.shade50
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        onItemSelected(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item["icon"] as IconData,
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey.shade600,
                            ),

                            const SizedBox(width: 14),

                            Text(
                              item["title"] as String,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.green
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          /// Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () {
                // TODO: Logout
              },
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.red,
                    ),
                    SizedBox(width: 14),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}