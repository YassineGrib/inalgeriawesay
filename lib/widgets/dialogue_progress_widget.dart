import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class DialogueProgressWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String? currentSpeaker;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool canGoNext;
  final bool canGoPrevious;

  const DialogueProgressWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.currentSpeaker,
    this.onPrevious,
    this.onNext,
    this.canGoNext = true,
    this.canGoPrevious = true,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalSteps > 0 ? currentStep / totalSteps : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.algerianWhite,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.algerianGreen.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          Row(
            children: [
              Text(
                'Progress',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.backgroundLight,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.algerianGreen,
                  ),
                  minHeight: 6,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$currentStep/$totalSteps',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Current speaker indicator
          if (currentSpeaker != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.algerianGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.algerianGreen.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getSpeakerIcon(currentSpeaker!),
                    size: 16,
                    color: AppColors.algerianGreen,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getSpeakerDisplayName(currentSpeaker!),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.algerianGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Navigation buttons
          Row(
            children: [
              // Previous button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: canGoPrevious ? onPrevious : null,
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Previous'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: canGoPrevious
                        ? AppColors.algerianGreen
                        : AppColors.textSecondary,
                    side: BorderSide(
                      color: canGoPrevious
                          ? AppColors.algerianGreen
                          : AppColors.textSecondary,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Next button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: canGoNext ? onNext : null,
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  label: Text(currentStep >= totalSteps ? 'Finish' : 'Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: canGoNext
                        ? AppColors.algerianGreen
                        : AppColors.textSecondary,
                    foregroundColor: AppColors.algerianWhite,
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
    );
  }

  IconData _getSpeakerIcon(String speaker) {
    final speakerLower = speaker.toLowerCase();
    if (speakerLower == 'user') {
      return Icons.person;
    } else if (speakerLower.contains('vendor') || speakerLower.contains('seller')) {
      return Icons.store;
    } else if (speakerLower.contains('waiter') || speakerLower.contains('server')) {
      return Icons.restaurant;
    } else if (speakerLower.contains('elder') || speakerLower.contains('elderly')) {
      return Icons.elderly;
    } else if (speakerLower.contains('guide') || speakerLower.contains('teacher')) {
      return Icons.school;
    } else if (speakerLower.contains('officer') || speakerLower.contains('official')) {
      return Icons.badge;
    }
    return Icons.person_outline;
  }

  String _getSpeakerDisplayName(String speaker) {
    return speaker
        .split('_')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }
}
