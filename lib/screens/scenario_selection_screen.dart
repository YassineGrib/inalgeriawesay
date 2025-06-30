import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/conversation_category.dart';
import 'conversation_selection_screen.dart';

class ScenarioSelectionScreen extends StatelessWidget {
  final ConversationCategory category;

  const ScenarioSelectionScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(category.titleAr),
        backgroundColor: category.color,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      category.color,
                      category.color.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          category.icon,
                          color: AppColors.algerianWhite,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.titleAr,
                                style: const TextStyle(
                                  color: AppColors.algerianWhite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category.description,
                                style: TextStyle(
                                  color: AppColors.algerianWhite.withValues(alpha: 0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Scenarios title
              Text(
                'اختر السيناريو:',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Scenarios list
              Expanded(
                child: ListView.builder(
                  itemCount: category.subcategories.length,
                  itemBuilder: (context, index) {
                    final scenario = category.subcategories[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildScenarioCard(context, scenario),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScenarioCard(BuildContext context, ConversationSubcategory scenario) {
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
              builder: (context) => ConversationSelectionScreen(
                subcategory: scenario,
                categoryTitle: scenario.titleAr,
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
                AppColors.algerianWhite,
                AppColors.algerianWhite.withValues(alpha: 0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  scenario.icon,
                  color: category.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenario.titleAr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      scenario.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      scenario.scenario,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.8),
                        fontStyle: FontStyle.italic,
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
        ),
      ),
    );
  }
}
