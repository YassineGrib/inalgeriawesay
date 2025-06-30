import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/dialogue_line.dart';

class DialogueLineWidget extends StatefulWidget {
  final DialogueLine dialogueLine;
  final bool isUserLine;
  final VoidCallback? onTap;
  final bool showTranslation;
  final bool showCulturalNote;

  const DialogueLineWidget({
    super.key,
    required this.dialogueLine,
    required this.isUserLine,
    this.onTap,
    this.showTranslation = true,
    this.showCulturalNote = true,
  });

  @override
  State<DialogueLineWidget> createState() => _DialogueLineWidgetState();
}

class _DialogueLineWidgetState extends State<DialogueLineWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: widget.isUserLine ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          onTap: widget.onTap ?? _toggleExpansion,
          child: Container(
            margin: EdgeInsets.only(
              left: widget.isUserLine ? 60 : 0,
              right: widget.isUserLine ? 0 : 60,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: widget.isUserLine
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isUserLine) ...[
                  _buildCharacterAvatar(),
                  const SizedBox(width: 12),
                ],
                Flexible(
                  child: _buildMessageBubble(),
                ),
                if (widget.isUserLine) ...[
                  const SizedBox(width: 12),
                  _buildCharacterAvatar(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterAvatar() {
    final character = widget.dialogueLine.character.toLowerCase();
    final isPersonA = character.contains('person_a') || character.contains('tourist') || character.contains('customer') || character.contains('visitor') || character.contains('sam');

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPersonA
            ? [const Color(0xFF2196F3), const Color(0xFF1976D2)] // Blue gradient for person A
            : [const Color(0xFF4CAF50), const Color(0xFF388E3C)], // Green gradient for person B
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isPersonA
              ? const Color(0xFF2196F3).withValues(alpha: 0.4)
              : const Color(0xFF4CAF50).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        isPersonA ? Icons.person : _getCharacterIcon(),
        color: Colors.white,
        size: 20,
      ),
    );
  }

  IconData _getCharacterIcon() {
    final character = widget.dialogueLine.character.toLowerCase();
    if (character.contains('vendor') || character.contains('seller')) {
      return Icons.store;
    } else if (character.contains('waiter') || character.contains('server')) {
      return Icons.restaurant;
    } else if (character.contains('elder') || character.contains('elderly')) {
      return Icons.elderly;
    } else if (character.contains('guide') || character.contains('teacher')) {
      return Icons.school;
    } else if (character.contains('officer') || character.contains('official')) {
      return Icons.badge;
    }
    return Icons.person_outline;
  }

  Widget _buildMessageBubble() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.isUserLine
              ? [const Color(0xFF2196F3), const Color(0xFF1E88E5)] // Blue gradient for user
              : [Colors.white, const Color(0xFFF5F5F5)], // Light gradient for other
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: widget.isUserLine
              ? const Radius.circular(20)
              : const Radius.circular(4),
          bottomRight: widget.isUserLine
              ? const Radius.circular(4)
              : const Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.isUserLine
                ? const Color(0xFF2196F3).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Character name
          if (!widget.isUserLine) ...[
            Text(
              _getCharacterDisplayName(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: const Color(0xFF4CAF50),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Original text (Arabic/Amazigh)
          Text(
            widget.dialogueLine.text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: widget.isUserLine ? Colors.white : const Color(0xFF212121),
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            textDirection: _getTextDirection(),
          ),

          // Translation
          if (widget.showTranslation) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.isUserLine
                  ? Colors.white.withValues(alpha: 0.2)
                  : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.isUserLine
                    ? Colors.white.withValues(alpha: 0.3)
                    : const Color(0xFFE9ECEF),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.translate,
                    size: 16,
                    color: widget.isUserLine
                      ? Colors.white.withValues(alpha: 0.8)
                      : const Color(0xFF6C757D),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.dialogueLine.translation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.isUserLine
                          ? Colors.white.withValues(alpha: 0.9)
                          : const Color(0xFF6C757D),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Cultural note (expandable)
          if (widget.showCulturalNote &&
              widget.dialogueLine.culturalNote != null &&
              widget.dialogueLine.culturalNote!.isNotEmpty) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _toggleExpansion,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.goldAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.goldAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 16,
                          color: AppColors.goldAccent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Cultural Note',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.goldAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 16,
                          color: AppColors.goldAccent,
                        ),
                      ],
                    ),
                    if (_isExpanded) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.dialogueLine.culturalNote!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],

          // Audio button (if audio file is available)
          if (widget.dialogueLine.audioFile != null &&
              widget.dialogueLine.audioFile!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  // TODO: Implement audio playback
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Audio playback coming soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.volume_up,
                  color: AppColors.algerianGreen,
                ),
                tooltip: 'Play pronunciation',
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getCharacterDisplayName() {
    final character = widget.dialogueLine.character;
    // Capitalize first letter and replace underscores with spaces
    return character
        .split('_')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }

  TextDirection _getTextDirection() {
    // Arabic and Amazigh text should be right-to-left
    final text = widget.dialogueLine.text;
    if (text.contains(RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]'))) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }
}
