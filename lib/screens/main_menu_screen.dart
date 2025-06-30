import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'level_selection_screen.dart';
import 'scientists_screen.dart';
import 'challenges_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';
import 'culture_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final PageController _tipsController = PageController();
  int _currentTipIndex = 0;
  int _selectedNavIndex = 0;

  final List<Map<String, dynamic>> _tips = [
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Daily Practice',
      'description': 'Practice 10 minutes daily to improve your Algerian dialect skills',
      'color': AppColors.algerianGreen,
    },
    {
      'icon': Icons.people_outline,
      'title': 'Cultural Context',
      'description': 'Learn about the cultural background behind each expression',
      'color': AppColors.algerianRed,
    },
    {
      'icon': Icons.star_outline,
      'title': 'Earn Points',
      'description': 'Complete challenges and conversations to earn points and unlock content',
      'color': AppColors.tealAccent,
    },
    {
      'icon': Icons.headphones_outlined,
      'title': 'Listen Carefully',
      'description': 'Pay attention to pronunciation and intonation patterns',
      'color': AppColors.purpleAccent,
    },
  ];

  @override
  void dispose() {
    _tipsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          // Enhanced Custom App Bar
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.algerianGreen,
            foregroundColor: AppColors.algerianWhite,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.algerianWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.algerianWhite.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.language,
                      color: AppColors.algerianWhite,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Araloug',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.algerianWhite,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'أرالوغ' ,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.algerianWhite,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.algerianGreen,
                      AppColors.algerianGreen.withValues(alpha: 0.9),
                      AppColors.algerianRed.withValues(alpha: 0.1),
                    ],
                    stops: const [0.0, 0.7, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative pattern
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.algerianWhite.withValues(alpha: 0.1),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.algerianWhite.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Welcome text in expanded state
                    Positioned(
                      top: 60,
                      left: 20,
                      right: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              color: AppColors.algerianWhite.withValues(alpha: 0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Explore Algerian culture and language',
                            style: TextStyle(
                              color: AppColors.algerianWhite.withValues(alpha: 0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tips Slider Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.tips_and_updates,
                          color: AppColors.algerianGreen,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Daily Tips',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.algerianGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _tipsController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentTipIndex = index;
                        });
                      },
                      itemCount: _tips.length,
                      itemBuilder: (context, index) {
                        final tip = _tips[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                tip['color'].withValues(alpha: 0.1),
                                tip['color'].withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: tip['color'].withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: tip['color'].withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  tip['icon'],
                                  color: tip['color'],
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tip['title'],
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: tip['color'],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tip['description'],
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Menu Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildListDelegate([
                _buildMenuCard(
                  context,
                  title: 'Conversations',
                  subtitle: 'Practice dialogues',
                  icon: Icons.chat_bubble_outline,
                  color: AppColors.algerianGreen,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LevelSelectionScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  title: 'Scientists',
                  subtitle: 'Famous Algerians',
                  icon: Icons.science,
                  color: AppColors.algerianRed,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScientistsScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  title: 'Challenges',
                  subtitle: 'Cultural quizzes',
                  icon: Icons.quiz,
                  color: AppColors.tealAccent,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ChallengesScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  title: 'Algerian Culture',
                  subtitle: 'Discover places & heritage',
                  icon: Icons.location_city,
                  color: AppColors.desertOrange,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CultureScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  title: 'Progress',
                  subtitle: 'Track achievements',
                  icon: Icons.trending_up,
                  color: AppColors.purpleAccent,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProgressScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuCard(
                  context,
                  title: 'Settings',
                  subtitle: 'Customize app',
                  icon: Icons.settings,
                  color: AppColors.indigoAccent,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Settings coming soon!'),
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),

          // Extra spacing for floating navbar
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),

      // Floating Navigation Bar
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.algerianGreen,
                AppColors.algerianGreen.withValues(alpha: 0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: AppColors.algerianGreen.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.chat, 'Chat', 1),
              _buildNavItem(Icons.star, 'Progress', 2),
              _buildNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
        // Handle navigation based on index
        switch (index) {
          case 0:
            // Already on home
            break;
          case 1:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LevelSelectionScreen(),
              ),
            );
            break;
          case 2:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProgressScreen(),
              ),
            );
            break;
          case 3:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
            ? AppColors.algerianWhite.withValues(alpha: 0.2)
            : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.algerianWhite,
              size: isSelected ? 24 : 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: AppColors.algerianWhite,
                fontSize: isSelected ? 12 : 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.algerianWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.2),
                      color.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
