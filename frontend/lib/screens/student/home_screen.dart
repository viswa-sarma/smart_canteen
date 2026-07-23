import 'package:flutter/material.dart';
import 'package:smart_canteen/screens/student/cart_screen.dart';
import 'package:smart_canteen/screens/student/orders_screen.dart';

import '../../widgets/student/app_header.dart';
import '../../widgets/student/search_bar.dart';
import '../../widgets/student/queue_cards.dart';
import '../../widgets/student/category_section.dart';
import '../../widgets/student/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              const AppHeader(
                userName: "Ajay",
              ),

              const SizedBox(height: 24),

              /// Search Bar
              SearchBarWidget(
                controller: searchController,
                onChanged: (value) {
                  debugPrint(value);
                },
                onFilterTap: () {
                  debugPrint("Filter Clicked");
                },
              ),

              const SizedBox(height: 24),

              /// Queue Cards
              const QueueCards(
                currentQueue: 23,
                waitingTime: "15-20 min",
              ),

              const SizedBox(height: 32),

              /// Categories
              const CategorySection(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {

          if(index==2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen())
            );
            return;
          }

          if(index==3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrdersScreen())
            );
            return;
          }

          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}