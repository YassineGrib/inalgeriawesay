import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/dialogue.dart';
import '../widgets/dialogue_line_widget.dart';
import '../widgets/dialogue_progress_widget.dart';
import '../services/user_service.dart';

class DialogueScreen extends StatefulWidget {
  final Dialogue dialogue;

  const DialogueScreen({
    super.key,
    required this.dialogue,
  });

  @override
  State<DialogueScreen> createState() => _DialogueScreenState();
}

class _DialogueScreenState extends State<DialogueScreen> {
  final UserService _userService = UserService();
  final ScrollController _scrollController = ScrollController();

  int _currentLineIndex = 0;
  bool _showTranslations = true;
  bool _showCulturalNotes = true;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _goToNextLine() {
    if (_currentLineIndex < widget.dialogue.dialogue.length - 1) {
      setState(() {
        _currentLineIndex++;
      });
      _scrollToCurrentLine();
    } else if (!_isCompleted) {
      _completeDialogue();
    }
  }

  void _goToPreviousLine() {
    if (_currentLineIndex > 0) {
      setState(() {
        _currentLineIndex--;
      });
      _scrollToCurrentLine();
    }
  }

  void _scrollToCurrentLine() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _completeDialogue() async {
    setState(() {
      _isCompleted = true;
    });

    try {
      await _userService.addCompletedDialogue(widget.dialogue.id);
      await _userService.addPoints(10); // Award points for completion
    } catch (e) {
      // Handle error silently
    }

    if (mounted) {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.celebration,
              color: AppColors.goldAccent,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text('Congratulations!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have successfully completed the dialogue:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '"${widget.dialogue.title}"',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.algerianGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.goldAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.goldAccent.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.stars,
                    color: AppColors.goldAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '+10 Points Earned!',
                    style: TextStyle(
                      color: AppColors.goldAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to selection
            },
            child: const Text('Continue Learning'),
          ),
        ],
      ),
    );
  }

  void _toggleTranslations() {
    setState(() {
      _showTranslations = !_showTranslations;
    });
  }

  void _toggleCulturalNotes() {
    setState(() {
      _showCulturalNotes = !_showCulturalNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLine = _currentLineIndex < widget.dialogue.dialogue.length
        ? widget.dialogue.dialogue[_currentLineIndex]
        : null;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(widget.dialogue.title),
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.algerianWhite,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings),
            onSelected: (value) {
              switch (value) {
                case 'translations':
                  _toggleTranslations();
                  break;
                case 'cultural_notes':
                  _toggleCulturalNotes();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'translations',
                child: Row(
                  children: [
                    Icon(
                      _showTranslations ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.algerianGreen,
                    ),
                    const SizedBox(width: 8),
                    Text(_showTranslations ? 'Hide Translations' : 'Show Translations'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'cultural_notes',
                child: Row(
                  children: [
                    Icon(
                      _showCulturalNotes ? Icons.lightbulb : Icons.lightbulb_outline,
                      color: AppColors.goldAccent,
                    ),
                    const SizedBox(width: 8),
                    Text(_showCulturalNotes ? 'Hide Cultural Notes' : 'Show Cultural Notes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Dialogue info header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.algerianWhite,
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
                Text(
                  widget.dialogue.scenario,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildInfoChip(
                      widget.dialogue.level.name.toUpperCase(),
                      AppColors.algerianGreen,
                      Icons.star,
                    ),
                    _buildInfoChip(
                      widget.dialogue.language.name.toUpperCase(),
                      AppColors.algerianRed,
                      Icons.language,
                    ),
                    if (widget.dialogue.region != null)
                      _buildInfoChip(
                        widget.dialogue.region!.name.toUpperCase(),
                        AppColors.goldAccent,
                        Icons.location_on,
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Dialogue content
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _currentLineIndex + 1,
              itemBuilder: (context, index) {
                final line = widget.dialogue.dialogue[index];
                final character = line.character.toLowerCase();
                final isUserLine = character.contains('person_a') ||
                                   character.contains('tourist') ||
                                   character.contains('customer') ||
                                   character.contains('visitor') ||
                                   character.contains('sam');

                return DialogueLineWidget(
                  dialogueLine: line,
                  isUserLine: isUserLine,
                  showTranslation: _showTranslations,
                  showCulturalNote: _showCulturalNotes,
                );
              },
            ),
          ),

          // Progress and navigation
          DialogueProgressWidget(
            currentStep: _currentLineIndex + 1,
            totalSteps: widget.dialogue.dialogue.length,
            currentSpeaker: currentLine?.character,
            onPrevious: _currentLineIndex > 0 ? _goToPreviousLine : null,
            onNext: _goToNextLine,
            canGoPrevious: _currentLineIndex > 0,
            canGoNext: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
