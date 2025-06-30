import 'package:flutter/material.dart';

class MaterialFilterBar extends StatelessWidget {
  final String? selectedMaterial;
  final Function(String?) onMaterialSelected;

  const MaterialFilterBar({
    super.key,
    required this.selectedMaterial,
    required this.onMaterialSelected,
  });

  final List<String> _materialTypes = const [
    'All',
    'Paper',
    'Cardboard',
    'Plastic',
    'Metal',
    'Glass',
    'Electronics',
    'Battery',
    'Appliances',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _materialTypes.map((type) {
          final bool isSelected =
              type == selectedMaterial ||
              (type == 'All' && selectedMaterial == null);
          return FilterChip(
            label: Text(type),
            selected: isSelected,
            selectedColor: const Color(0xFF4A5F44),
            backgroundColor: Colors.white,
            checkmarkColor: Colors.white,
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
            ),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontFamily: 'Mallanna',
            ),
            onSelected: (bool selected) {
              if (type == 'All') {
                onMaterialSelected(null);
              } else {
                onMaterialSelected(selected ? type : null);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
