import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/user_service.dart';
import 'user_info_screen.dart';
import 'main_menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final UserService _userService = UserService();
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isLoading = true;
  bool _hasUserProfile = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkUserProfile();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _scaleController.forward();
    });
  }

  Future<void> _checkUserProfile() async {
    try {
      final profile = await _userService.loadUserProfile();
      setState(() {
        _hasUserProfile = profile != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasUserProfile = false;
        _isLoading = false;
      });
    }
  }

  void _startExperience() {
    if (_hasUserProfile) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserInfoScreen()),
      );
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.algerianGreen,
                    AppColors.lightGreen,
                    AppColors.algerianWhite,
                  ],
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
              child: const Center(child: CircularProgressIndicator(color: AppColors.algerianWhite)),
            )
          : FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Top half - Clean image with no text overlay
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/welcom-img.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback gradient background with Algerian cultural elements
                          return Container(
                            decoration: const BoxDecoration(
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
                                Icon(
                                  Icons.account_balance,
                                  size: 80,
                                  color: AppColors.algerianWhite.withValues(alpha: 0.9),
                                ),
                                const SizedBox(height: 20),
                                Icon(
                                  Icons.home_outlined,
                                  size: 60,
                                  color: AppColors.algerianWhite.withValues(alpha: 0.8),
                                ),
                                const SizedBox(height: 20),
                                Icon(
                                  Icons.smart_toy_outlined,
                                  size: 50,
                                  color: AppColors.algerianRed.withValues(alpha: 0.9),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Bottom half - Content area
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.lightGreen,
                            AppColors.algerianWhite,
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // App title and content - Scrollable
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // App title section
                                        ScaleTransition(
                                          scale: _scaleAnimation,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Araloug',
                                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                                  color: AppColors.algerianRed,                                       
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 6),

                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        // Description text
                                        Text(
                                          'Explore the rich dialects, traditions, and wisdom of Algeria through interactive conversations and cultural experiences.',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: AppColors.textPrimary,
                                            height: 1.4,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        // Cultural icons row
                                        ScaleTransition(
                                          scale: _scaleAnimation,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              _buildCultureIcon(Icons.account_balance, 'Heritage'),
                                              _buildCultureIcon(Icons.chat_bubble_outline, 'Dialects'),
                                              _buildCultureIcon(Icons.school_outlined, 'Learn'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Start button
                              ScaleTransition(
                                scale: _scaleAnimation,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: _startExperience,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.algerianRed,
                                      foregroundColor: AppColors.algerianWhite,
                                      elevation: 8,
                                      shadowColor: AppColors.algerianRed.withValues(alpha: 0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _hasUserProfile ? 'Continue Journey' : 'Start Your Journey',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward, size: 24),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Footer with cultural note
                              const SizedBox(height: 16),
                              Text(
                                'Offline Cultural Experience',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCultureIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.algerianGreen.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.algerianGreen.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            size: 24,
            color: AppColors.algerianGreen,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
