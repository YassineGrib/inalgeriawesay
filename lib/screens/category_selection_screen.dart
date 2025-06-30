import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/conversation_category.dart';
import 'scenario_selection_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  final int level;

  const CategorySelectionScreen({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ConversationCategories.getCategoriesByLevel(level);
    final levelTitle = ConversationCategories.getLevelTitle(level);
    final levelColor = _getLevelColor(level);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(levelTitle),
        backgroundColor: levelColor,
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
                    levelColor.withValues(alpha: 0.1),
                    levelColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: levelColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _getLevelIcon(level),
                    size: 48,
                    color: levelColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Choose a Category',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: levelColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select a conversation category to practice',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Category Cards
            ...categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildCategoryCard(context, category),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, ConversationCategory category) {
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
              builder: (context) => ScenarioSelectionScreen(
                category: category,
              ),
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
                category.color.withValues(alpha: 0.1),
                category.color.withValues(alpha: 0.05),
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
                      color: category.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      category.icon,
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
                          category.titleEn,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: category.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.titleAr,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: category.color,
                    size: 20,
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Text(
                category.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Subcategories preview
              Text(
                'Scenarios (${category.subcategories.length}):',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: category.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.subcategories.map((subcategory) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: category.color.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          subcategory.icon,
                          size: 14,
                          color: category.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          subcategory.titleEn,
                          style: TextStyle(
                            color: category.color,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
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
