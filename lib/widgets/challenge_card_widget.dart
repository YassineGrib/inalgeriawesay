import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/cultural_challenge.dart';

class ChallengeCardWidget extends StatefulWidget {
  final CulturalChallenge challenge;
  final String language;
  final bool isCompleted;
  final VoidCallback? onTap;

  const ChallengeCardWidget({
    super.key,
    required this.challenge,
    this.language = 'english',
    this.isCompleted = false,
    this.onTap,
  });

  @override
  State<ChallengeCardWidget> createState() => _ChallengeCardWidgetState();
}

class _ChallengeCardWidgetState extends State<ChallengeCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

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

  String _getChallengeTitle() {
    switch (widget.language.toLowerCase()) {
      case 'arabic':
        return widget.challenge.titleArabic;
      case 'amazigh':
        return widget.challenge.titleAmazigh;
      default:
        return widget.challenge.title;
    }
  }

  String _getChallengeDescription() {
    switch (widget.language.toLowerCase()) {
      case 'arabic':
        return widget.challenge.descriptionArabic;
      case 'amazigh':
        return widget.challenge.descriptionAmazigh;
      default:
        return widget.challenge.description;
    }
  }

  Color _getTypeColor() {
    switch (widget.challenge.type) {
      case ChallengeType.multipleChoice:
        return AppColors.algerianGreen;
      case ChallengeType.textInput:
        return AppColors.algerianRed;
      case ChallengeType.scenario:
        return AppColors.goldAccent;
      case ChallengeType.audioResponse:
        return AppColors.desertOrange;
    }
  }

  IconData _getTypeIcon() {
    switch (widget.challenge.type) {
      case ChallengeType.multipleChoice:
        return Icons.quiz;
      case ChallengeType.textInput:
        return Icons.edit;
      case ChallengeType.scenario:
        return Icons.theater_comedy;
      case ChallengeType.audioResponse:
        return Icons.mic;
    }
  }

  String _getTypeLabel() {
    switch (widget.challenge.type) {
      case ChallengeType.multipleChoice:
        return 'Multiple Choice';
      case ChallengeType.textInput:
        return 'Text Input';
      case ChallengeType.scenario:
        return 'Scenario';
      case ChallengeType.audioResponse:
        return 'Audio Response';
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor();
    
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Card(
            elevation: widget.isCompleted ? 2 : 6,
            shadowColor: typeColor.withValues(alpha: 0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isCompleted
                      ? [
                          AppColors.success.withValues(alpha: 0.1),
                          AppColors.success.withValues(alpha: 0.05),
                        ]
                      : [
                          AppColors.algerianWhite,
                          typeColor.withValues(alpha: 0.05),
                        ],
                ),
                border: widget.isCompleted
                    ? Border.all(
                        color: AppColors.success.withValues(alpha: 0.3),
                        width: 2,
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with type and completion status
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: typeColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: typeColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getTypeIcon(),
                                size: 14,
                                color: typeColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _getTypeLabel(),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: typeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        if (widget.isCompleted)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 16,
                              color: AppColors.algerianWhite,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Challenge title
                    Text(
                      _getChallengeTitle(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: widget.isCompleted 
                            ? AppColors.success 
                            : typeColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Challenge description
                    Expanded(
                      child: Text(
                        _getChallengeDescription(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Points and tags
                    Row(
                      children: [
                        // Points
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.goldAccent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.goldAccent.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.stars,
                                size: 14,
                                color: AppColors.goldAccent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.challenge.points} pts',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.goldAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // Primary tag
                        if (widget.challenge.tags != null && widget.challenge.tags!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.textSecondary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.challenge.tags!.first,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Action button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.isCompleted 
                              ? AppColors.success 
                              : typeColor,
                          foregroundColor: AppColors.algerianWhite,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.isCompleted ? 'Review' : 'Start Challenge',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              widget.isCompleted ? Icons.replay : Icons.play_arrow,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
