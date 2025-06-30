import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/conversation_category.dart';
import 'conversation_subcategories_screen.dart';

class ConversationCategoriesScreen extends StatefulWidget {
  const ConversationCategoriesScreen({super.key});

  @override
  State<ConversationCategoriesScreen> createState() => _ConversationCategoriesScreenState();
}

class _ConversationCategoriesScreenState extends State<ConversationCategoriesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ConversationCategories.getAllCategories();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Conversation Categories'),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.algerianGreen.withValues(alpha: 0.1),
                      AppColors.backgroundLight,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.category,
                      size: 48,
                      color: AppColors.algerianGreen,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Choose a Category',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.algerianGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'فئات المحادثات',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.algerianRed,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select a conversation category to explore different scenarios and practice your Algerian dialect skills',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Categories Grid
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = categories[index];
                    return _buildCategoryCard(category, index);
                  },
                  childCount: categories.length,
                ),
              ),
            ),

            // Bottom spacing for floating nav
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(ConversationCategory category, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConversationSubcategoriesScreen(
                category: category,
              ),
            ),
          );
        },
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  category.color.withValues(alpha: 0.1),
                  category.color.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with background
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: category.color.withValues(alpha: 0.2),
                      border: Border.all(
                        color: category.color.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      category.icon,
                      size: 28,
                      color: category.color,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // English Title
                  Text(
                    category.titleEn,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: category.color,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 3),

                  // Arabic Title
                  Text(
                    category.titleAr,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Subcategories count
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: category.color.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${category.subcategories.length} topics',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: category.color,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Description
                  Expanded(
                    child: Text(
                      category.description,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
