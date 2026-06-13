import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class NicheChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const NicheChipWidget(
      {super.key,
      required this.label,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppTheme.primaryColor,
      labelStyle:
          TextStyle(color: selected ? Colors.white : AppTheme.textPrimary),
      backgroundColor: AppTheme.backgroundColor,
    );
  }
}
