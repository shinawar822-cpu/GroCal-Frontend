import 'package:flutter/material.dart';
import '../core/utils/constants.dart';
import '../core/theme/app_theme.dart';

class FilterBottomSheet extends StatefulWidget {
  final Map<String, String> initialFilters;
  const FilterBottomSheet({super.key, required this.initialFilters});

  static Future<Map<String, String>?> open(
      BuildContext context, Map<String, String> initialFilters) {
    return showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FilterBottomSheet(initialFilters: initialFilters),
      ),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _niche;
  late String _platform;
  late String _country;
  late String _language;
  late String _followers;
  late String _activity;

  @override
  void initState() {
    super.initState();
    _niche = widget.initialFilters['niche'] ?? 'All';
    _platform = widget.initialFilters['platform'] ?? 'All';
    _country = widget.initialFilters['country'] ?? 'All Countries';
    _language = widget.initialFilters['language'] ?? 'English';
    _followers = widget.initialFilters['followers'] ?? 'All';
    _activity = widget.initialFilters['activity'] ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                  color: AppTheme.textSecondary,
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
          const SizedBox(height: 16),
          Text('Filters',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildDropdown(
              'Creator Niche',
              _niche,
              ['All', ...AppConstants.niches],
              (value) => setState(() => _niche = value)),
          const SizedBox(height: 12),
          _buildDropdown(
              'Platform',
              _platform,
              ['All', ...AppConstants.platforms],
              (value) => setState(() => _platform = value)),
          const SizedBox(height: 12),
          _buildDropdown('Country', _country, AppConstants.countries,
              (value) => setState(() => _country = value)),
          const SizedBox(height: 12),
          _buildDropdown(
              'Language',
              _language,
              ['English', 'Urdu', 'Arabic', 'Hindi', 'Spanish', 'Other'],
              (value) => setState(() => _language = value)),
          const SizedBox(height: 12),
          _buildDropdown(
              'Followers',
              _followers,
              ['All', '0 - 1K', '1K - 10K', '10K - 100K', '100K+'],
              (value) => setState(() => _followers = value)),
          const SizedBox(height: 12),
          _buildDropdown(
              'Activity Level',
              _activity,
              ['All', 'Very Active', 'Active', 'Moderate', 'New User'],
              (value) => setState(() => _activity = value)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, {
                    'niche': _niche,
                    'platform': _platform,
                    'country': _country,
                    'language': _language,
                    'followers': _followers,
                    'activity': _activity,
                  }),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String currentValue, List<String> options,
      ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: currentValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppTheme.backgroundColor,
          ),
          items: options
              .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)))
              .toList(),
          onChanged: (value) => onChanged(value ?? currentValue),
        ),
      ],
    );
  }
}
