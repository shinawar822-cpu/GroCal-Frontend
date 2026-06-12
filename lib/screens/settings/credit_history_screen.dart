import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_theme.dart';

class CreditHistoryScreen extends StatelessWidget {
  const CreditHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser!;

    final transactions = [
      {'type': 'earned', 'amount': 15, 'desc': 'Task completed', 'date': '2h ago'},
      {'type': 'spent', 'amount': 50, 'desc': 'Created task', 'date': '1d ago'},
      {'type': 'earned', 'amount': 10, 'desc': 'Daily bonus', 'date': '2d ago'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Credit History')),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primaryColor, AppTheme.secondaryColor]), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Total Credits', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('${user.credits}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                ]),
                const Icon(Icons.account_balance_wallet, color: Colors.white, size: 40),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: _buildSummaryCard(context, 'Earned', user.creditsEarned, AppTheme.successColor)),
                const SizedBox(width: 12),
                Expanded(child: _buildSummaryCard(context, 'Spent', user.creditsSpent, AppTheme.errorColor)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transactions', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('Filter')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              itemBuilder: (ctx, i) {
                final tx = transactions[i];
                final isEarned = tx['type'] == 'earned';
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(isEarned ? Icons.add_circle : Icons.remove_circle, color: isEarned ? AppTheme.successColor : AppTheme.errorColor),
                    title: Text(tx['desc'] as String),
                    subtitle: Text(tx['date'] as String),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: (isEarned ? AppTheme.successColor : AppTheme.errorColor).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text('${isEarned ? '+' : '-'}${tx['amount']}', style: TextStyle(color: isEarned ? AppTheme.successColor : AppTheme.errorColor, fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, int value, Color color) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(color == AppTheme.successColor ? Icons.arrow_upward : Icons.arrow_downward, color: color, size: 20)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          Text('$value', style: Theme.of(context).textTheme.titleLarge),
        ]),
      ],
    ),
  );
}
