import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/conversation_category.dart';
import '../services/data_service.dart';
import 'conversation_selection_screen.dart';
import 'dialogue_screen.dart';

class ConversationSubcategoriesScreen extends StatefulWidget {
  final ConversationCategory category;

  const ConversationSubcategoriesScreen({
    super.key,
    required this.category,
  });

  @override
  State<ConversationSubcategoriesScreen> createState() => _ConversationSubcategoriesScreenState();
}

class _ConversationSubcategoriesScreenState extends State<ConversationSubcategoriesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final DataService _dataService = DataService();

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

  Future<void> _startConversation(ConversationSubcategory subcategory) async {
    // Always go to conversation selection screen to allow filtering
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConversationSelectionScreen(
            subcategory: subcategory,
            categoryTitle: subcategory.titleEn,
          ),
        ),
      );
    }
  }

  Future<void> _startRandomConversation(ConversationSubcategory subcategory) async {
    try {
      // Try to find a dialogue that matches the subcategory tags
      final dialogues = await _dataService.getDialogues(tags: subcategory.tags);

      if (dialogues.isNotEmpty) {
        // Get a random dialogue from the matching ones
        dialogues.shuffle();
        final selectedDialogue = dialogues.first;

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DialogueScreen(dialogue: selectedDialogue),
            ),
          );
        }
      } else {
        // If no specific dialogue found, go to conversation selection with filters
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConversationSelectionScreen(
                subcategory: subcategory,
                categoryTitle: subcategory.titleEn,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading conversations: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(widget.category.titleEn),
        backgroundColor: widget.category.color,
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
                      widget.category.color.withValues(alpha: 0.1),
                      AppColors.backgroundLight,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.category.color.withValues(alpha: 0.2),
                        border: Border.all(
                          color: widget.category.color.withValues(alpha: 0.4),
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        widget.category.icon,
                        size: 40,
                        color: widget.category.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.category.titleEn,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: widget.category.color,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.category.titleAr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.algerianRed,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.category.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Subcategories List
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final subcategory = widget.category.subcategories[index];
                    return _buildSubcategoryCard(subcategory, index);
                  },
                  childCount: widget.category.subcategories.length,
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

  Widget _buildSubcategoryCard(ConversationSubcategory subcategory, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.category.color.withValues(alpha: 0.05),
                    AppColors.backgroundLight,
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.category.color.withValues(alpha: 0.1),
                      border: Border.all(
                        color: widget.category.color.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      subcategory.icon,
                      size: 24,
                      color: widget.category.color,
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // English Title
                        Text(
                          subcategory.titleEn,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.category.color,
                          ),
                        ),
                        
                        const SizedBox(height: 4),
                        
                        // Arabic Title
                        Text(
                          subcategory.titleAr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.algerianRed,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Description
                        Text(
                          subcategory.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Scenario
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: widget.category.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Scenario: ${subcategory.scenario}',
                            style: TextStyle(
                              fontSize: 11,
                              color: widget.category.color,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Action Buttons
                        Row(
                          children: [
                            // Choose Options Button
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _startConversation(subcategory),
                                icon: Icon(
                                  Icons.tune,
                                  size: 16,
                                  color: widget.category.color,
                                ),
                                label: const Text(
                                  'Choose Options',
                                  style: TextStyle(fontSize: 12),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.category.color.withValues(alpha: 0.1),
                                  foregroundColor: widget.category.color,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: widget.category.color.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Quick Start Button
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _startRandomConversation(subcategory),
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 16,
                                  color: AppColors.algerianWhite,
                                ),
                                label: const Text(
                                  'Quick Start',
                                  style: TextStyle(fontSize: 12),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.category.color,
                                  foregroundColor: AppColors.algerianWhite,
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
