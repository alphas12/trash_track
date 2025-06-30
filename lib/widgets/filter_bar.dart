import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(
            label: const Text('All'),
            selected: selectedFilter == 'all',
            selectedColor: const Color(0xFF4A5F44),
            backgroundColor: Colors.white,
            checkmarkColor: Colors.white,
            side: BorderSide(
              color: selectedFilter == 'all'
                  ? Colors.transparent
                  : Colors.grey.shade300,
            ),
            labelStyle: TextStyle(
              color: selectedFilter == 'all' ? Colors.white : Colors.black,
              fontFamily: 'Mallanna',
            ),
            onSelected: (bool selected) {
              onFilterChanged('all');
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Closed'),
            selected: selectedFilter == 'closed',
            selectedColor: const Color(0xFF4A5F44),
            backgroundColor: Colors.white,
            checkmarkColor: Colors.white,
            side: BorderSide(
              color: selectedFilter == 'closed'
                  ? Colors.transparent
                  : Colors.grey.shade300,
            ),
            labelStyle: TextStyle(
              color: selectedFilter == 'closed' ? Colors.white : Colors.black,
              fontFamily: 'Mallanna',
            ),
            onSelected: (bool selected) {
              onFilterChanged('closed');
            },
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Open'),
            selected: selectedFilter == 'open',
            selectedColor: const Color(0xFF4A5F44),
            backgroundColor: Colors.white,
            checkmarkColor: Colors.white,
            side: BorderSide(
              color: selectedFilter == 'open'
                  ? Colors.transparent
                  : Colors.grey.shade300,
            ),
            labelStyle: TextStyle(
              color: selectedFilter == 'open' ? Colors.white : Colors.black,
              fontFamily: 'Mallanna',
            ),
            onSelected: (bool selected) {
              onFilterChanged('open');
            },
          ),
        ],
      ),
    );
  }
}
