import 'package:flutter/material.dart';
import 'package:smart_canteen/screens/admin/admin_dashboard_screen.dart';
import 'package:smart_canteen/screens/admin/admin_inventory_screen.dart';
import 'package:smart_canteen/screens/admin/admin_kitchen_queue_screen.dart';
import 'package:smart_canteen/screens/admin/admin_menu_screen.dart';
import 'package:smart_canteen/screens/admin/admin_orders_screen.dart';
import 'package:smart_canteen/screens/admin/admin_students_screen.dart';
import 'package:smart_canteen/widgets/admin/admin_sidebar.dart';


class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int selectedIndex = 0;

  final List<String> pageTitles = const [
    "Dashboard",
    "Orders",
    "Menu Management",
    "Queue Management",
    "Inventory",
    "Students",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    // Sidebar is permanently visible on larger screens.
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      /// Mobile / Tablet Drawer
      drawer: isDesktop
          ? null
          : Drawer(
              child: AdminSidebar(
                selectedIndex: selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });

                  Navigator.pop(context);
                },
              ),
            ),

      body: Row(
        children: [
          /// Desktop Sidebar
          if (isDesktop)
            AdminSidebar(
              selectedIndex: selectedIndex,
              onItemSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),

          /// Main Content
          Expanded(
            child: Column(
              children: [
                /// Top Navigation Bar
                _buildTopBar(
                  context,
                  isDesktop,
                ),

                /// Page Content
                Expanded(
                  child: _buildCurrentPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Top Bar
  Widget _buildTopBar(
    BuildContext context,
    bool isDesktop,
  ) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
          ),
        ),
      ),
      child: Row(
        children: [
          /// Menu Button
          if (!isDesktop)
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_rounded,
                  ),
                );
              },
            ),

          if (!isDesktop)
            const SizedBox(width: 12),

          /// Page Title
          Expanded(
            child: Text(
              pageTitles[selectedIndex],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// Notifications
          IconButton(
            onPressed: () {},
            icon: const Badge(
              child: Icon(
                Icons.notifications_none_rounded,
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// Admin Profile
          const CircleAvatar(
            backgroundColor: Color(0xFFE8F5E9),
            child: Icon(
              Icons.person,
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 10),

          if (screenWidthGreaterThan(context, 700))
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Canteen Admin",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Administrator",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// Display Selected Page
  Widget _buildCurrentPage() {
    switch (selectedIndex) {
      case 0:
        return const AdminDashboardScreen();

      case 1:
        return const AdminOrdersScreen();

      case 2:
        return const AdminMenuScreen();

      case 3:
        return const AdminKitchenQueueScreen();

      case 4:
        return const AdminInventoryScreen();

      case 5:
        return const AdminStudentsScreen();

      case 6:
        return const AdminPlaceholderPage(
          title: "Settings",
          icon: Icons.settings_outlined,
        );

      default:
        return const AdminDashboardScreen();
    }
  }

  bool screenWidthGreaterThan(
    BuildContext context,
    double width,
  ) {
    return MediaQuery.sizeOf(context).width > width;
  }
}
