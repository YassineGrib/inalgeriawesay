import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/scientist.dart';

class ScientistCardWidget extends StatefulWidget {
  final Scientist scientist;
  final String language;
  final VoidCallback? onTap;

  const ScientistCardWidget({
    super.key,
    required this.scientist,
    this.language = 'english',
    this.onTap,
  });

  @override
  State<ScientistCardWidget> createState() => _ScientistCardWidgetState();
}

class _ScientistCardWidgetState extends State<ScientistCardWidget>
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

  String _getScientistName() {
    switch (widget.language.toLowerCase()) {
      case 'arabic':
        return widget.scientist.nameArabic;
      case 'amazigh':
        return widget.scientist.nameAmazigh;
      default:
        return widget.scientist.name;
    }
  }

  String _getScientistBio() {
    switch (widget.language.toLowerCase()) {
      case 'arabic':
        return widget.scientist.bioArabic;
      case 'amazigh':
        return widget.scientist.bioAmazigh;
      default:
        return widget.scientist.bio;
    }
  }

  List<String> _getAchievements() {
    switch (widget.language.toLowerCase()) {
      case 'arabic':
        return widget.scientist.achievementsArabic;
      case 'amazigh':
        return widget.scientist.achievementsAmazigh;
      default:
        return widget.scientist.achievements;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Card(
            elevation: 6,
            shadowColor: AppColors.algerianGreen.withValues(alpha: 0.2),
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
                    AppColors.algerianWhite,
                    AppColors.algerianGreen.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo section
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: _buildScientistPhoto(),
                      ),
                    ),
                  ),

                  // Content section
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Name
                                      Text(
                                        _getScientistName(),
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: AppColors.algerianGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      const SizedBox(height: 2),

                                      // Field and years
                                      Text(
                                        widget.scientist.field,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.algerianRed,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      const SizedBox(height: 2),

                                      Text(
                                        _getYearRange(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.textSecondary,
                                          fontSize: 8,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      // Bio
                                      Text(
                                        _getScientistBio(),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.textSecondary,
                                          height: 1.1,
                                          fontSize: 9,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),

                                  // Read more button (compact)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: widget.onTap,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: AppColors.algerianGreen.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: AppColors.algerianGreen.withValues(alpha: 0.3),
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'More',
                                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                color: AppColors.algerianGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8,
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 8,
                                              color: AppColors.algerianGreen,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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

  Widget _buildScientistPhoto() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border.all(
          color: AppColors.algerianGreen.withValues(alpha: 0.2),
        ),
      ),
      child: widget.scientist.photoUrl.isNotEmpty
          ? Image.asset(
              'assets/images/${widget.scientist.photoUrl}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholderPhoto();
              },
            )
          : _buildPlaceholderPhoto(),
    );
  }

  Widget _buildPlaceholderPhoto() {
    return Container(
      decoration: BoxDecoration(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 48,
            color: AppColors.algerianGreen.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 8),
          Text(
            'Photo\nComing Soon',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }



  String _getYearRange() {
    final birth = widget.scientist.birthYear;
    final death = widget.scientist.deathYear;
    
    if (death != null && death.isNotEmpty) {
      return '$birth-$death';
    } else {
      return '$birth-Present';
    }
  }
}
