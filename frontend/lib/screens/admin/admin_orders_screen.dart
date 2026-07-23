import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  final List<Map<String, dynamic>> orders = [
    {
      "id": "ORD2348",
      "customer": "Ajay",
      "items": "Masala Dosa, Tea",
      "amount": 95,
      "time": "10:55 AM",
      "status": "New",
    },
    {
      "id": "ORD2347",
      "customer": "Rahul",
      "items": "Veg Biryani",
      "amount": 120,
      "time": "10:50 AM",
      "status": "Preparing",
    },
    {
      "id": "ORD2346",
      "customer": "Priya",
      "items": "Samosa, Tea",
      "amount": 35,
      "time": "10:45 AM",
      "status": "Ready",
    },
    {
      "id": "ORD2345",
      "customer": "Kiran",
      "items": "Chicken Roll",
      "amount": 90,
      "time": "10:35 AM",
      "status": "Completed",
    },
    {
      "id": "ORD2344",
      "customer": "Sai",
      "items": "Idly, Coffee",
      "amount": 70,
      "time": "10:25 AM",
      "status": "Preparing",
    },
  ];

  /// Filter Orders
  List<Map<String, dynamic>> get filteredOrders {
    return orders.where((order) {
      final matchesStatus =
          selectedFilter == "All" || order["status"] == selectedFilter;

      final query = searchQuery.toLowerCase();

      final matchesSearch =
          order["id"].toString().toLowerCase().contains(query) ||
          order["customer"].toString().toLowerCase().contains(query) ||
          order["items"].toString().toLowerCase().contains(query);

      return matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ------------------------------------------------------------
          /// Header
          /// ------------------------------------------------------------
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Orders",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Manage and track all canteen orders",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              FilledButton.icon(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
                label: const Text(
                  "Refresh",
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// ------------------------------------------------------------
          /// Search
          /// ------------------------------------------------------------
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search by order ID, customer or item...",
              prefixIcon: const Icon(
                Icons.search,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.green.shade400,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ------------------------------------------------------------
          /// Filters
          /// ------------------------------------------------------------
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                "All",
                "New",
                "Preparing",
                "Ready",
                "Completed",
              ].map((status) {
                final isSelected = selectedFilter == status;

                return Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: ChoiceChip(
                    label: Text(status),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedFilter = status;
                      });
                    },
                    selectedColor: Colors.green.shade100,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.green.shade800
                          : Colors.grey.shade700,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          /// ------------------------------------------------------------
          /// Orders
          /// ------------------------------------------------------------
          LayoutBuilder(
            builder: (context, constraints) {
              /// Desktop
              if (constraints.maxWidth >= 850) {
                return _buildDesktopTable();
              }

              /// Mobile / Tablet
              return _buildMobileList();
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// ===================================================================
  /// Desktop Web Table
  /// ===================================================================

  Widget _buildDesktopTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ------------------------------------------------------------
          /// Table Header
          /// ------------------------------------------------------------
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "ORDER ID",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "CUSTOMER",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Text(
                    "ITEMS",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  child: Text(
                    "AMOUNT",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  child: Text(
                    "TIME",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "STATUS",
                    style: _headerStyle,
                  ),
                ),

                SizedBox(
                  width: 110,
                  child: Text(
                    "ACTION",
                    style: _headerStyle,
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
          ),

          /// ------------------------------------------------------------
          /// Empty Orders
          /// ------------------------------------------------------------
          if (filteredOrders.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 60,
              ),
              child: Center(
                child: Text(
                  "No orders found",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            )

          /// ------------------------------------------------------------
          /// Table Rows
          /// ------------------------------------------------------------
          else
            ListView.separated(
              /// IMPORTANT
              /// Let ListView calculate its full height.
              shrinkWrap: true,

              /// IMPORTANT
              /// Disable table's own scrolling.
              physics: const NeverScrollableScrollPhysics(),

              itemCount: filteredOrders.length,

              separatorBuilder: (_, _) {
                return const Divider(
                  height: 1,
                );
              },

              itemBuilder: (context, index) {
                final order = filteredOrders[index];

                return InkWell(
                  onTap: () {
                    _openOrderDetails(order);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        /// Order ID
                        Expanded(
                          flex: 2,
                          child: Text(
                            "#${order["id"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        /// Customer
                        Expanded(
                          flex: 2,
                          child: Text(
                            order["customer"],
                          ),
                        ),

                        /// Items
                        Expanded(
                          flex: 3,
                          child: Text(
                            order["items"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        /// Amount
                        Expanded(
                          child: Text(
                            "₹${order["amount"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        /// Time
                        Expanded(
                          child: Text(
                            order["time"],
                          ),
                        ),

                        /// Status
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _statusBadge(
                              order["status"],
                            ),
                          ),
                        ),

                        /// Action
                        SizedBox(
                          width: 110,
                          child: _actionButton(
                            order,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  /// ===================================================================
  /// Mobile / Tablet Layout
  /// ===================================================================

  Widget _buildMobileList() {
    if (filteredOrders.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 60,
        ),
        child: Center(
          child: Text(
            "No orders found",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      /// Let ListView use required height.
      shrinkWrap: true,

      /// Disable independent ListView scrolling.
      physics: const NeverScrollableScrollPhysics(),

      itemCount: filteredOrders.length,

      separatorBuilder: (_, _) {
        return const SizedBox(
          height: 12,
        );
      },

      itemBuilder: (context, index) {
        final order = filteredOrders[index];

        return InkWell(
          onTap: () {
            _openOrderDetails(order);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ------------------------------------------------------
                /// Order ID + Status
                /// ------------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "#${order["id"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    _statusBadge(
                      order["status"],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 14,
                ),

                /// Customer
                Text(
                  order["customer"],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 6,
                ),

                /// Items
                Text(
                  order["items"],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                /// Amount + Time
                Row(
                  children: [
                    Text(
                      "₹${order["amount"]}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      order["time"],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                /// Action Button
                SizedBox(
                  width: double.infinity,
                  child: _actionButton(
                    order,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ===================================================================
  /// Order Status Badge
  /// ===================================================================

  Widget _statusBadge(String status) {
    Color color;

    switch (status) {
      case "New":
        color = Colors.blue;
        break;

      case "Preparing":
        color = Colors.orange;
        break;

      case "Ready":
        color = Colors.green;
        break;

      case "Completed":
        color = Colors.grey;
        break;

      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// ===================================================================
  /// Status Action Button
  /// ===================================================================

  Widget _actionButton(
    Map<String, dynamic> order,
  ) {
    String buttonText;

    switch (order["status"]) {
      case "New":
        buttonText = "Accept";
        break;

      case "Preparing":
        buttonText = "Mark Ready";
        break;

      case "Ready":
        buttonText = "Complete";
        break;

      default:
        buttonText = "View";
    }

    return OutlinedButton(
      onPressed: () {
        _updateOrderStatus(order);
      },
      child: Text(
        buttonText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// ===================================================================
  /// Update Order Status
  /// ===================================================================

  void _updateOrderStatus(
    Map<String, dynamic> order,
  ) {
    setState(() {
      switch (order["status"]) {
        case "New":
          order["status"] = "Preparing";
          break;

        case "Preparing":
          order["status"] = "Ready";
          break;

        case "Ready":
          order["status"] = "Completed";
          break;

        default:
          _openOrderDetails(order);
      }
    });
  }

  /// ===================================================================
  /// Open Particular Order
  /// ===================================================================

  void _openOrderDetails(
    Map<String, dynamic> order,
  ) {
    debugPrint(
      "Opening order: ${order["id"]}",
    );

    // Later you can navigate to the order detail screen:
    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => AdminOrderDetailScreen(
    //       order: order,
    //     ),
    //   ),
    // );
  }
}

/// =====================================================================
/// Table Header Style
/// =====================================================================

const TextStyle _headerStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);