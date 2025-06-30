import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_profile.dart';

class ProgressScreen extends HookWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    final userProfile = useState<UserProfile?>(null);
    final isLoading = useState(true);
    final completedDialogues = useState<List<String>>([]);
    final completedChallenges = useState<List<String>>([]);
    final totalPoints = useState(0);

    useEffect(() {
      Future<void> loadProgressData() async {
        try {
          final profile = await userService.loadUserProfile();
          final dialogues = await userService.getCompletedDialogues();
          final challenges = await userService.getCompletedChallenges();
          final points = await userService.getTotalPoints();

          userProfile.value = profile;
          completedDialogues.value = dialogues;
          completedChallenges.value = challenges;
          totalPoints.value = points;
        } catch (e) {
          print('Error loading progress data: $e');
        } finally {
          isLoading.value = false;
        }
      }

      loadProgressData();
      return null;
    }, []);

    if (isLoading.value) {
      return Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: const Center(
          child: CircularProgressIndicator(
            color: AppColors.algerianGreen,
          ),
        ),
      );
    }

    if (userProfile.value == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          title: const Text('Progress'),
          backgroundColor: AppColors.algerianGreen,
          foregroundColor: AppColors.algerianWhite,
        ),
        body: const Center(
          child: Text(
            'No progress data found',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    final profile = userProfile.value!;
    final level = _calculateLevel(totalPoints.value);
    final nextLevelPoints = _getNextLevelPoints(level);
    final currentLevelPoints = _getCurrentLevelPoints(level);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Your Progress'),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Level Progress Card
            _buildLevelProgressCard(
              level,
              totalPoints.value,
              currentLevelPoints,
              nextLevelPoints,
            ),
            
            const SizedBox(height: 24),
            
            // Activity Progress
            _buildActivityProgress(
              completedDialogues.value.length,
              completedChallenges.value.length,
            ),
            
            const SizedBox(height: 24),
            
            // Weekly Progress Chart
            _buildWeeklyProgressChart(),
            
            const SizedBox(height: 24),
            
            // Milestones
            _buildMilestonesSection(
              completedDialogues.value.length,
              completedChallenges.value.length,
              totalPoints.value,
            ),
            
            const SizedBox(height: 24),
            
            // Recent Activities
            _buildRecentActivities(
              completedDialogues.value,
              completedChallenges.value,
            ),
            
            const SizedBox(height: 100), // Space for floating nav
          ],
        ),
      ),
    );
  }

  Widget _buildLevelProgressCard(int level, int points, int currentLevelPoints, int nextLevelPoints) {
    final progressToNext = points > currentLevelPoints 
        ? (points - currentLevelPoints) / (nextLevelPoints - currentLevelPoints)
        : 0.0;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.algerianGreen,
              AppColors.lightGreen,
              AppColors.tealAccent,
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Level $level',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.algerianWhite,
                      ),
                    ),
                    Text(
                      '$points Total Points',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.algerianWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.algerianWhite.withValues(alpha: 0.2),
                    border: Border.all(
                      color: AppColors.algerianWhite,
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: 40,
                    color: AppColors.algerianWhite,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Progress to next level
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress to Level ${level + 1}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.algerianWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${points - currentLevelPoints}/${nextLevelPoints - currentLevelPoints}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.algerianWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.algerianWhite.withValues(alpha: 0.3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressToNext.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.algerianWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityProgress(int dialogues, int challenges) {
    final totalActivities = dialogues + challenges;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity Progress',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActivityCard(
                'Conversations',
                dialogues,
                20, // Target
                Icons.chat_bubble_outline,
                AppColors.algerianGreen,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActivityCard(
                'Challenges',
                challenges,
                15, // Target
                Icons.quiz,
                AppColors.algerianRed,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityCard(
          'Total Activities',
          totalActivities,
          35, // Target
          Icons.trending_up,
          AppColors.tealAccent,
        ),
      ],
    );
  }

  Widget _buildActivityCard(String title, int completed, int target, IconData icon, Color color) {
    final progress = completed / target;
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.1),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '$completed / $target',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toInt()}% Complete',
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyProgressChart() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (index) {
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  final activities = [3, 5, 2, 7, 4, 6, 1]; // Mock data
                  final maxActivity = activities.reduce((a, b) => a > b ? a : b);
                  final height = (activities[index] / maxActivity) * 80;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 24,
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.algerianGreen,
                              AppColors.lightGreen,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        days[index],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${activities[index]}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestonesSection(int dialogues, int challenges, int points) {
    final milestones = [
      {'title': 'First Conversation', 'target': 1, 'current': dialogues, 'type': 'conversations'},
      {'title': '5 Conversations', 'target': 5, 'current': dialogues, 'type': 'conversations'},
      {'title': 'First Challenge', 'target': 1, 'current': challenges, 'type': 'challenges'},
      {'title': '100 Points', 'target': 100, 'current': points, 'type': 'points'},
      {'title': '10 Challenges', 'target': 10, 'current': challenges, 'type': 'challenges'},
      {'title': '500 Points', 'target': 500, 'current': points, 'type': 'points'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Milestones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...milestones.map((milestone) => _buildMilestoneItem(
          milestone['title'] as String,
          milestone['current'] as int,
          milestone['target'] as int,
          milestone['type'] as String,
        )),
      ],
    );
  }

  Widget _buildMilestoneItem(String title, int current, int target, String type) {
    final isCompleted = current >= target;
    final progress = (current / target).clamp(0.0, 1.0);

    Color color;
    IconData icon;

    switch (type) {
      case 'conversations':
        color = AppColors.algerianGreen;
        icon = Icons.chat_bubble_outline;
        break;
      case 'challenges':
        color = AppColors.algerianRed;
        icon = Icons.quiz;
        break;
      case 'points':
        color = AppColors.tealAccent;
        icon = Icons.star;
        break;
      default:
        color = AppColors.textSecondary;
        icon = Icons.flag;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: isCompleted ? 4 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? color : color.withValues(alpha: 0.3),
                ),
                child: Icon(
                  isCompleted ? Icons.check : icon,
                  color: AppColors.algerianWhite,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isCompleted ? color : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$current / $target',
                      style: TextStyle(
                        fontSize: 14,
                        color: isCompleted ? color : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: color.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivities(List<String> dialogues, List<String> challenges) {
    final recentActivities = <Map<String, dynamic>>[];

    // Add recent dialogues (mock data for now)
    for (int i = 0; i < dialogues.length && i < 3; i++) {
      recentActivities.add({
        'title': 'Conversation ${i + 1}',
        'subtitle': 'Completed dialogue',
        'icon': Icons.chat_bubble_outline,
        'color': AppColors.algerianGreen,
        'time': '${i + 1} day${i > 0 ? 's' : ''} ago',
      });
    }

    // Add recent challenges (mock data for now)
    for (int i = 0; i < challenges.length && i < 3; i++) {
      recentActivities.add({
        'title': 'Challenge ${i + 1}',
        'subtitle': 'Completed quiz',
        'icon': Icons.quiz,
        'color': AppColors.algerianRed,
        'time': '${i + 2} day${i > 0 ? 's' : ''} ago',
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        if (recentActivities.isEmpty)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    size: 40,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No recent activities',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start a conversation or challenge to see your progress!',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ...recentActivities.take(5).map((activity) => _buildActivityItem(
            activity['title'] as String,
            activity['subtitle'] as String,
            activity['icon'] as IconData,
            activity['color'] as Color,
            activity['time'] as String,
          )),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.1),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          trailing: Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  int _calculateLevel(int points) {
    if (points < 50) return 1;
    if (points < 150) return 2;
    if (points < 300) return 3;
    if (points < 500) return 4;
    if (points < 750) return 5;
    if (points < 1000) return 6;
    return 7 + ((points - 1000) ~/ 500);
  }

  int _getCurrentLevelPoints(int level) {
    switch (level) {
      case 1: return 0;
      case 2: return 50;
      case 3: return 150;
      case 4: return 300;
      case 5: return 500;
      case 6: return 750;
      case 7: return 1000;
      default: return 1000 + ((level - 7) * 500);
    }
  }

  int _getNextLevelPoints(int level) {
    return _getCurrentLevelPoints(level + 1);
  }
}
