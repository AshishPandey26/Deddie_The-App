import 'package:flutter/material.dart';
import '../theme/kawaii_theme.dart';

class KawaiiButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? color;

  const KawaiiButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
  });

  @override
  State<KawaiiButton> createState() => _KawaiiButtonState();
}

class _KawaiiButtonState extends State<KawaiiButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color ?? KawaiiTheme.primaryPink,
            borderRadius: BorderRadius.circular(20),
            boxShadow: KawaiiTheme.cuteShadow,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: widget.child,
        ),
      ),
    );
  }
}

class KawaiiCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const KawaiiCard({super.key, required this.child, this.onTap});

  @override
  State<KawaiiCard> createState() => _KawaiiCardState();
}

class _KawaiiCardState extends State<KawaiiCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _controller.forward() : null,
      onTapUp:
          widget.onTap != null
              ? (_) {
                _controller.reverse();
                widget.onTap!();
              }
              : null,
      onTapCancel: widget.onTap != null ? () => _controller.reverse() : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: KawaiiTheme.cardDecoration,
          child: widget.child,
        ),
      ),
    );
  }
}

class KawaiiCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const KawaiiCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: value ? KawaiiTheme.primaryPink : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: KawaiiTheme.primaryPink, width: 2),
          boxShadow: value ? KawaiiTheme.cuteShadow : null,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.check,
          size: 20,
          color: value ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }
}

class KawaiiEmoji extends StatelessWidget {
  final String emoji;
  final double size;

  const KawaiiEmoji({super.key, required this.emoji, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Text(emoji, style: TextStyle(fontSize: size));
  }
}
