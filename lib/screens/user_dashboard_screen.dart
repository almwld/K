import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_stats_provider.dart';
import '../models/user_stats_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final statsProvider = Provider.of<UserStatsProvider>(context);
    final stats = statsProvider.stats;

    if (statsProvider.isLoading || stats == null) {
      return Scaffold(
        appBar: const SimpleAppBar(title: 'لوحة التحكم'),
        body: Center(
          child: CircularProgressIndicator(
            color: AppTheme.gold,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'لوحة التحكم'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Level Card
                  _buildLevelCard(stats),
                  const SizedBox(height: 20),

                  // Stats Grid
                  _buildStatsGrid(stats),
                  const SizedBox(height: 20),

                  // Spending Chart (simplified)
                  _buildSpendingCard(stats),
                  const SizedBox(height: 20),

                  // Achievements
                  if (stats.achievements.isNotEmpty) ...[
                    const Text(
                      'إنجازاتي',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: stats.achievements
                          .map((a) => _achievementBadge(a))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(UserStatsModel stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            stats.levelColor.withOpacity(0.4),
            stats.levelColor.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: stats.levelColor.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: stats.levelColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: stats.levelColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المستوى ${stats.levelNameAr}',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: stats.levelColor,
                      ),
                    ),
                    Text(
                      '${stats.loyaltyPoints} نقطة ولاء',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: stats.levelProgress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(stats.levelColor),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 8),
          if (stats.level != UserLevel.diamond)
            Text(
              '${stats.pointsToNextLevel} نقطة للمستوى التالي',
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(UserStatsModel stats) {
    final items = [
      {'title': 'إجمالي الإنفاق', 'value': '${(stats.totalSpent / 1000).toStringAsFixed(0)}K', 'icon': Icons.account_balance_wallet},
      {'title': 'الطلبات', 'value': '${stats.ordersCount}', 'icon': Icons.shopping_bag},
      {'title': 'المكتملة', 'value': '${stats.completedOrders}', 'icon': Icons.check_circle},
      {'title': 'النقاط', 'value': '${stats.loyaltyPoints}', 'icon': Icons.stars},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['icon'] as IconData,
                color: const Color(0xFFF0B90B),
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                item['value'] as String,
                style: const TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF0B90B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item['title'] as String,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpendingCard(UserStatsModel stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الإنفاق',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _spendingItem('هذا الشهر', stats.monthlySpent),
              Container(height: 40, width: 1, color: Colors.grey[800]),
              _spendingItem('هذه السنة', stats.yearlySpent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _spendingItem(String label, double amount) {
    return Column(
      children: [
        Text(
          '${amount.toStringAsFixed(0)} ر.ي',
          style: const TextStyle(
            fontFamily: 'Changa',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF0B90B),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
        ),
      ],
    );
  }

  Widget _achievementBadge(String achievementId) {
    final achievement = userAchievements.firstWhere(
      (a) => a['id'] == achievementId,
      orElse: () => {'id': '', 'title': '', 'icon': Icons.star, 'color': 0xFFF0B90B},
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(achievement['color'] as int).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(achievement['color'] as int).withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            achievement['icon'] as IconData,
            size: 16,
            color: Color(achievement['color'] as int),
          ),
          const SizedBox(width: 6),
          Text(
            achievement['title'] as String,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(achievement['color'] as int),
            ),
          ),
        ],
      ),
    );
  }
}
import '../models/user_stats_model.dart';
