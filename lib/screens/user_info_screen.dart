import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../models/user_profile.dart';
import '../services/user_service.dart';
import 'promotional_video_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  final UserService _userService = UserService();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _saveUserInfo() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final profile = UserProfile(
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        country: _countryController.text.trim(),
        createdAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
      );

      await _userService.saveUserProfile(profile);
      await _userService.setFirstLaunchComplete();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PromotionalVideoScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _createDemoUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final demoProfile = UserProfile(
        name: 'Ahmed Demo',
        age: 25,
        country: 'Algeria',
        createdAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
        totalPoints: 50,
        completedDialogues: 2,
        completedChallenges: 3,
        favoriteRegions: ['north', 'west'],
        preferredLanguages: ['arabic', 'english'],
      );

      await _userService.saveUserProfile(demoProfile);
      await _userService.setFirstLaunchComplete();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PromotionalVideoScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating demo user: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Welcome!'),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.algerianGreen.withValues(alpha: 0.1),
                        AppColors.algerianRed.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.algerianGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 48,
                        color: AppColors.algerianGreen,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tell us about yourself',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.algerianGreen,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This helps us personalize your cultural learning experience',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Name field
                Text(
                  'Your Name',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.algerianGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.person, color: AppColors.algerianGreen),
                    filled: true,
                    fillColor: AppColors.algerianWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.algerianGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.algerianGreen, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Age field
                Text(
                  'Your Age',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.algerianGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter your age',
                    prefixIcon: const Icon(Icons.cake, color: AppColors.algerianGreen),
                    filled: true,
                    fillColor: AppColors.algerianWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.algerianGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.algerianGreen, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value.trim());
                    if (age == null) {
                      return 'Please enter a valid age';
                    }
                    if (age < 5 || age > 120) {
                      return 'Please enter a realistic age';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Country field
                Text(
                  'Your Country',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.algerianGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(
                    hintText: 'Enter your country',
                    prefixIcon: const Icon(Icons.public, color: AppColors.algerianGreen),
                    filled: true,
                    fillColor: AppColors.algerianWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.algerianGreen),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.algerianGreen, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your country';
                    }
                    if (value.trim().length < 2) {
                      return 'Country name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Privacy note
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.tealAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.tealAccent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.privacy_tip,
                        color: AppColors.tealAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Your information is stored locally on your device and is not shared with anyone.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Continue button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveUserInfo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.algerianGreen,
                      foregroundColor: AppColors.algerianWhite,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.algerianWhite,
                              strokeWidth: 2,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 24),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // Demo user button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : _createDemoUser,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.algerianRed,
                      side: const BorderSide(color: AppColors.algerianRed, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flash_on, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Quick Demo Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Demo user info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.algerianRed.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.algerianRed.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.algerianRed,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Demo user: Ahmed (25, Algeria) with sample progress',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.algerianRed,
                          ),
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
    );
  }
}
