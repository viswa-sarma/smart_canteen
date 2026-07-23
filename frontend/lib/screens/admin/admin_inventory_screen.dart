import 'package:flutter/material.dart';

class AdminInventoryScreen extends StatefulWidget {
  const AdminInventoryScreen({super.key});

  @override
  State<AdminInventoryScreen> createState() =>
      _AdminInventoryScreenState();
}

class _AdminInventoryScreenState extends State<AdminInventoryScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  final List<String> filters = [
    "All",
    "In Stock",
    "Low Stock",
    "Out of Stock",
  ];

  final List<String> categories = [
    "Grains",
    "Vegetables",
    "Dairy",
    "Meat",
    "Grocery",
    "Spices",
    "Beverages",
    "Other",
  ];

  final List<String> units = [
    "kg",
    "g",
    "L",
    "ml",
    "pcs",
    "packets",
  ];

  final List<Map<String, dynamic>> inventory = [
    {
      "id": 1,
      "name": "Rice",
      "category": "Grains",
      "stock": 32.0,
      "unit": "kg",
      "threshold": 5.0,
    },
    {
      "id": 2,
      "name": "Cooking Oil",
      "category": "Grocery",
      "stock": 8.0,
      "unit": "L",
      "threshold": 3.0,
    },
    {
      "id": 3,
      "name": "Milk",
      "category": "Dairy",
      "stock": 4.0,
      "unit": "L",
      "threshold": 5.0,
    },
    {
      "id": 4,
      "name": "Tomatoes",
      "category": "Vegetables",
      "stock": 2.0,
      "unit": "kg",
      "threshold": 5.0,
    },
    {
      "id": 5,
      "name": "Chicken",
      "category": "Meat",
      "stock": 0.0,
      "unit": "kg",
      "threshold": 4.0,
    },
    {
      "id": 6,
      "name": "Sugar",
      "category": "Grocery",
      "stock": 15.0,
      "unit": "kg",
      "threshold": 5.0,
    },
    {
      "id": 7,
      "name": "Tea Powder",
      "category": "Beverages",
      "stock": 1.5,
      "unit": "kg",
      "threshold": 2.0,
    },
    {
      "id": 8,
      "name": "Potatoes",
      "category": "Vegetables",
      "stock": 12.0,
      "unit": "kg",
      "threshold": 5.0,
    },
  ];

  // ===========================================================================
  // STATUS
  // ===========================================================================

  String _getStatus(Map<String, dynamic> item) {
    final double stock = (item["stock"] as num).toDouble();
    final double threshold = (item["threshold"] as num).toDouble();

    if (stock <= 0) {
      return "Out of Stock";
    }

    if (stock <= threshold) {
      return "Low Stock";
    }

    return "In Stock";
  }

  // ===========================================================================
  // FILTERED INVENTORY
  // ===========================================================================

  List<Map<String, dynamic>> get filteredInventory {
    return inventory.where((item) {
      final status = _getStatus(item);

      final matchesFilter =
          selectedFilter == "All" || status == selectedFilter;

      final query = searchQuery.trim().toLowerCase();

      final matchesSearch =
          item["name"].toString().toLowerCase().contains(query) ||
          item["category"].toString().toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  // ===========================================================================
  // SUMMARY COUNTS
  // ===========================================================================

  int get totalItems => inventory.length;

  int get inStockCount {
    return inventory.where((item) {
      return _getStatus(item) == "In Stock";
    }).length;
  }

  int get lowStockCount {
    return inventory.where((item) {
      return _getStatus(item) == "Low Stock";
    }).length;
  }

  int get outOfStockCount {
    return inventory.where((item) {
      return _getStatus(item) == "Out of Stock";
    }).length;
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

          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inventory Management",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Track ingredients, stock levels and low stock alerts",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              FilledButton.icon(
                onPressed: () {
                  _showIngredientDialog();
                },
                icon: const Icon(
                  Icons.add_rounded,
                ),
                label: const Text(
                  "Add Ingredient",
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // SUMMARY CARDS
          // -----------------------------------------------------------------

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 850) {
                return Row(
                  children: [
                    Expanded(
                      child: _summaryCard(
                        title: "Total Ingredients",
                        value: totalItems.toString(),
                        icon: Icons.inventory_2_outlined,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: _summaryCard(
                        title: "In Stock",
                        value: inStockCount.toString(),
                        icon: Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: _summaryCard(
                        title: "Low Stock",
                        value: lowStockCount.toString(),
                        icon: Icons.warning_amber_rounded,
                        color: Colors.orange,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: _summaryCard(
                        title: "Out of Stock",
                        value: outOfStockCount.toString(),
                        icon: Icons.error_outline_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              }

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: 220,
                    child: _summaryCard(
                      title: "Total Ingredients",
                      value: totalItems.toString(),
                      icon: Icons.inventory_2_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: _summaryCard(
                      title: "In Stock",
                      value: inStockCount.toString(),
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: _summaryCard(
                      title: "Low Stock",
                      value: lowStockCount.toString(),
                      icon: Icons.warning_amber_rounded,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: _summaryCard(
                      title: "Out of Stock",
                      value: outOfStockCount.toString(),
                      icon: Icons.error_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          // -----------------------------------------------------------------
          // SEARCH
          // -----------------------------------------------------------------

          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search ingredients or categories...",
              prefixIcon: const Icon(
                Icons.search_rounded,
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

          // -----------------------------------------------------------------
          // FILTERS
          // -----------------------------------------------------------------

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((filter) {
                final isSelected = selectedFilter == filter;

                return Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedFilter = filter;
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

          // -----------------------------------------------------------------
          // INVENTORY
          // -----------------------------------------------------------------

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 850) {
                return _buildDesktopTable();
              }

              return _buildMobileList();
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ===========================================================================
  // SUMMARY CARD
  // ===========================================================================

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DESKTOP TABLE
  // ===========================================================================

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
          // -----------------------------------------------------------------
          // TABLE HEADER
          // -----------------------------------------------------------------

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
                  flex: 3,
                  child: Text(
                    "INGREDIENT",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "CATEGORY",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "STOCK",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "THRESHOLD",
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
                  width: 150,
                  child: Text(
                    "ACTIONS",
                    style: _headerStyle,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // -----------------------------------------------------------------
          // EMPTY
          // -----------------------------------------------------------------

          if (filteredInventory.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 60,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 46,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 12),

                  Text(
                    "No ingredients found",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )

          // -----------------------------------------------------------------
          // ROWS
          // -----------------------------------------------------------------

          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredInventory.length,
              separatorBuilder: (_, _) {
                return const Divider(
                  height: 1,
                );
              },
              itemBuilder: (context, index) {
                final item = filteredInventory[index];

                return _desktopTableRow(item);
              },
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DESKTOP ROW
  // ===========================================================================

  Widget _desktopTableRow(
    Map<String, dynamic> item,
  ) {
    final status = _getStatus(item);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      child: Row(
        children: [
          // -----------------------------------------------------------------
          // INGREDIENT
          // -----------------------------------------------------------------

          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.green,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    item["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // CATEGORY
          // -----------------------------------------------------------------

          Expanded(
            flex: 2,
            child: Text(
              item["category"],
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // STOCK
          // -----------------------------------------------------------------

          Expanded(
            flex: 2,
            child: Text(
              "${_formatNumber(item["stock"])} ${item["unit"]}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // THRESHOLD
          // -----------------------------------------------------------------

          Expanded(
            flex: 2,
            child: Text(
              "${_formatNumber(item["threshold"])} ${item["unit"]}",
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // STATUS
          // -----------------------------------------------------------------

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _statusBadge(status),
            ),
          ),

          // -----------------------------------------------------------------
          // ACTIONS
          // -----------------------------------------------------------------

          SizedBox(
            width: 150,
            child: Row(
              children: [
                IconButton(
                  tooltip: "Update Stock",
                  onPressed: () {
                    _showUpdateStockDialog(item);
                  },
                  icon: const Icon(
                    Icons.add_box_outlined,
                  ),
                ),

                IconButton(
                  tooltip: "Edit",
                  onPressed: () {
                    _showIngredientDialog(
                      item: item,
                    );
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                  ),
                ),

                IconButton(
                  tooltip: "Delete",
                  onPressed: () {
                    _showDeleteDialog(item);
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // MOBILE LIST
  // ===========================================================================

  Widget _buildMobileList() {
    if (filteredInventory.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 60,
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 46,
                color: Colors.grey,
              ),

              SizedBox(height: 12),

              Text(
                "No ingredients found",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredInventory.length,
      separatorBuilder: (_, _) {
        return const SizedBox(
          height: 12,
        );
      },
      itemBuilder: (context, index) {
        final item = filteredInventory[index];

        final status = _getStatus(item);

        return Container(
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
              // -------------------------------------------------------------
              // NAME + STATUS
              // -------------------------------------------------------------

              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(
                        alpha: 0.08,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["name"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          item["category"],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _statusBadge(status),
                ],
              ),

              const SizedBox(height: 18),

              const Divider(),

              const SizedBox(height: 12),

              // -------------------------------------------------------------
              // STOCK
              // -------------------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _mobileInfo(
                      "Current Stock",
                      "${_formatNumber(item["stock"])} ${item["unit"]}",
                    ),
                  ),

                  Expanded(
                    child: _mobileInfo(
                      "Low Stock At",
                      "${_formatNumber(item["threshold"])} ${item["unit"]}",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // -------------------------------------------------------------
              // QUICK STOCK
              // -------------------------------------------------------------

              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _decreaseStock(item);
                    },
                    child: const Icon(
                      Icons.remove_rounded,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showUpdateStockDialog(item);
                      },
                      icon: const Icon(
                        Icons.inventory_outlined,
                      ),
                      label: const Text(
                        "Update Stock",
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  OutlinedButton(
                    onPressed: () {
                      _increaseStock(item);
                    },
                    child: const Icon(
                      Icons.add_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // -------------------------------------------------------------
              // EDIT / DELETE
              // -------------------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        _showIngredientDialog(
                          item: item,
                        );
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                      ),
                      label: const Text(
                        "Edit",
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        _showDeleteDialog(item);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red.shade400,
                      ),
                      label: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red.shade400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // MOBILE INFO
  // ===========================================================================

  Widget _mobileInfo(
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // STATUS BADGE
  // ===========================================================================

  Widget _statusBadge(String status) {
    Color color;

    IconData icon;

    switch (status) {
      case "In Stock":
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;

      case "Low Stock":
        color = Colors.orange;
        icon = Icons.warning_amber_rounded;
        break;

      case "Out of Stock":
        color = Colors.red;
        icon = Icons.error_outline_rounded;
        break;

      default:
        color = Colors.grey;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),

          const SizedBox(width: 5),

          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // QUICK INCREASE
  // ===========================================================================

  void _increaseStock(
    Map<String, dynamic> item,
  ) {
    setState(() {
      final double stock = (item["stock"] as num).toDouble();

      item["stock"] = stock + 1;
    });
  }

  // ===========================================================================
  // QUICK DECREASE
  // ===========================================================================

  void _decreaseStock(
    Map<String, dynamic> item,
  ) {
    final double stock = (item["stock"] as num).toDouble();

    if (stock <= 0) {
      return;
    }

    setState(() {
      item["stock"] = stock - 1;

      if ((item["stock"] as double) < 0) {
        item["stock"] = 0.0;
      }
    });
  }

  // ===========================================================================
  // UPDATE STOCK DIALOG
  // ===========================================================================

  void _showUpdateStockDialog(
    Map<String, dynamic> item,
  ) {
    double stock = (item["stock"] as num).toDouble();

    final stockController = TextEditingController(
      text: _formatNumber(stock),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              title: const Text(
                "Update Stock",
              ),

              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // -------------------------------------------------------
                    // INGREDIENT
                    // -------------------------------------------------------

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            item["name"],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "Current stock: ${_formatNumber(item["stock"])} ${item["unit"]}",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // -------------------------------------------------------
                    // QUICK CONTROLS
                    // -------------------------------------------------------

                    Row(
                      children: [
                        IconButton.filledTonal(
                          onPressed: () {
                            if (stock > 0) {
                              dialogSetState(() {
                                stock--;

                                if (stock < 0) {
                                  stock = 0;
                                }

                                stockController.text =
                                    _formatNumber(stock);
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.remove_rounded,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: TextField(
                            controller: stockController,
                            textAlign: TextAlign.center,
                            keyboardType:
                                const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              suffixText: item["unit"],
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              final parsed = double.tryParse(value);

                              if (parsed != null) {
                                stock = parsed;
                              }
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        IconButton.filledTonal(
                          onPressed: () {
                            dialogSetState(() {
                              stock++;

                              stockController.text =
                                  _formatNumber(stock);
                            });
                          },
                          icon: const Icon(
                            Icons.add_rounded,
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
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text(
                    "Cancel",
                  ),
                ),

                FilledButton(
                  onPressed: () {
                    final value = double.tryParse(
                      stockController.text,
                    );

                    if (value == null || value < 0) {
                      return;
                    }

                    setState(() {
                      item["stock"] = value;
                    });

                    Navigator.pop(
                      dialogContext,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${item["name"]} stock updated",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Update Stock",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ===========================================================================
  // ADD / EDIT INGREDIENT
  // ===========================================================================

  void _showIngredientDialog({
    Map<String, dynamic>? item,
  }) {
    final bool isEditing = item != null;

    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController(
      text: item?["name"] ?? "",
    );

    final stockController = TextEditingController(
      text: item == null
          ? ""
          : _formatNumber(
              item["stock"],
            ),
    );

    final thresholdController = TextEditingController(
      text: item == null
          ? ""
          : _formatNumber(
              item["threshold"],
            ),
    );

    String selectedCategory =
        item?["category"] ?? categories.first;

    String selectedUnit =
        item?["unit"] ?? units.first;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              title: Text(
                isEditing
                    ? "Edit Ingredient"
                    : "Add Ingredient",
              ),

              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ---------------------------------------------------
                        // NAME
                        // ---------------------------------------------------

                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Ingredient Name",
                            hintText: "Example: Rice",
                            prefixIcon: Icon(
                              Icons.inventory_2_outlined,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Enter ingredient name";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // ---------------------------------------------------
                        // CATEGORY
                        // ---------------------------------------------------

                        DropdownButtonFormField<String>(
                          initialValue: selectedCategory,
                          decoration: const InputDecoration(
                            labelText: "Category",
                            prefixIcon: Icon(
                              Icons.category_outlined,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          items: categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            dialogSetState(() {
                              selectedCategory = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // ---------------------------------------------------
                        // STOCK
                        // ---------------------------------------------------

                        TextFormField(
                          controller: stockController,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: "Current Stock",
                            prefixIcon: Icon(
                              Icons.scale_outlined,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Enter current stock";
                            }

                            final stock = double.tryParse(value);

                            if (stock == null || stock < 0) {
                              return "Enter valid stock";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // ---------------------------------------------------
                        // UNIT
                        // ---------------------------------------------------

                        DropdownButtonFormField<String>(
                          initialValue: selectedUnit,
                          decoration: const InputDecoration(
                            labelText: "Unit",
                            prefixIcon: Icon(
                              Icons.straighten_rounded,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          items: units.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            dialogSetState(() {
                              selectedUnit = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // ---------------------------------------------------
                        // THRESHOLD
                        // ---------------------------------------------------

                        TextFormField(
                          controller: thresholdController,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: "Low Stock Threshold",
                            hintText: "Example: 5",
                            prefixIcon: Icon(
                              Icons.warning_amber_rounded,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Enter low stock threshold";
                            }

                            final threshold =
                                double.tryParse(value);

                            if (threshold == null ||
                                threshold < 0) {
                              return "Enter valid threshold";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // ---------------------------------------------------
                        // INFO
                        // ---------------------------------------------------

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(
                              alpha: 0.07,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline_rounded,
                                size: 18,
                                color: Colors.orange,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  "You will receive a low stock warning when the stock reaches this threshold.",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text(
                    "Cancel",
                  ),
                ),

                FilledButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    final ingredient = {
                      "id": isEditing
                          ? item["id"]
                          : DateTime.now().millisecondsSinceEpoch,
                      "name": nameController.text.trim(),
                      "category": selectedCategory,
                      "stock": double.parse(
                        stockController.text,
                      ),
                      "unit": selectedUnit,
                      "threshold": double.parse(
                        thresholdController.text,
                      ),
                    };

                    setState(() {
                      if (isEditing) {
                        final index = inventory.indexOf(item);

                        if (index != -1) {
                          inventory[index] = ingredient;
                        }
                      } else {
                        inventory.add(ingredient);
                      }
                    });

                    Navigator.pop(
                      dialogContext,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? "Ingredient updated successfully"
                              : "Ingredient added successfully",
                        ),
                      ),
                    );
                  },
                  child: Text(
                    isEditing
                        ? "Save Changes"
                        : "Add Ingredient",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ===========================================================================
  // DELETE
  // ===========================================================================

  void _showDeleteDialog(
    Map<String, dynamic> item,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Colors.red.shade400,
            size: 36,
          ),

          title: const Text(
            "Delete Ingredient?",
          ),

          content: Text(
            'Are you sure you want to delete "${item["name"]}" from inventory?',
            textAlign: TextAlign.center,
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                "Cancel",
              ),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  inventory.remove(item);
                });

                Navigator.pop(
                  dialogContext,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${item["name"]} deleted",
                    ),
                  ),
                );
              },
              child: const Text(
                "Delete",
              ),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // NUMBER FORMAT
  // ===========================================================================

  String _formatNumber(dynamic value) {
    final double number = (value as num).toDouble();

    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    }

    return number.toStringAsFixed(1);
  }
}

// =============================================================================
// TABLE HEADER
// =============================================================================

const TextStyle _headerStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);