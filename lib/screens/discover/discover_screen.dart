import 'package:flutter/material.dart';
import '../../core/services/dummy_data.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/constants.dart';
import '../../widgets/creator_card_widget.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _selectedNiche = 'All';

  @override
  Widget build(BuildContext context) {
    final creators = DummyData.suggestedCreators;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [IconButton(icon: const Icon(Icons.tune), onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search creators...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppTheme.backgroundColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppConstants.niches.take(6).length + 1,
              itemBuilder: (ctx, i) {
                final niche = i == 0 ? 'All' : AppConstants.niches[i - 1];
                return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(niche),
                      selected: _selectedNiche == niche,
                      onSelected: (s) => setState(() => _selectedNiche = niche),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: AppTheme.backgroundColor,
                    ));
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: creators.length,
              itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CreatorCardWidget(creator: creators[i])),
            ),
          ),
        ],
      ),
    );
  }
}
