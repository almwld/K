import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../services/cache/local_storage_service.dart';
import '../widgets/simple_app_bar.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  int _points = 0;
  int _streakDays = 0;
  int _currentDay = 1;

  final List<Map<String, dynamic>> _dailyTasks = [
    {'icon': Icons.login, 'title': 'تسجيل الدخول اليومي', 'points': 10, 'completed': true},
    {'icon': Icons.share, 'title': 'مشاركة منتج', 'points': 25, 'completed': false},
    {'icon': Icons.star, 'title': 'إضافة تقييم', 'points': 50, 'completed': false},
    {'icon': Icons.person_add, 'title': 'دعوة صديق', 'points': 200, 'completed': false},
    {'icon': Icons.shopping_cart, 'title': 'إكمال عملية شراء', 'points': 100, 'completed': false},
  ];

  final List<Map<String, dynamic>> _rewards = [
    {'title': 'كوبون 5000 ر.ي', 'points': 1000, 'icon': Icons.card_giftcard},
    {'title': 'توصيل مجاني', 'points': 500, 'icon': Icons.local_shipping},
    {'title': 'خصم 10%', 'points': 800, 'icon': Icons.percent},
    {'title': 'باقة إنترنت 1GB', 'points': 1200, 'icon': Icons.wifi},
  ];

  final List<Map<String, dynamic>> _leaderboard = [
    {'name': 'أحمد محمد', 'points': 12500, 'avatar': null},
    {'name': 'خالد علي', 'points': 10200, 'avatar': null},
    {'name': 'فاطمة أحمد', 'points': 9800, 'avatar': null},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _points = LocalStorageService.getGardenPoints();
      _streakDays = LocalStorageService.getStreakDays();
    });
  }

  void _claimTask(int index) {
    final task = _dailyTasks[index];
    if (task['completed']) return;

    setState(() {
      _points += task['points'] as int;
      _dailyTasks[index]['completed'] = true;
    });

    LocalStorageService.setGardenPoints(_points);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم الحصول على ${task['points']} نقطة!'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void _redeemReward(int points) {
    if (_points < points) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('نقاطك غير كافية!'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() {
      _points -= points;
    });

    LocalStorageService.setGardenPoints(_points);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم استبدال النقاط بنجاح!'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'حديقة فلكس'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Points
            _buildHeader(),

            const SizedBox(height: 24),

            // Streak Calendar
            _buildStreakCalendar(),

            const SizedBox(height: 24),

            // Daily Tasks
            _buildDailyTasks(),

            const SizedBox(height: 24),

            // Games Section
            _buildGamesSection(),

            const SizedBox(height: 24),

            // Rewards Shop
            _buildRewardsShop(),

            const SizedBox(height: 24),

            // Leaderboard
            _buildLeaderboard(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_florist,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'نقاطك الحالية',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_points',
            style: const TextStyle(
              fontFamily: 'Changa',
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'نقطة',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildStreakCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'سلسلة الأيام',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.orange, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$_streakDays يوم',
                      style: const TextStyle(
                        color: AppTheme.goldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final isCompleted = index < _streakDays % 7;
              final isToday = index == (_streakDays % 7);
              return Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: isCompleted || isToday
                          ? const LinearGradient(
                              colors: [AppTheme.goldColor, AppTheme.goldLight],
                            )
                          : null,
                      color: isCompleted || isToday ? null : Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : Icons.circle,
                      color: isCompleted ? Colors.black : (isToday ? Colors.white : Colors.grey),
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ['أحد', 'اثنين', 'ثلاث', 'أربع', 'خميس', 'جمعة', 'سبت'][index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isToday ? AppTheme.goldColor : AppTheme.getSecondaryTextColor(context),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildDailyTasks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'مهام اليوم',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(_dailyTasks.length, (index) {
            final task = _dailyTasks[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: task['completed']
                        ? Colors.green.withOpacity(0.1)
                        : AppTheme.goldColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    task['icon'] as IconData,
                    color: task['completed'] ? Colors.green : AppTheme.goldColor,
                  ),
                ),
                title: Text(task['title'] as String),
                subtitle: Text('+${task['points']} نقطة'),
                trailing: task['completed']
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : ElevatedButton(
                        onPressed: () => _claimTask(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.goldColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text('احصل'),
                      ),
              ),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildGamesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ألعاب وفعاليات',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildGameCard(
                  'عجلة الحظ',
                  Icons.casino,
                  Colors.purple,
                  () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildGameCard(
                  'خمن السعر',
                  Icons.attach_money,
                  Colors.green,
                  () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildGameCard(
                  'الكنز اليمني',
                  Icons.diamond,
                  Colors.blue,
                  () {},
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildGameCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsShop() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'متجر الجوائز',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _rewards.length,
            itemBuilder: (context, index) {
              final reward = _rewards[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(reward['icon'] as IconData, color: AppTheme.goldColor, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      reward['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${reward['points']} نقطة',
                      style: const TextStyle(
                        color: AppTheme.goldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => _redeemReward(reward['points'] as int),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: const Text('استبدال'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _buildLeaderboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'قائمة المتصدرين',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(_leaderboard.length, (index) {
            final user = _leaderboard[index];
            final colors = [Colors.amber, Colors.grey.shade400, Colors.brown.shade300];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: colors[index],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    CircleAvatar(
                      backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                      child: const Icon(Icons.person, color: AppTheme.goldColor),
                    ),
                  ],
                ),
                title: Text(user['name'] as String),
                trailing: Text(
                  '${user['points']} نقطة',
                  style: const TextStyle(
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms);
  }
}
