import 'package:flutter/material.dart';
import 'package:smart_canteen/screens/student/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Masala Dosa",
      "price": 80,
      "qty": 2,
      "image":
          "https://images.unsplash.com/photo-1630383249896-424e482df921?w=500",
    },
    {
      "name": "Veg Biryani",
      "price": 120,
      "qty": 1,
      "image":
          "https://images.unsplash.com/photo-1701579231305-d84d8af9a3fd?w=500",
    },
    {
      "name": "Samosa",
      "price": 20,
      "qty": 2,
      "image":
          "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=500",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;

    for (var item in cartItems) {
      subtotal += item["price"] * item["qty"];
    }

    const tax = 32.0;
    final total = subtotal + tax;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                ...cartItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item["image"],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "₹${item["price"]}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (item["qty"] > 1) {
                                    item["qty"]--;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),

                            Text(
                              item["qty"].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  item["qty"]++;
                                });
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),


                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [

                      billRow("Subtotal", "₹${subtotal.toInt()}"),

                      const SizedBox(height: 10),

                      billRow("Tax & Charges", "₹32"),

                      const Divider(height: 30),

                      billRow(
                        "Total",
                        "₹${total.toInt()}",
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Estimated Time",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "15-20 min",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_) => const PaymentScreen(),
                          ),
                        );
                      },
                      child: const Text("Checkout"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget billRow(String title, String value, {bool isBold = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}