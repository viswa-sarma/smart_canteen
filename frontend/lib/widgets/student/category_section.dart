import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "title": "Breakfast",
        "icon": Icons.free_breakfast_rounded,
        "color": Colors.orange,
      },
      {
        "title": "Lunch",
        "icon": Icons.lunch_dining_rounded,
        "color": Colors.green,
      },
      {
        "title": "Snacks",
        "icon": Icons.fastfood_rounded,
        "color": Colors.red,
      },
      {
        "title": "Drinks",
        "icon": Icons.local_drink_rounded,
        "color": Colors.blue,
      },
      {
        "title": "Desserts",
        "icon": Icons.icecream_rounded,
        "color": Colors.pink,
      },
      {
        "title": "Meals",
        "icon": Icons.rice_bowl_rounded,
        "color": Colors.deepPurple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: categories.map((category) {
            return _CategoryCard(
              title: category["title"] as String,
              icon: category["icon"] as IconData,
              color: category["color"] as Color,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 72) / 3;

    return SizedBox(
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}