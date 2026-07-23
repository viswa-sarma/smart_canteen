import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const SearchBarWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Search food...",
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}