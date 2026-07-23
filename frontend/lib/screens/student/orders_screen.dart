import 'package:flutter/material.dart';
import 'package:smart_canteen/screens/student/order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "id": "ORD2345",
        "items": "Masala Dosa, Tea",
        "price": 95,
        "date": "Today • 10:55 AM",
        "status": "Delivered",
      },
      {
        "id": "ORD2344",
        "items": "Veg Biryani",
        "price": 120,
        "date": "Yesterday",
        "status": "Delivered",
      },
      {
        "id": "ORD2343",
        "items": "Samosa, Tea",
        "price": 35,
        "date": "2 Aug",
        "status": "Delivered",
      },
      {
        "id": "ORD2342",
        "items": "Chicken Roll",
        "price": 90,
        "date": "5 Aug",
        "status": "Delivered",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),  
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return GestureDetector(
            onTap: () {
              // Future navigation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailScreen(
                    orderId: order["id"].toString(),
                  ),
                ),
              );

              debugPrint("Open ${order["id"]}");
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Text(
                        "#${order["id"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        "₹${order["price"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    order["items"].toString(),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Text(
                        order["date"].toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        order["status"].toString(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      OutlinedButton(
                        onPressed: () {
                          debugPrint(
                            "Repeat ${order["id"]}",
                          );
                        },
                        child: const Text("Repeat"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}