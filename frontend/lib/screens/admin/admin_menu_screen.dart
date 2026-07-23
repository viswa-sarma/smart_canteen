import 'package:flutter/material.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key});

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  String selectedCategory = "All";
  String searchQuery = "";

  final List<String> categories = [
    "All",
    "Breakfast",
    "Lunch",
    "Snacks",
    "Drinks",
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      "id": 1,
      "name": "Masala Dosa",
      "category": "Breakfast",
      "price": 50,
      "prepTime": 10,
      "isVeg": true,
      "available": true,
      "image":
          "https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=500",
    },
    {
      "id": 2,
      "name": "Veg Biryani",
      "category": "Lunch",
      "price": 120,
      "prepTime": 20,
      "isVeg": true,
      "available": true,
      "image":
          "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500",
    },
    {
      "id": 3,
      "name": "Chicken Biryani",
      "category": "Lunch",
      "price": 160,
      "prepTime": 25,
      "isVeg": false,
      "available": true,
      "image":
          "https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=500",
    },
    {
      "id": 4,
      "name": "Samosa",
      "category": "Snacks",
      "price": 20,
      "prepTime": 5,
      "isVeg": true,
      "available": false,
      "image":
          "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=500",
    },
    {
      "id": 5,
      "name": "Tea",
      "category": "Drinks",
      "price": 15,
      "prepTime": 5,
      "isVeg": true,
      "available": true,
      "image":
          "https://images.unsplash.com/photo-1594631252845-29fc4cc8cde9?w=500",
    },
    {
      "id": 6,
      "name": "Coffee",
      "category": "Drinks",
      "price": 25,
      "prepTime": 5,
      "isVeg": true,
      "available": true,
      "image":
          "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500",
    },
  ];

  // ---------------------------------------------------------------------------
  // FILTERED ITEMS
  // ---------------------------------------------------------------------------

  List<Map<String, dynamic>> get filteredItems {
    return menuItems.where((item) {
      final matchesCategory =
          selectedCategory == "All" ||
          item["category"] == selectedCategory;

      final query = searchQuery.trim().toLowerCase();

      final matchesSearch =
          item["name"].toString().toLowerCase().contains(query) ||
          item["category"].toString().toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

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
                      "Menu Management",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Manage food items, prices and availability",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              FilledButton.icon(
                onPressed: () {
                  _showItemDialog();
                },
                icon: const Icon(
                  Icons.add_rounded,
                ),
                label: const Text(
                  "Add Item",
                ),
              ),
            ],
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
              hintText: "Search food items...",
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
          // CATEGORY FILTERS
          // -----------------------------------------------------------------

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final isSelected =
                    selectedCategory == category;

                return Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor:
                        Colors.green.shade100,
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
          // MENU
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
                    "ITEM",
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
                  child: Text(
                    "TYPE",
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    "PRICE",
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "PREP TIME",
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "AVAILABILITY",
                    style: _headerStyle,
                  ),
                ),
                SizedBox(
                  width: 110,
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
          // EMPTY STATE
          // -----------------------------------------------------------------

          if (filteredItems.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 60,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.restaurant_menu_rounded,
                    size: 45,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "No menu items found",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )

          // -----------------------------------------------------------------
          // ITEMS
          // -----------------------------------------------------------------

          else
            ListView.separated(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount: filteredItems.length,
              separatorBuilder: (_, _) {
                return const Divider(height: 1);
              },
              itemBuilder: (context, index) {
                final item = filteredItems[index];

                return _desktopTableRow(item);
              },
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DESKTOP TABLE ROW
  // ===========================================================================

  Widget _desktopTableRow(
    Map<String, dynamic> item,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      child: Row(
        children: [
          // -----------------------------------------------------------------
          // IMAGE + NAME
          // -----------------------------------------------------------------

          Expanded(
            flex: 3,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),
                  child: Image.network(
                    item["image"],
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                          context,
                          error,
                          stackTrace,
                        ) {
                      return Container(
                        width: 52,
                        height: 52,
                        color: Colors.grey.shade100,
                        child: const Icon(
                          Icons.fastfood_rounded,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    item["name"],
                    maxLines: 2,
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
          // VEG / NON VEG
          // -----------------------------------------------------------------

          Expanded(
            child: _foodTypeIndicator(
              item["isVeg"],
            ),
          ),

          // -----------------------------------------------------------------
          // PRICE
          // -----------------------------------------------------------------

          Expanded(
            child: Text(
              "₹${item["price"]}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // PREPARATION TIME
          // -----------------------------------------------------------------

          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 17,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 5),
                Text(
                  "${item["prepTime"]} min",
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // AVAILABILITY
          // -----------------------------------------------------------------

          Expanded(
            flex: 2,
            child: Row(
              children: [
                Switch(
                  value: item["available"],
                  onChanged: (value) {
                    setState(() {
                      item["available"] = value;
                    });
                  },
                ),

                Flexible(
                  child: Text(
                    item["available"]
                        ? "Available"
                        : "Out of Stock",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: item["available"]
                          ? Colors.green.shade700
                          : Colors.red.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -----------------------------------------------------------------
          // ACTIONS
          // -----------------------------------------------------------------

          SizedBox(
            width: 110,
            child: Row(
              children: [
                IconButton(
                  tooltip: "Edit",
                  onPressed: () {
                    _showItemDialog(
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
  // MOBILE / TABLET LIST
  // ===========================================================================

  Widget _buildMobileList() {
    if (filteredItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 60,
        ),
        child: Column(
          children: [
            Icon(
              Icons.restaurant_menu_rounded,
              size: 45,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              "No menu items found",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      separatorBuilder: (_, _) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final item = filteredItems[index];

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // -------------------------------------------------------------
              // IMAGE + INFO
              // -------------------------------------------------------------

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12),
                    child: Image.network(
                      item["image"],
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            context,
                            error,
                            stackTrace,
                          ) {
                        return Container(
                          width: 75,
                          height: 75,
                          color:
                              Colors.grey.shade100,
                          child: const Icon(
                            Icons.fastfood_rounded,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["name"],
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          item["category"],
                          style: TextStyle(
                            color:
                                Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            _foodTypeIndicator(
                              item["isVeg"],
                            ),

                            const SizedBox(width: 12),

                            Text(
                              "₹${item["price"]}",
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Divider(),

              const SizedBox(height: 8),

              // -------------------------------------------------------------
              // PREP TIME
              // -------------------------------------------------------------

              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    "${item["prepTime"]} min",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    item["available"]
                        ? "Available"
                        : "Out of Stock",
                    style: TextStyle(
                      color: item["available"]
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 5),

                  Switch(
                    value: item["available"],
                    onChanged: (value) {
                      setState(() {
                        item["available"] = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // -------------------------------------------------------------
              // ACTIONS
              // -------------------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showItemDialog(
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

                  const SizedBox(width: 10),

                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showDeleteDialog(item);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      label: const Text(
                        "Delete",
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
  // VEG / NON VEG INDICATOR
  // ===========================================================================

  Widget _foodTypeIndicator(bool isVeg) {
    final color =
        isVeg ? Colors.green : Colors.red;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),

        const SizedBox(width: 6),

        Flexible(
          child: Text(
            isVeg ? "Veg" : "Non-Veg",
            maxLines: 1,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // ADD / EDIT ITEM DIALOG
  // ===========================================================================

  void _showItemDialog({
    Map<String, dynamic>? item,
  }) {
    final isEditing = item != null;

    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController(
      text: item?["name"] ?? "",
    );

    final priceController = TextEditingController(
      text: item?["price"]?.toString() ?? "",
    );

    final prepController = TextEditingController(
      text: item?["prepTime"]?.toString() ?? "",
    );

    final imageController = TextEditingController(
      text: item?["image"] ?? "",
    );

    String category =
        item?["category"] ?? "Breakfast";

    bool isVeg = item?["isVeg"] ?? true;

    bool available =
        item?["available"] ?? true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              title: Text(
                isEditing
                    ? "Edit Menu Item"
                    : "Add Menu Item",
              ),

              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        // ---------------------------------------------------
                        // NAME
                        // ---------------------------------------------------

                        TextFormField(
                          controller:
                              nameController,
                          decoration:
                              const InputDecoration(
                            labelText:
                                "Item Name",
                            hintText:
                                "Example: Masala Dosa",
                            prefixIcon: Icon(
                              Icons.fastfood_outlined,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Enter item name";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // ---------------------------------------------------
                        // CATEGORY
                        // ---------------------------------------------------

                        DropdownButtonFormField<
                            String>(
                          initialValue: category,
                          decoration:
                              const InputDecoration(
                            labelText: "Category",
                            prefixIcon: Icon(
                              Icons
                                  .category_outlined,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                          items: categories
                              .where(
                                (element) =>
                                    element != "All",
                              )
                              .map(
                                (categoryName) =>
                                    DropdownMenuItem(
                                  value:
                                      categoryName,
                                  child: Text(
                                    categoryName,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            dialogSetState(() {
                              category = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // ---------------------------------------------------
                        // PRICE + PREP TIME
                        // ---------------------------------------------------

                        Row(
                          children: [
                            Expanded(
                              child:
                                  TextFormField(
                                controller:
                                    priceController,
                                keyboardType:
                                    TextInputType
                                        .number,
                                decoration:
                                    const InputDecoration(
                                  labelText:
                                      "Price",
                                  prefixText: "₹ ",
                                  border:
                                      OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value ==
                                          null ||
                                      value
                                          .trim()
                                          .isEmpty) {
                                    return "Enter price";
                                  }

                                  if (int.tryParse(
                                        value,
                                      ) ==
                                      null) {
                                    return "Invalid price";
                                  }

                                  return null;
                                },
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child:
                                  TextFormField(
                                controller:
                                    prepController,
                                keyboardType:
                                    TextInputType
                                        .number,
                                decoration:
                                    const InputDecoration(
                                  labelText:
                                      "Prep Time",
                                  suffixText:
                                      "min",
                                  border:
                                      OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value ==
                                          null ||
                                      value
                                          .trim()
                                          .isEmpty) {
                                    return "Enter time";
                                  }

                                  if (int.tryParse(
                                        value,
                                      ) ==
                                      null) {
                                    return "Invalid time";
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // ---------------------------------------------------
                        // IMAGE URL
                        // ---------------------------------------------------

                        TextFormField(
                          controller:
                              imageController,
                          decoration:
                              const InputDecoration(
                            labelText:
                                "Image URL",
                            hintText:
                                "https://...",
                            prefixIcon: Icon(
                              Icons.image_outlined,
                            ),
                            border:
                                OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ---------------------------------------------------
                        // VEG / NON VEG
                        // ---------------------------------------------------

                        Container(
                          padding:
                              const EdgeInsets.all(
                            14,
                          ),
                          decoration:
                              BoxDecoration(
                            border: Border.all(
                              color: Colors
                                  .grey.shade300,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Food Type",
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              ),

                              ChoiceChip(
                                label: const Text(
                                  "Veg",
                                ),
                                selected: isVeg,
                                onSelected: (_) {
                                  dialogSetState(
                                    () {
                                      isVeg = true;
                                    },
                                  );
                                },
                              ),

                              const SizedBox(
                                width: 8,
                              ),

                              ChoiceChip(
                                label: const Text(
                                  "Non-Veg",
                                ),
                                selected: !isVeg,
                                onSelected: (_) {
                                  dialogSetState(
                                    () {
                                      isVeg = false;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ---------------------------------------------------
                        // AVAILABILITY
                        // ---------------------------------------------------

                        SwitchListTile(
                          contentPadding:
                              EdgeInsets.zero,
                          title: const Text(
                            "Available",
                          ),
                          subtitle: Text(
                            available
                                ? "Customers can order this item"
                                : "Item will appear out of stock",
                          ),
                          value: available,
                          onChanged: (value) {
                            dialogSetState(() {
                              available = value;
                            });
                          },
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
                    if (!formKey.currentState!
                        .validate()) {
                      return;
                    }

                    final newItem = {
                      "id": isEditing
                          ? item["id"]
                          : DateTime.now()
                              .millisecondsSinceEpoch,
                      "name":
                          nameController.text.trim(),
                      "category": category,
                      "price": int.parse(
                        priceController.text,
                      ),
                      "prepTime": int.parse(
                        prepController.text,
                      ),
                      "isVeg": isVeg,
                      "available": available,
                      "image": imageController
                              .text
                              .trim()
                              .isEmpty
                          ? "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500"
                          : imageController.text
                              .trim(),
                    };

                    setState(() {
                      if (isEditing) {
                        final index =
                            menuItems.indexOf(item);

                        if (index != -1) {
                          menuItems[index] =
                              newItem;
                        }
                      } else {
                        menuItems.add(
                          newItem,
                        );
                      }
                    });

                    Navigator.pop(
                      dialogContext,
                    );

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? "Menu item updated successfully"
                              : "Menu item added successfully",
                        ),
                      ),
                    );
                  },
                  child: Text(
                    isEditing
                        ? "Save Changes"
                        : "Add Item",
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
  // DELETE DIALOG
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
            "Delete Menu Item?",
          ),
          content: Text(
            'Are you sure you want to delete "${item["name"]}"? This action cannot be undone.',
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
                  menuItems.remove(item);
                });

                Navigator.pop(
                  dialogContext,
                );

                ScaffoldMessenger.of(context)
                    .showSnackBar(
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
}

// =============================================================================
// TABLE HEADER STYLE
// =============================================================================

const TextStyle _headerStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);