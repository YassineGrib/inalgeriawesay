import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import '../models/user_profile.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    final userProfile = useState<UserProfile?>(null);
    final isLoading = useState(true);
    final completedDialogues = useState<List<String>>([]);
    final completedChallenges = useState<List<String>>([]);
    final totalPoints = useState(0);

    useEffect(() {
      Future<void> loadUserData() async {
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
          print('Error loading user data: $e');
        } finally {
          isLoading.value = false;
        }
      }

      loadUserData();
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
          title: const Text('Profile'),
          backgroundColor: AppColors.algerianGreen,
          foregroundColor: AppColors.algerianWhite,
        ),
        body: const Center(
          child: Text(
            'No profile found',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    final profile = userProfile.value!;
    final memberSince = _formatDate(profile.createdAt);
    final lastActive = profile.lastActiveAt != null 
        ? _formatDate(profile.lastActiveAt!) 
        : 'Never';

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // Profile Header
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.algerianGreen,
            foregroundColor: AppColors.algerianWhite,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                profile.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Profile Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.algerianWhite,
                        border: Border.all(
                          color: AppColors.algerianWhite,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.algerianGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${profile.age} years old',
                      style: const TextStyle(
                        color: AppColors.algerianWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      profile.country,
                      style: const TextStyle(
                        color: AppColors.algerianWhite,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Overview
                  _buildProgressOverview(
                    totalPoints.value,
                    completedDialogues.value.length,
                    completedChallenges.value.length,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Statistics Cards
                  _buildStatisticsSection(profile, memberSince, lastActive),
                  
                  const SizedBox(height: 24),
                  
                  // Achievements Section
                  _buildAchievementsSection(
                    completedDialogues.value.length,
                    completedChallenges.value.length,
                    totalPoints.value,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Preferences Section
                  _buildPreferencesSection(profile),
                  
                  const SizedBox(height: 100), // Space for floating nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressOverview(int points, int dialogues, int challenges) {
    final totalActivities = dialogues + challenges;
    final level = _calculateLevel(points);
    final nextLevelPoints = _getNextLevelPoints(level);
    final currentLevelPoints = _getCurrentLevelPoints(level);
    final progressToNext = points > currentLevelPoints 
        ? (points - currentLevelPoints) / (nextLevelPoints - currentLevelPoints)
        : 0.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.algerianGreen.withValues(alpha: 0.1),
              AppColors.algerianRed.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Level $level',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.algerianGreen,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.algerianRed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$points pts',
                    style: const TextStyle(
                      color: AppColors.algerianWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Progress Bar
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
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${points - currentLevelPoints}/${nextLevelPoints - currentLevelPoints}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progressToNext.clamp(0.0, 1.0),
                  backgroundColor: AppColors.backgroundLight,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.algerianGreen),
                  minHeight: 8,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Activity Summary
            Row(
              children: [
                Expanded(
                  child: _buildProgressItem(
                    'Conversations',
                    dialogues.toString(),
                    Icons.chat_bubble_outline,
                    AppColors.algerianGreen,
                  ),
                ),
                Expanded(
                  child: _buildProgressItem(
                    'Challenges',
                    challenges.toString(),
                    Icons.quiz,
                    AppColors.algerianRed,
                  ),
                ),
                Expanded(
                  child: _buildProgressItem(
                    'Total Activities',
                    totalActivities.toString(),
                    Icons.trending_up,
                    AppColors.tealAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(UserProfile profile, String memberSince, String lastActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Member Since',
                memberSince,
                Icons.calendar_today,
                AppColors.algerianGreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Last Active',
                lastActive,
                Icons.access_time,
                AppColors.algerianRed,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection(int dialogues, int challenges, int points) {
    final achievements = _getAchievements(dialogues, challenges, points);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: _buildAchievementCard(
                  achievement['title']!,
                  achievement['description']!,
                  achievement['icon'] as IconData,
                  achievement['color'] as Color,
                  achievement['unlocked'] as bool,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    IconData icon,
    Color color,
    bool unlocked,
  ) {
    return Tooltip(
      message: '$title: $description',
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: unlocked ? color.withValues(alpha: 0.2) : AppColors.backgroundLight,
          border: Border.all(
            color: unlocked ? color : AppColors.textSecondary.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: unlocked ? color : AppColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(UserProfile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferences',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        if (profile.favoriteRegions.isNotEmpty) ...[
          _buildPreferenceCard(
            'Favorite Regions',
            profile.favoriteRegions.join(', '),
            Icons.location_on,
            AppColors.algerianGreen,
          ),
          const SizedBox(height: 12),
        ],
        if (profile.preferredLanguages.isNotEmpty) ...[
          _buildPreferenceCard(
            'Preferred Languages',
            profile.preferredLanguages.join(', '),
            Icons.language,
            AppColors.algerianRed,
          ),
        ],
        if (profile.favoriteRegions.isEmpty && profile.preferredLanguages.isEmpty)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    size: 40,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No preferences set',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Complete more activities to set your preferences',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPreferenceCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
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
                color: color.withValues(alpha: 0.1),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getAchievements(int dialogues, int challenges, int points) {
    return [
      {
        'title': 'First Steps',
        'description': 'Complete first conversation',
        'icon': Icons.chat,
        'color': AppColors.algerianGreen,
        'unlocked': dialogues >= 1,
      },
      {
        'title': 'Challenger',
        'description': 'Complete first challenge',
        'icon': Icons.quiz,
        'color': AppColors.algerianRed,
        'unlocked': challenges >= 1,
      },
      {
        'title': 'Conversationalist',
        'description': 'Complete 5 conversations',
        'icon': Icons.chat_bubble,
        'color': AppColors.tealAccent,
        'unlocked': dialogues >= 5,
      },
      {
        'title': 'Scholar',
        'description': 'Earn 100 points',
        'icon': Icons.school,
        'color': AppColors.purpleAccent,
        'unlocked': points >= 100,
      },
      {
        'title': 'Expert',
        'description': 'Complete 10 challenges',
        'icon': Icons.star,
        'color': AppColors.desertOrange,
        'unlocked': challenges >= 10,
      },
      {
        'title': 'Master',
        'description': 'Reach Level 5',
        'icon': Icons.emoji_events,
        'color': AppColors.algerianRed,
        'unlocked': _calculateLevel(points) >= 5,
      },
    ];
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}
