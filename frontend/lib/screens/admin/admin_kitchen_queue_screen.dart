import 'package:flutter/material.dart';

class AdminKitchenQueueScreen extends StatefulWidget {
  const AdminKitchenQueueScreen({super.key});

  @override
  State<AdminKitchenQueueScreen> createState() =>
      _AdminKitchenQueueScreenState();
}

class _AdminKitchenQueueScreenState extends State<AdminKitchenQueueScreen> {
  String searchQuery = "";
  String selectedMobileStatus = "All";

  final List<String> mobileStatuses = [
    "All",
    "New",
    "Preparing",
    "Ready",
  ];

  final List<Map<String, dynamic>> orders = [
    {
      "id": "ORD2358",
      "customer": "Ajay",
      "time": "11:25 AM",
      "waitTime": 3,
      "status": "New",
      "priority": false,
      "total": 115,
      "items": [
        {
          "name": "Masala Dosa",
          "quantity": 2,
        },
        {
          "name": "Tea",
          "quantity": 1,
        },
      ],
    },
    {
      "id": "ORD2357",
      "customer": "Rahul",
      "time": "11:21 AM",
      "waitTime": 7,
      "status": "New",
      "priority": true,
      "total": 145,
      "items": [
        {
          "name": "Veg Biryani",
          "quantity": 1,
        },
        {
          "name": "Coffee",
          "quantity": 1,
        },
      ],
    },
    {
      "id": "ORD2356",
      "customer": "Priya",
      "time": "11:16 AM",
      "waitTime": 12,
      "status": "Preparing",
      "priority": false,
      "total": 180,
      "items": [
        {
          "name": "Chicken Biryani",
          "quantity": 1,
        },
        {
          "name": "Water Bottle",
          "quantity": 1,
        },
      ],
    },
    {
      "id": "ORD2355",
      "customer": "Kiran",
      "time": "11:10 AM",
      "waitTime": 18,
      "status": "Preparing",
      "priority": true,
      "total": 90,
      "items": [
        {
          "name": "Samosa",
          "quantity": 3,
        },
        {
          "name": "Tea",
          "quantity": 2,
        },
      ],
    },
    {
      "id": "ORD2354",
      "customer": "Sai",
      "time": "11:05 AM",
      "waitTime": 23,
      "status": "Ready",
      "priority": false,
      "total": 75,
      "items": [
        {
          "name": "Idly",
          "quantity": 2,
        },
        {
          "name": "Coffee",
          "quantity": 1,
        },
      ],
    },
    {
      "id": "ORD2353",
      "customer": "Arun",
      "time": "11:01 AM",
      "waitTime": 27,
      "status": "Ready",
      "priority": false,
      "total": 60,
      "items": [
        {
          "name": "Plain Dosa",
          "quantity": 1,
        },
        {
          "name": "Tea",
          "quantity": 1,
        },
      ],
    },
  ];

  // ===========================================================================
  // COUNTS
  // ===========================================================================

  int get newCount =>
      orders.where((order) => order["status"] == "New").length;

  int get preparingCount =>
      orders.where((order) => order["status"] == "Preparing").length;

  int get readyCount =>
      orders.where((order) => order["status"] == "Ready").length;

  int get totalActive => orders.length;

  // ===========================================================================
  // SEARCH
  // ===========================================================================

  bool _matchesSearch(Map<String, dynamic> order) {
    final query = searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return true;
    }

    final id = order["id"].toString().toLowerCase();
    final customer = order["customer"].toString().toLowerCase();

    final items = (order["items"] as List)
        .map((item) => item["name"].toString().toLowerCase())
        .join(" ");

    return id.contains(query) ||
        customer.contains(query) ||
        items.contains(query);
  }

  List<Map<String, dynamic>> _getOrdersByStatus(String status) {
    return orders.where((order) {
      return order["status"] == status && _matchesSearch(order);
    }).toList();
  }

  List<Map<String, dynamic>> get mobileOrders {
    return orders.where((order) {
      final matchesStatus =
          selectedMobileStatus == "All" ||
          order["status"] == selectedMobileStatus;

      return matchesStatus && _matchesSearch(order);
    }).toList();
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------------------------------------------
          // HEADER
          // -----------------------------------------------------------------

          _buildHeader(),

          const SizedBox(height: 22),

          // -----------------------------------------------------------------
          // TOOLBAR
          // -----------------------------------------------------------------

          _buildToolbar(),

          const SizedBox(height: 22),

          // -----------------------------------------------------------------
          // QUEUE
          // -----------------------------------------------------------------

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 950) {
                return _buildDesktopBoard();
              }

              return _buildMobileBoard();
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ===========================================================================
  // HEADER
  // ===========================================================================

  Widget _buildHeader() {
    return Row(
      children: [
        // -------------------------------------------------------------------
        // TITLE
        // -------------------------------------------------------------------

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kitchen Queue",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Track and process active kitchen orders",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // ACTIVE STATUS
        // -------------------------------------------------------------------

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.green.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 7),

              Text(
                "$totalActive active orders",
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // TOOLBAR
  // ===========================================================================

  Widget _buildToolbar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Column(
            children: [
              _buildSearch(),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _miniStat(
                      "New",
                      newCount,
                      Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _miniStat(
                      "Preparing",
                      preparingCount,
                      Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _miniStat(
                      "Ready",
                      readyCount,
                      Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _buildSearch(),
            ),

            const SizedBox(width: 16),

            _miniStat(
              "New",
              newCount,
              Colors.blue,
            ),

            const SizedBox(width: 8),

            _miniStat(
              "Preparing",
              preparingCount,
              Colors.orange,
            ),

            const SizedBox(width: 8),

            _miniStat(
              "Ready",
              readyCount,
              Colors.green,
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // SEARCH
  // ===========================================================================

  Widget _buildSearch() {
    return SizedBox(
      height: 44,
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        style: const TextStyle(
          fontSize: 13,
        ),
        decoration: InputDecoration(
          hintText: "Search order, customer or item...",
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: 20,
            color: Colors.grey.shade500,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.green.shade400,
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // MINI STAT
  // ===========================================================================

  Widget _miniStat(
    String title,
    int value,
    Color color,
  ) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 7),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),

          const SizedBox(width: 8),

          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DESKTOP BOARD
  // ===========================================================================

  Widget _buildDesktopBoard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildQueueColumn(
            title: "New Orders",
            subtitle: "Waiting for acceptance",
            status: "New",
            color: Colors.blue,
            icon: Icons.receipt_long_outlined,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _buildQueueColumn(
            title: "Preparing",
            subtitle: "Currently being prepared",
            status: "Preparing",
            color: Colors.orange,
            icon: Icons.restaurant_outlined,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _buildQueueColumn(
            title: "Ready",
            subtitle: "Waiting for pickup",
            status: "Ready",
            color: Colors.green,
            icon: Icons.task_alt_rounded,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // QUEUE COLUMN
  // ===========================================================================

  Widget _buildQueueColumn({
    required String title,
    required String subtitle,
    required String status,
    required Color color,
    required IconData icon,
  }) {
    final columnOrders = _getOrdersByStatus(status);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // -----------------------------------------------------------------
          // COLUMN HEADER
          // -----------------------------------------------------------------

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: color,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  constraints: const BoxConstraints(
                    minWidth: 26,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    columnOrders.length.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // ORDERS
          // -----------------------------------------------------------------

          Padding(
            padding: const EdgeInsets.all(10),
            child: columnOrders.isEmpty
                ? _buildEmptyState(status)
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: columnOrders.length,
                    separatorBuilder: (_, _) {
                      return const SizedBox(height: 9);
                    },
                    itemBuilder: (context, index) {
                      return _buildOrderCard(
                        columnOrders[index],
                        color,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ORDER CARD
  // ===========================================================================

  Widget _buildOrderCard(
    Map<String, dynamic> order,
    Color statusColor,
  ) {
    final List<dynamic> items = order["items"];

    final bool priority = order["priority"] == true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: priority
              ? Colors.red.withValues(alpha: 0.25)
              : Colors.grey.shade200,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------------------------------------------------------------
            // STATUS LINE
            // ---------------------------------------------------------------

            Container(
              width: 3,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(11),
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // CONTENT
            // ---------------------------------------------------------------

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  11,
                  10,
                  10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -------------------------------------------------------
                    // ORDER HEADER
                    // -------------------------------------------------------

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "#${order["id"]}",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        if (priority)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(
                                alpha: 0.07,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "PRIORITY",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        const SizedBox(width: 3),

                        SizedBox(
                          width: 28,
                          height: 28,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            tooltip: "View details",
                            onPressed: () {
                              _showOrderDetails(order);
                            },
                            icon: Icon(
                              Icons.more_horiz_rounded,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    // -------------------------------------------------------
                    // CUSTOMER + TIME
                    // -------------------------------------------------------

                    Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 13,
                          color: Colors.grey.shade500,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            order["customer"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                            ),
                          ),
                        ),

                        Text(
                          order["time"],
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),

                    const SizedBox(height: 9),

                    // -------------------------------------------------------
                    // ITEMS
                    // -------------------------------------------------------

                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 7,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                minWidth: 24,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${item["quantity"]}×",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            const SizedBox(width: 7),

                            Expanded(
                              child: Text(
                                item["name"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 3),

                    // -------------------------------------------------------
                    // FOOTER
                    // -------------------------------------------------------

                    Row(
                      children: [
                        _buildWaitTime(
                          order["waitTime"],
                        ),

                        const Spacer(),

                        _buildCompactActionButton(
                          order,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // WAIT TIME
  // ===========================================================================

  Widget _buildWaitTime(int minutes) {
    Color color;

    if (minutes >= 15) {
      color = Colors.red;
    } else if (minutes >= 8) {
      color = Colors.orange;
    } else {
      color = Colors.grey;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.schedule_rounded,
          size: 13,
          color: color,
        ),

        const SizedBox(width: 4),

        Text(
          "$minutes min",
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: minutes >= 8
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // SMALL ACTION BUTTON
  // ===========================================================================

  Widget _buildCompactActionButton(
    Map<String, dynamic> order,
  ) {
    String text;
    IconData icon;
    Color color;

    switch (order["status"]) {
      case "New":
        text = "Accept";
        icon = Icons.arrow_forward_rounded;
        color = Colors.blue;
        break;

      case "Preparing":
        text = "Ready";
        icon = Icons.check_rounded;
        color = Colors.orange;
        break;

      case "Ready":
        text = "Complete";
        icon = Icons.done_all_rounded;
        color = Colors.green;
        break;

      default:
        text = "View";
        icon = Icons.visibility_outlined;
        color = Colors.grey;
    }

    return SizedBox(
      height: 30,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          _moveOrder(order);
        },
        icon: Icon(
          icon,
          size: 13,
        ),
        label: Text(text),
      ),
    );
  }

  // ===========================================================================
  // MOBILE
  // ===========================================================================

  Widget _buildMobileBoard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -------------------------------------------------------------------
        // FILTER
        // -------------------------------------------------------------------

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: mobileStatuses.map((status) {
              final selected =
                  selectedMobileStatus == status;

              return Padding(
                padding: const EdgeInsets.only(
                  right: 7,
                ),
                child: ChoiceChip(
                  label: Text(status),
                  selected: selected,
                  showCheckmark: false,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  selectedColor: Colors.green.shade50,
                  side: BorderSide(
                    color: selected
                        ? Colors.green.shade300
                        : Colors.grey.shade300,
                  ),
                  labelStyle: TextStyle(
                    color: selected
                        ? Colors.green.shade700
                        : Colors.grey.shade700,
                    fontSize: 11,
                    fontWeight: selected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedMobileStatus = status;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 14),

        // -------------------------------------------------------------------
        // ORDERS
        // -------------------------------------------------------------------

        if (mobileOrders.isEmpty)
          _buildEmptyState(
            selectedMobileStatus,
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mobileOrders.length,
            separatorBuilder: (_, _) {
              return const SizedBox(height: 9);
            },
            itemBuilder: (context, index) {
              final order = mobileOrders[index];

              return _buildOrderCard(
                order,
                _statusColor(order["status"]),
              );
            },
          ),
      ],
    );
  }

  // ===========================================================================
  // STATUS COLOR
  // ===========================================================================

  Color _statusColor(String status) {
    switch (status) {
      case "New":
        return Colors.blue;

      case "Preparing":
        return Colors.orange;

      case "Ready":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  // ===========================================================================
  // EMPTY STATE
  // ===========================================================================

  Widget _buildEmptyState(String status) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 35,
      ),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 32,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 8),

          Text(
            status == "All"
                ? "No active orders"
                : "No $status orders",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // MOVE ORDER
  // ===========================================================================

  void _moveOrder(
    Map<String, dynamic> order,
  ) {
    switch (order["status"]) {
      case "New":
        setState(() {
          order["status"] = "Preparing";
        });

        _showMessage(
          "#${order["id"]} is now preparing",
        );

        break;

      case "Preparing":
        setState(() {
          order["status"] = "Ready";
        });

        _showMessage(
          "#${order["id"]} is ready for pickup",
        );

        break;

      case "Ready":
        _showCompleteDialog(order);
        break;
    }
  }

  // ===========================================================================
  // COMPLETE DIALOG
  // ===========================================================================

  void _showCompleteDialog(
    Map<String, dynamic> order,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Complete Order",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          content: Text(
            "Has #${order["id"]} been collected by ${order["customer"]}?",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                "Cancel",
              ),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                setState(() {
                  orders.remove(order);
                });

                Navigator.pop(dialogContext);

                _showMessage(
                  "#${order["id"]} completed",
                );
              },
              child: const Text(
                "Complete",
              ),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // ORDER DETAILS
  // ===========================================================================

  void _showOrderDetails(
    Map<String, dynamic> order,
  ) {
    final List<dynamic> items = order["items"];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(
            20,
            18,
            12,
            10,
          ),

          contentPadding: const EdgeInsets.fromLTRB(
            20,
            5,
            20,
            10,
          ),

          actionsPadding: const EdgeInsets.fromLTRB(
            12,
            5,
            12,
            12,
          ),

          title: Row(
            children: [
              Expanded(
                child: Text(
                  "#${order["id"]}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              _statusBadge(
                order["status"],
              ),

              const SizedBox(width: 5),

              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 19,
                ),
              ),
            ],
          ),

          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // -----------------------------------------------------------
                // CUSTOMER
                // -----------------------------------------------------------

                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(width: 7),

                    Text(
                      order["customer"],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    Icon(
                      Icons.schedule_outlined,
                      size: 15,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      order["time"],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Divider(
                  color: Colors.grey.shade200,
                ),

                const SizedBox(height: 8),

                const Text(
                  "Items",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 9,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius:
                                BorderRadius.circular(5),
                          ),
                          child: Text(
                            "${item["quantity"]}×",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 9),

                        Expanded(
                          child: Text(
                            item["name"],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Divider(
                  color: Colors.grey.shade200,
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    _buildWaitTime(
                      order["waitTime"],
                    ),

                    const Spacer(),

                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "₹${order["total"]}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                "Close",
              ),
            ),

            SizedBox(
              height: 34,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);

                  _moveOrder(order);
                },
                child: Text(
                  _actionText(
                    order["status"],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // STATUS BADGE
  // ===========================================================================

  Widget _statusBadge(
    String status,
  ) {
    final color = _statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ===========================================================================
  // ACTION TEXT
  // ===========================================================================

  String _actionText(String status) {
    switch (status) {
      case "New":
        return "Accept Order";

      case "Preparing":
        return "Mark Ready";

      case "Ready":
        return "Complete Order";

      default:
        return "Done";
    }
  }

  // ===========================================================================
  // MESSAGE
  // ===========================================================================

  void _showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }
}