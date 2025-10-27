import 'package:flutter/material.dart';

class FilterButtonsWidget extends StatefulWidget {
  final Function(String) onFilterChanged;
  final String initialFilter;

  const FilterButtonsWidget({
    super.key,
    required this.onFilterChanged,
    this.initialFilter = 'This week',
  });

  @override
  State<FilterButtonsWidget> createState() => _FilterButtonsWidgetState();
}

class _FilterButtonsWidgetState extends State<FilterButtonsWidget> {
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['This week', 'This month', 'This year'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() => selectedFilter = filter);
                widget.onFilterChanged(filter);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFE57373) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFE57373)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
