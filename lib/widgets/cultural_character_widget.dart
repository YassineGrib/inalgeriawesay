import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/cultural_character.dart';

class CulturalCharacterWidget extends StatefulWidget {
  final CulturalCharacter character;
  final String? message;
  final String language;
  final bool showGreeting;
  final bool isAnimated;
  final VoidCallback? onTap;

  const CulturalCharacterWidget({
    super.key,
    required this.character,
    this.message,
    this.language = 'english',
    this.showGreeting = false,
    this.isAnimated = true,
    this.onTap,
  });

  @override
  State<CulturalCharacterWidget> createState() => _CulturalCharacterWidgetState();
}

class _CulturalCharacterWidgetState extends State<CulturalCharacterWidget>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _fadeController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    if (widget.isAnimated) {
      _bounceController = AnimationController(
        duration: const Duration(milliseconds: 1200),
        vsync: this,
      );
      
      _fadeController = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      );

      _bounceAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _bounceController,
        curve: Curves.elasticOut,
      ));

      _fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ));

      _scaleAnimation = Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _bounceController,
        curve: Curves.elasticOut,
      ));

      _fadeController.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        _bounceController.forward();
      });
    }
  }

  @override
  void dispose() {
    if (widget.isAnimated) {
      _bounceController.dispose();
      _fadeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAnimated) {
      return _buildCharacterContent();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: _buildCharacterContent(),
      ),
    );
  }

  Widget _buildCharacterContent() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.character.primaryColor.withValues(alpha: 0.1),
              widget.character.secondaryColor.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.character.primaryColor.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.character.primaryColor.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Character Avatar
            _buildCharacterAvatar(),
            
            const SizedBox(height: 12),
            
            // Character Name
            Text(
              widget.character.getNameForLanguage(widget.language),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: widget.character.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // Character Description
            Text(
              widget.character.getDescriptionForLanguage(widget.language),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Greeting or Message
            if (widget.showGreeting || widget.message != null) ...[
              const SizedBox(height: 12),
              _buildMessageBubble(),
            ],
            
            // Specialties
            if (widget.character.specialties.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildSpecialties(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterAvatar() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: widget.character.primaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.character.secondaryColor,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.character.primaryColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: widget.character.imageAsset != null
          ? ClipOval(
              child: Image.asset(
                widget.character.imageAsset!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultIcon();
                },
              ),
            )
          : _buildDefaultIcon(),
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(
      widget.character.icon,
      size: 40,
      color: AppColors.algerianWhite,
    );
  }

  Widget _buildMessageBubble() {
    final message = widget.message ?? 
        (widget.showGreeting ? widget.character.getGreeting(widget.language) : '');
    
    if (message.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.algerianWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.character.primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 16,
            color: widget.character.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialties() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: widget.character.specialties.take(3).map((specialty) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: widget.character.secondaryColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.character.secondaryColor.withValues(alpha: 0.4),
            ),
          ),
          child: Text(
            specialty,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: widget.character.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CharacterIntroductionDialog extends StatelessWidget {
  final CulturalCharacter character;
  final String language;

  const CharacterIntroductionDialog({
    super.key,
    required this.character,
    this.language = 'english',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              character.primaryColor.withValues(alpha: 0.1),
              character.secondaryColor.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Character Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: character.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: character.secondaryColor,
                  width: 4,
                ),
              ),
              child: Icon(
                character.icon,
                size: 50,
                color: AppColors.algerianWhite,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Character Name
            Text(
              character.getNameForLanguage(language),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: character.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            // Character Description
            Text(
              character.getDescriptionForLanguage(language),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Greeting
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.algerianWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: character.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                character.getGreeting(language),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Close button
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: character.primaryColor,
                foregroundColor: AppColors.algerianWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
