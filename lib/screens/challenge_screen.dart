import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/cultural_challenge.dart';
import '../services/user_service.dart';

class ChallengeScreen extends StatefulWidget {
  final CulturalChallenge challenge;
  final String language;

  const ChallengeScreen({
    super.key,
    required this.challenge,
    this.language = 'english',
  });

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final UserService _userService = UserService();
  final TextEditingController _textController = TextEditingController();
  
  String? _selectedOptionId;
  bool _isSubmitted = false;
  bool _isCorrect = false;
  String? _userAnswer;

  @override
  void dispose() {
    _textController.dispose();
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

  String _getChallengeQuestion() {
    switch (widget.language.toLowerCase()) {
      case 'arabic':
        return widget.challenge.questionArabic;
      case 'amazigh':
        return widget.challenge.questionAmazigh;
      default:
        return widget.challenge.question;
    }
  }

  String _getChallengeExplanation() {
    switch (widget.language.toLowerCase()) {
      case 'arabic':
        return widget.challenge.explanationArabic ?? widget.challenge.explanation ?? '';
      case 'amazigh':
        return widget.challenge.explanationAmazigh ?? widget.challenge.explanation ?? '';
      default:
        return widget.challenge.explanation ?? '';
    }
  }

  void _submitAnswer() {
    setState(() {
      _isSubmitted = true;
      
      if (widget.challenge.type == ChallengeType.multipleChoice) {
        final selectedOption = widget.challenge.options?.firstWhere(
          (option) => option.id == _selectedOptionId,
          orElse: () => widget.challenge.options!.first,
        );
        _isCorrect = selectedOption?.isCorrect ?? false;
        _userAnswer = selectedOption?.text ?? '';
      } else if (widget.challenge.type == ChallengeType.textInput) {
        final userText = _textController.text.trim().toLowerCase();
        final correctAnswer = widget.challenge.correctAnswer?.toLowerCase() ?? '';
        _isCorrect = userText == correctAnswer || 
                    correctAnswer.contains(userText) ||
                    userText.contains(correctAnswer);
        _userAnswer = _textController.text.trim();
      } else {
        // For scenario and audio response, we'll consider them correct for now
        _isCorrect = true;
        _userAnswer = _textController.text.trim();
      }
    });

    if (_isCorrect) {
      _awardPoints();
    }
  }

  Future<void> _awardPoints() async {
    try {
      await _userService.addCompletedChallenge(
        widget.challenge.id,
        widget.challenge.points,
      );
    } catch (e) {
      // Handle error silently
    }
  }

  void _retryChallenge() {
    setState(() {
      _isSubmitted = false;
      _isCorrect = false;
      _selectedOptionId = null;
      _userAnswer = null;
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(_getChallengeTitle()),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Challenge info header
            _buildChallengeHeader(),
            
            const SizedBox(height: 24),
            
            // Question
            _buildQuestionSection(),
            
            const SizedBox(height: 24),
            
            // Answer input
            _buildAnswerSection(),
            
            const SizedBox(height: 24),
            
            // Submit/Retry button
            _buildActionButton(),
            
            // Results section
            if (_isSubmitted) ...[
              const SizedBox(height: 24),
              _buildResultsSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.algerianGreen.withValues(alpha: 0.1),
            AppColors.algerianRed.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.algerianGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getTypeIcon(),
                color: AppColors.algerianGreen,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                _getTypeLabel(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.algerianGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.goldAccent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.stars,
                      size: 16,
                      color: AppColors.goldAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.challenge.points} points',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.goldAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.challenge.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.algerianWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.algerianGreen.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.algerianGreen.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline,
                color: AppColors.algerianGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Question',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.algerianGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getChallengeQuestion(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerSection() {
    if (_isSubmitted) {
      return const SizedBox.shrink();
    }

    switch (widget.challenge.type) {
      case ChallengeType.multipleChoice:
        return _buildMultipleChoiceOptions();
      case ChallengeType.textInput:
      case ChallengeType.scenario:
        return _buildTextInput();
      case ChallengeType.audioResponse:
        return _buildAudioResponse();
    }
  }

  Widget _buildMultipleChoiceOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose the correct answer:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.algerianGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...widget.challenge.options!.map((option) {
          final isSelected = _selectedOptionId == option.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOptionId = option.id;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.algerianGreen.withValues(alpha: 0.1)
                      : AppColors.algerianWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.algerianGreen 
                        : AppColors.textSecondary.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected 
                              ? AppColors.algerianGreen 
                              : AppColors.textSecondary,
                          width: 2,
                        ),
                        color: isSelected 
                            ? AppColors.algerianGreen 
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 12,
                              color: AppColors.algerianWhite,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option.text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTextInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type your answer:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.algerianGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _textController,
          maxLines: widget.challenge.type == ChallengeType.scenario ? 4 : 1,
          decoration: InputDecoration(
            hintText: widget.challenge.type == ChallengeType.scenario
                ? 'Describe what you would do...'
                : 'Enter your answer...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.algerianGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.algerianGreen, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioResponse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Record your response:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.algerianGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.algerianWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.algerianGreen),
          ),
          child: Column(
            children: [
              Icon(
                Icons.mic,
                size: 48,
                color: AppColors.algerianGreen,
              ),
              const SizedBox(height: 12),
              Text(
                'Audio recording feature coming soon!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Placeholder for audio recording
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Audio recording will be implemented later'),
                    ),
                  );
                },
                icon: const Icon(Icons.mic),
                label: const Text('Start Recording'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.algerianGreen,
                  foregroundColor: AppColors.algerianWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    if (_isSubmitted) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _retryChallenge,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.algerianGreen,
                side: const BorderSide(color: AppColors.algerianGreen),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Try Again'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.algerianGreen,
                foregroundColor: AppColors.algerianWhite,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      );
    }

    final canSubmit = widget.challenge.type == ChallengeType.multipleChoice
        ? _selectedOptionId != null
        : _textController.text.trim().isNotEmpty;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canSubmit ? _submitAnswer : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.algerianRed,
          foregroundColor: AppColors.algerianWhite,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Submit Answer',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isCorrect 
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isCorrect 
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isCorrect ? Icons.check_circle : Icons.cancel,
                color: _isCorrect ? AppColors.success : AppColors.error,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                _isCorrect ? 'Correct!' : 'Incorrect',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _isCorrect ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_isCorrect) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.goldAccent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.stars,
                        size: 16,
                        color: AppColors.goldAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '+${widget.challenge.points}',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.goldAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          if (_getChallengeExplanation().isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              _getChallengeExplanation(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
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
}
