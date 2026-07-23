import 'package:flutter/material.dart';

class AdminStudentsScreen extends StatefulWidget {
  const AdminStudentsScreen({super.key});

  @override
  State<AdminStudentsScreen> createState() =>
      _AdminStudentsScreenState();
}

class _AdminStudentsScreenState extends State<AdminStudentsScreen> {
  String searchQuery = "";
  String selectedFilter = "All";

  final List<String> filters = [
    "All",
    "Active",
    "Blocked",
  ];

  final List<Map<String, dynamic>> students = [
    {
      "id": 1,
      "name": "Ajay Kumar",
      "rollNo": "22CS101",
      "email": "ajay@university.edu",
      "phone": "9876543210",
      "department": "Computer Science",
      "year": "4th Year",
      "orders": 28,
      "totalSpent": 2450,
      "lastOrder": "Today, 11:25 AM",
      "status": "Active",
      "recentOrders": [
        {
          "id": "ORD2358",
          "date": "Today, 11:25 AM",
          "amount": 115,
          "status": "Completed",
        },
        {
          "id": "ORD2312",
          "date": "Yesterday, 1:15 PM",
          "amount": 90,
          "status": "Completed",
        },
        {
          "id": "ORD2298",
          "date": "18 Jul, 12:30 PM",
          "amount": 150,
          "status": "Completed",
        },
      ],
    },
    {
      "id": 2,
      "name": "Rahul Sharma",
      "rollNo": "22CS102",
      "email": "rahul@university.edu",
      "phone": "9876543211",
      "department": "Computer Science",
      "year": "4th Year",
      "orders": 17,
      "totalSpent": 1620,
      "lastOrder": "Today, 10:45 AM",
      "status": "Active",
      "recentOrders": [
        {
          "id": "ORD2357",
          "date": "Today, 10:45 AM",
          "amount": 145,
          "status": "Completed",
        },
        {
          "id": "ORD2301",
          "date": "19 Jul, 1:10 PM",
          "amount": 80,
          "status": "Completed",
        },
      ],
    },
    {
      "id": 3,
      "name": "Priya Reddy",
      "rollNo": "22EC103",
      "email": "priya@university.edu",
      "phone": "9876543212",
      "department": "Electronics",
      "year": "3rd Year",
      "orders": 34,
      "totalSpent": 3280,
      "lastOrder": "Today, 9:50 AM",
      "status": "Active",
      "recentOrders": [
        {
          "id": "ORD2356",
          "date": "Today, 9:50 AM",
          "amount": 180,
          "status": "Completed",
        },
        {
          "id": "ORD2280",
          "date": "17 Jul, 12:20 PM",
          "amount": 120,
          "status": "Completed",
        },
      ],
    },
    {
      "id": 4,
      "name": "Kiran Rao",
      "rollNo": "22ME104",
      "email": "kiran@university.edu",
      "phone": "9876543213",
      "department": "Mechanical",
      "year": "3rd Year",
      "orders": 5,
      "totalSpent": 420,
      "lastOrder": "15 Jul, 2:20 PM",
      "status": "Blocked",
      "recentOrders": [
        {
          "id": "ORD2201",
          "date": "15 Jul, 2:20 PM",
          "amount": 70,
          "status": "Completed",
        },
      ],
    },
    {
      "id": 5,
      "name": "Sai Krishna",
      "rollNo": "23CS105",
      "email": "sai@university.edu",
      "phone": "9876543214",
      "department": "Computer Science",
      "year": "3rd Year",
      "orders": 21,
      "totalSpent": 1890,
      "lastOrder": "Yesterday, 4:30 PM",
      "status": "Active",
      "recentOrders": [
        {
          "id": "ORD2340",
          "date": "Yesterday, 4:30 PM",
          "amount": 75,
          "status": "Completed",
        },
      ],
    },
    {
      "id": 6,
      "name": "Anjali Devi",
      "rollNo": "23EE106",
      "email": "anjali@university.edu",
      "phone": "9876543215",
      "department": "Electrical",
      "year": "3rd Year",
      "orders": 13,
      "totalSpent": 1120,
      "lastOrder": "19 Jul, 1:40 PM",
      "status": "Active",
      "recentOrders": [
        {
          "id": "ORD2305",
          "date": "19 Jul, 1:40 PM",
          "amount": 95,
          "status": "Completed",
        },
      ],
    },
    {
      "id": 7,
      "name": "Arun Kumar",
      "rollNo": "24CS107",
      "email": "arun@university.edu",
      "phone": "9876543216",
      "department": "Computer Science",
      "year": "2nd Year",
      "orders": 9,
      "totalSpent": 760,
      "lastOrder": "18 Jul, 10:30 AM",
      "status": "Blocked",
      "recentOrders": [
        {
          "id": "ORD2270",
          "date": "18 Jul, 10:30 AM",
          "amount": 60,
          "status": "Completed",
        },
      ],
    },
  ];

  // ===========================================================================
  // COUNTS
  // ===========================================================================

  int get totalStudents => students.length;

  int get activeStudents {
    return students
        .where(
          (student) => student["status"] == "Active",
        )
        .length;
  }

  int get blockedStudents {
    return students
        .where(
          (student) => student["status"] == "Blocked",
        )
        .length;
  }

  // ===========================================================================
  // FILTER
  // ===========================================================================

  List<Map<String, dynamic>> get filteredStudents {
    final query = searchQuery.trim().toLowerCase();

    return students.where((student) {
      final matchesFilter =
          selectedFilter == "All" ||
          student["status"] == selectedFilter;

      final matchesSearch =
          student["name"]
              .toString()
              .toLowerCase()
              .contains(query) ||
          student["rollNo"]
              .toString()
              .toLowerCase()
              .contains(query) ||
          student["email"]
              .toString()
              .toLowerCase()
              .contains(query) ||
          student["department"]
              .toString()
              .toLowerCase()
              .contains(query);

      return matchesFilter && matchesSearch;
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

          const SizedBox(height: 16),

          // -----------------------------------------------------------------
          // FILTERS
          // -----------------------------------------------------------------

          _buildFilters(),

          const SizedBox(height: 16),

          // -----------------------------------------------------------------
          // STUDENTS
          // -----------------------------------------------------------------

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 850) {
                return _buildDesktopTable();
              }

              return _buildMobileList();
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Students",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Manage registered students and their canteen activity",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
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

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _miniStat(
                      "Total",
                      totalStudents,
                      Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _miniStat(
                      "Active",
                      activeStudents,
                      Colors.green,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: _miniStat(
                      "Blocked",
                      blockedStudents,
                      Colors.red,
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
              "Total",
              totalStudents,
              Colors.blue,
            ),

            const SizedBox(width: 8),

            _miniStat(
              "Active",
              activeStudents,
              Colors.green,
            ),

            const SizedBox(width: 8),

            _miniStat(
              "Blocked",
              blockedStudents,
              Colors.red,
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
          hintText: "Search name, roll number, email...",
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
          contentPadding: EdgeInsets.zero,
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
  // FILTERS
  // ===========================================================================

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final selected =
              selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(
              right: 7,
            ),
            child: ChoiceChip(
              label: Text(filter),
              selected: selected,
              showCheckmark: false,
              visualDensity:
                  VisualDensity.compact,
              selectedColor:
                  Colors.green.shade50,
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
                  selectedFilter = filter;
                });
              },
            ),
          );
        }).toList(),
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
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // -----------------------------------------------------------------
          // HEADER
          // -----------------------------------------------------------------

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "STUDENT",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "ROLL NO",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "DEPARTMENT",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  child: Text(
                    "ORDERS",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "TOTAL SPENT",
                    style: _headerStyle,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    "LAST ORDER",
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
                  width: 50,
                  child: Text(
                    "",
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

          if (filteredStudents.isEmpty)
            _emptyState()

          // -----------------------------------------------------------------
          // ROWS
          // -----------------------------------------------------------------

          else
            ListView.separated(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount:
                  filteredStudents.length,
              separatorBuilder: (_, _) {
                return const Divider(
                  height: 1,
                );
              },
              itemBuilder:
                  (context, index) {
                return _studentRow(
                  filteredStudents[index],
                );
              },
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // STUDENT TABLE ROW
  // ===========================================================================

  Widget _studentRow(
    Map<String, dynamic> student,
  ) {
    return InkWell(
      onTap: () {
        _showStudentDetails(student);
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        child: Row(
          children: [
            // ---------------------------------------------------------------
            // STUDENT
            // ---------------------------------------------------------------

            Expanded(
              flex: 3,
              child: Row(
                children: [
                  _avatar(student["name"]),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          student["name"],
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style:
                              const TextStyle(
                            fontSize: 13,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        const SizedBox(
                          height: 2,
                        ),

                        Text(
                          student["email"],
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                                Colors.grey.shade500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ---------------------------------------------------------------
            // ROLL NO
            // ---------------------------------------------------------------

            Expanded(
              flex: 2,
              child: Text(
                student["rollNo"],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // DEPARTMENT
            // ---------------------------------------------------------------

            Expanded(
              flex: 2,
              child: Text(
                student["department"],
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      Colors.grey.shade700,
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // ORDERS
            // ---------------------------------------------------------------

            Expanded(
              child: Text(
                student["orders"].toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // TOTAL
            // ---------------------------------------------------------------

            Expanded(
              flex: 2,
              child: Text(
                "₹${student["totalSpent"]}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // LAST ORDER
            // ---------------------------------------------------------------

            Expanded(
              flex: 2,
              child: Text(
                student["lastOrder"],
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color:
                      Colors.grey.shade600,
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // STATUS
            // ---------------------------------------------------------------

            Expanded(
              flex: 2,
              child: Align(
                alignment:
                    Alignment.centerLeft,
                child: _statusBadge(
                  student["status"],
                ),
              ),
            ),

            // ---------------------------------------------------------------
            // MENU
            // ---------------------------------------------------------------

            SizedBox(
              width: 50,
              child:
                  _studentMenu(student),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // AVATAR
  // ===========================================================================

  Widget _avatar(String name) {
    final parts = name
        .trim()
        .split(" ")
        .where((element) =>
            element.isNotEmpty)
        .toList();

    String initials = "";

    if (parts.isNotEmpty) {
      initials += parts.first[0];
    }

    if (parts.length > 1) {
      initials += parts.last[0];
    }

    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green.withValues(
          alpha: 0.08,
        ),
        borderRadius:
            BorderRadius.circular(9),
      ),
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          color: Colors.green.shade700,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ===========================================================================
  // STATUS BADGE
  // ===========================================================================

  Widget _statusBadge(String status) {
    final bool active =
        status == "Active";

    final color =
        active ? Colors.green : Colors.red;

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.08,
        ),
        borderRadius:
            BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 5),

          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ACTION MENU
  // ===========================================================================

  Widget _studentMenu(
    Map<String, dynamic> student,
  ) {
    return PopupMenuButton<String>(
      tooltip: "Actions",
      icon: Icon(
        Icons.more_horiz_rounded,
        size: 19,
        color: Colors.grey.shade600,
      ),
      onSelected: (value) {
        switch (value) {
          case "view":
            _showStudentDetails(student);
            break;

          case "status":
            _toggleStudentStatus(student);
            break;

          case "delete":
            _showDeleteDialog(student);
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: "view",
            child: Row(
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 18,
                ),
                SizedBox(width: 10),
                Text(
                  "View Details",
                ),
              ],
            ),
          ),

          PopupMenuItem(
            value: "status",
            child: Row(
              children: [
                Icon(
                  student["status"] ==
                          "Active"
                      ? Icons.block_rounded
                      : Icons
                          .check_circle_outline,
                  size: 18,
                ),

                const SizedBox(width: 10),

                Text(
                  student["status"] ==
                          "Active"
                      ? "Block Student"
                      : "Unblock Student",
                ),
              ],
            ),
          ),

          const PopupMenuDivider(),

          PopupMenuItem(
            value: "delete",
            child: Row(
              children: [
                Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.red.shade400,
                ),
                const SizedBox(width: 10),
                Text(
                  "Delete",
                  style: TextStyle(
                    color:
                        Colors.red.shade500,
                  ),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }

  // ===========================================================================
  // MOBILE LIST
  // ===========================================================================

  Widget _buildMobileList() {
    if (filteredStudents.isEmpty) {
      return _emptyState();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount: filteredStudents.length,
      separatorBuilder: (_, _) {
        return const SizedBox(
          height: 9,
        );
      },
      itemBuilder: (context, index) {
        final student =
            filteredStudents[index];

        return InkWell(
          borderRadius:
              BorderRadius.circular(12),
          onTap: () {
            _showStudentDetails(student);
          },
          child: Container(
            padding:
                const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(12),
              border: Border.all(
                color:
                    Colors.grey.shade200,
              ),
            ),
            child: Column(
              children: [
                // -----------------------------------------------------------
                // TOP
                // -----------------------------------------------------------

                Row(
                  children: [
                    _avatar(
                      student["name"],
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            student["name"],
                            style:
                                const TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),

                          const SizedBox(
                            height: 2,
                          ),

                          Text(
                            "${student["rollNo"]} • ${student["department"]}",
                            style: TextStyle(
                              color: Colors
                                  .grey
                                  .shade500,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _statusBadge(
                      student["status"],
                    ),

                    _studentMenu(
                      student,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 13,
                ),

                Divider(
                  height: 1,
                  color:
                      Colors.grey.shade200,
                ),

                const SizedBox(
                  height: 13,
                ),

                // -----------------------------------------------------------
                // STATS
                // -----------------------------------------------------------

                Row(
                  children: [
                    Expanded(
                      child: _mobileInfo(
                        "Orders",
                        student["orders"]
                            .toString(),
                      ),
                    ),

                    Expanded(
                      child: _mobileInfo(
                        "Total Spent",
                        "₹${student["totalSpent"]}",
                      ),
                    ),

                    Expanded(
                      child: _mobileInfo(
                        "Year",
                        student["year"],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                Row(
                  children: [
                    Icon(
                      Icons
                          .schedule_outlined,
                      size: 14,
                      color: Colors
                          .grey.shade500,
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    Text(
                      "Last order: ${student["lastOrder"]}",
                      style: TextStyle(
                        color: Colors
                            .grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 9,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          value,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // EMPTY STATE
  // ===========================================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        vertical: 45,
      ),
      child: Column(
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 38,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 9),

          Text(
            "No students found",
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
  // STUDENT DETAILS
  // ===========================================================================

  void _showStudentDetails(
    Map<String, dynamic> student,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder:
              (context, dialogSetState) {
            final List<dynamic>
                recentOrders =
                student["recentOrders"];

            return AlertDialog(
              titlePadding:
                  const EdgeInsets.fromLTRB(
                20,
                18,
                12,
                10,
              ),

              contentPadding:
                  const EdgeInsets.fromLTRB(
                20,
                5,
                20,
                10,
              ),

              actionsPadding:
                  const EdgeInsets.fromLTRB(
                12,
                5,
                12,
                12,
              ),

              // -------------------------------------------------------------
              // TITLE
              // -------------------------------------------------------------

              title: Row(
                children: [
                  _avatar(
                    student["name"],
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          student["name"],
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),

                        const SizedBox(
                          height: 2,
                        ),

                        Text(
                          student["rollNo"],
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                            fontSize: 10,
                            fontWeight:
                                FontWeight
                                    .normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _statusBadge(
                    student["status"],
                  ),

                  const SizedBox(width: 4),

                  IconButton(
                    visualDensity:
                        VisualDensity.compact,
                    onPressed: () {
                      Navigator.pop(
                        dialogContext,
                      );
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 19,
                    ),
                  ),
                ],
              ),

              // -------------------------------------------------------------
              // CONTENT
              // -------------------------------------------------------------

              content: SizedBox(
                width: 500,
                child:
                    SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      // -----------------------------------------------------
                      // PERSONAL INFORMATION
                      // -----------------------------------------------------

                      Container(
                        padding:
                            const EdgeInsets
                                .all(14),
                        decoration:
                            BoxDecoration(
                          color: Colors
                              .grey.shade50,
                          borderRadius:
                              BorderRadius
                                  .circular(10),
                        ),
                        child: Column(
                          children: [
                            _detailRow(
                              icon: Icons
                                  .email_outlined,
                              title: "Email",
                              value:
                                  student["email"],
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            _detailRow(
                              icon: Icons
                                  .phone_outlined,
                              title: "Phone",
                              value:
                                  student["phone"],
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            _detailRow(
                              icon: Icons
                                  .school_outlined,
                              title:
                                  "Department",
                              value: student[
                                  "department"],
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            _detailRow(
                              icon: Icons
                                  .calendar_today_outlined,
                              title: "Year",
                              value:
                                  student["year"],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // -----------------------------------------------------
                      // STATS
                      // -----------------------------------------------------

                      Row(
                        children: [
                          Expanded(
                            child:
                                _detailStat(
                              title:
                                  "Total Orders",
                              value: student[
                                      "orders"]
                                  .toString(),
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child:
                                _detailStat(
                              title:
                                  "Total Spent",
                              value:
                                  "₹${student["totalSpent"]}",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // -----------------------------------------------------
                      // RECENT ORDERS
                      // -----------------------------------------------------

                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Recent Orders",
                              style:
                                  TextStyle(
                                fontSize: 13,
                                fontWeight:
                                    FontWeight
                                        .w700,
                              ),
                            ),
                          ),

                          Text(
                            "${recentOrders.length} orders",
                            style:
                                TextStyle(
                              color: Colors
                                  .grey
                                  .shade500,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        decoration:
                            BoxDecoration(
                          border:
                              Border.all(
                            color: Colors
                                .grey
                                .shade200,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(9),
                        ),
                        child: Column(
                          children:
                              List.generate(
                            recentOrders
                                .length,
                            (index) {
                              final order =
                                  recentOrders[
                                      index];

                              return Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal:
                                          12,
                                      vertical:
                                          10,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex:
                                              2,
                                          child:
                                              Text(
                                            "#${order["id"]}",
                                            style:
                                                const TextStyle(
                                              fontSize:
                                                  11,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          flex:
                                              3,
                                          child:
                                              Text(
                                            order[
                                                "date"],
                                            style:
                                                TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize:
                                                  9,
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child:
                                              Text(
                                            "₹${order["amount"]}",
                                            style:
                                                const TextStyle(
                                              fontSize:
                                                  11,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        _orderStatusBadge(
                                          order[
                                              "status"],
                                        ),
                                      ],
                                    ),
                                  ),

                                  if (index !=
                                      recentOrders
                                              .length -
                                          1)
                                    Divider(
                                      height:
                                          1,
                                      color: Colors
                                          .grey
                                          .shade200,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // ACTIONS
              // -------------------------------------------------------------

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text(
                    "Close",
                  ),
                ),

                SizedBox(
                  height: 34,
                  child:
                      OutlinedButton.icon(
                    style:
                        OutlinedButton
                            .styleFrom(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                      ),
                      foregroundColor:
                          student["status"] ==
                                  "Active"
                              ? Colors.red
                              : Colors.green,
                      textStyle:
                          const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        student["status"] =
                            student["status"] ==
                                    "Active"
                                ? "Blocked"
                                : "Active";
                      });

                      dialogSetState(
                        () {},
                      );
                    },
                    icon: Icon(
                      student["status"] ==
                              "Active"
                          ? Icons
                              .block_rounded
                          : Icons
                              .check_circle_outline,
                      size: 15,
                    ),
                    label: Text(
                      student["status"] ==
                              "Active"
                          ? "Block Student"
                          : "Unblock Student",
                    ),
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
  // DETAIL ROW
  // ===========================================================================

  Widget _detailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade500,
        ),

        const SizedBox(width: 9),

        SizedBox(
          width: 90,
          child: Text(
            title,
            style: TextStyle(
              color:
                  Colors.grey.shade500,
              fontSize: 10,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // DETAIL STAT
  // ===========================================================================

  Widget _detailStat({
    required String title,
    required String value,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius:
            BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color:
                  Colors.grey.shade500,
              fontSize: 9,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // ORDER STATUS
  // ===========================================================================

  Widget _orderStatusBadge(
    String status,
  ) {
    Color color;

    switch (status) {
      case "Completed":
        color = Colors.green;
        break;

      case "Cancelled":
        color = Colors.red;
        break;

      default:
        color = Colors.orange;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.08,
        ),
        borderRadius:
            BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ===========================================================================
  // TOGGLE STATUS
  // ===========================================================================

  void _toggleStudentStatus(
    Map<String, dynamic> student,
  ) {
    final isActive =
        student["status"] == "Active";

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            isActive
                ? "Block Student?"
                : "Unblock Student?",
            style: const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          content: Text(
            isActive
                ? "${student["name"]} will not be able to place new orders."
                : "${student["name"]} will be able to place orders again.",
            style: TextStyle(
              color:
                  Colors.grey.shade700,
              fontSize: 13,
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
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    isActive
                        ? Colors.red
                        : Colors.green,
              ),
              onPressed: () {
                setState(() {
                  student["status"] =
                      isActive
                          ? "Blocked"
                          : "Active";
                });

                Navigator.pop(
                  dialogContext,
                );

                _showMessage(
                  isActive
                      ? "${student["name"]} blocked"
                      : "${student["name"]} unblocked",
                );
              },
              child: Text(
                isActive
                    ? "Block"
                    : "Unblock",
              ),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // DELETE STUDENT
  // ===========================================================================

  void _showDeleteDialog(
    Map<String, dynamic> student,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Delete Student?",
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          content: Text(
            'Are you sure you want to delete "${student["name"]}"? This action cannot be undone.',
            style: TextStyle(
              color:
                  Colors.grey.shade700,
              fontSize: 13,
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
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),
              onPressed: () {
                setState(() {
                  students.remove(
                    student,
                  );
                });

                Navigator.pop(
                  dialogContext,
                );

                _showMessage(
                  "${student["name"]} deleted",
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
  // MESSAGE
  // ===========================================================================

  void _showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
        duration:
            const Duration(seconds: 2),
      ),
    );
  }
}

// =============================================================================
// TABLE HEADER STYLE
// =============================================================================

const TextStyle _headerStyle =
    TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w700,
  color: Colors.grey,
);