import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "name": "Masala Dosa",
        "qty": 1,
        "price": 80,
      },
      {
        "name": "Tea",
        "qty": 1,
        "price": 15,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Order Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Order #$orderId",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Placed Today • 10:30 AM",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            /// STATUS CARD

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Current Status",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Preparing Food",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          children: [

                            Expanded(
                              child: infoCard(
                                "15-20 min",
                                "Estimated",
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: infoCard(
                                "23",
                                "Queue",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 18),

                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Colors.green,
                      size: 46,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Order Timeline",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20),

            timelineTile(
              "Order Placed",
              "10:30 AM",
              true,
              false,
            ),

            timelineTile(
              "Accepted",
              "10:31 AM",
              true,
              false,
            ),

            timelineTile(
              "Preparing",
              "10:35 AM",
              true,
              false,
            ),

            timelineTile(
              "Ready",
              "--",
              false,
              false,
            ),

            timelineTile(
              "Collected",
              "--",
              false,
              true,
            ),

            const SizedBox(height: 30),

            const Text(
              "Items Ordered",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      children: [

                        Expanded(
                          child: Text(
                            "${item["name"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Text("x${item["qty"]}"),

                        const SizedBox(width: 20),

                        Text(
                          "₹${item["price"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
                        const SizedBox(height: 30),

            const Text(
              "Payment Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  paymentRow(
                    "Payment Method",
                    "UPI",
                  ),

                  const Divider(height: 28),

                  paymentRow(
                    "Payment Status",
                    "Paid",
                    valueColor: Colors.green,
                  ),

                  const Divider(height: 28),

                  paymentRow(
                    "Transaction ID",
                    "TXN45893425",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Pickup Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  Row(
                    children: [

                      const Icon(
                        Icons.storefront,
                        color: Colors.green,
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Text(
                          "Pickup Counter",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius:
                              BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "Counter A",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  billRow(
                    "Subtotal",
                    "₹95",
                  ),

                  const SizedBox(height: 10),

                  billRow(
                    "Tax",
                    "₹5",
                  ),

                  const Divider(height: 30),

                  billRow(
                    "Total",
                    "₹100",
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {

                  /// TODO:
                  /// Repeat Order

                },
                icon: const Icon(Icons.refresh),
                label: const Text(
                  "Repeat Order",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
                      ],
        ),
      ),
    );
  }

  Widget infoCard(String value, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget timelineTile(
    String title,
    String time,
    bool completed,
    bool isLast,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                completed
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: completed ? Colors.green : Colors.grey,
                size: 24,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: completed
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: completed
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey.shade600,
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

  Widget paymentRow(
    String title,
    String value, {
    Color valueColor = Colors.black,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 15,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: valueColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget billRow(
    String title,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: isBold ? Colors.green : Colors.black,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}