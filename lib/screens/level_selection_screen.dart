import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/conversation_category.dart';
import 'category_selection_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Choose Your Level'),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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
                    Icons.school,
                    size: 48,
                    color: AppColors.algerianGreen,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select Your Learning Level',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.algerianGreen,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start with basic interactions and progress to advanced cultural conversations',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Level Cards
            ...ConversationCategories.availableLevels.map((level) {
              final categories = ConversationCategories.getCategoriesByLevel(level);
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildLevelCard(context, level, categories),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, int level, List<ConversationCategory> categories) {
    final levelTitle = ConversationCategories.getLevelTitle(level);
    final levelColor = _getLevelColor(level);
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategorySelectionScreen(level: level),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                levelColor.withValues(alpha: 0.1),
                levelColor.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: levelColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getLevelIcon(level),
                      color: AppColors.algerianWhite,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          levelTitle,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: levelColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${categories.length} categories available',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: levelColor,
                    size: 20,
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Category preview
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((category) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: category.color.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category.icon,
                          size: 16,
                          color: category.color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category.titleEn,
                          style: TextStyle(
                            color: category.color,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return AppColors.algerianGreen;
      case 2:
        return AppColors.algerianRed;
      case 3:
        return AppColors.tealAccent;
      case 4:
        return const Color(0xFF9C27B0); // Purple
      case 5:
        return const Color(0xFF3F51B5); // Indigo
      default:
        return AppColors.algerianGreen;
    }
  }

  IconData _getLevelIcon(int level) {
    switch (level) {
      case 1:
        return Icons.star_border;
      case 2:
        return Icons.star_half;
      case 3:
        return Icons.star;
      case 4:
        return Icons.stars;
      case 5:
        return Icons.auto_awesome;
      default:
        return Icons.star;
    }
  }
}
