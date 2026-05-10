import 'package:flutter/material.dart';
import 'package:stillmad/core/theme/app_theme.dart';

class NeonCard extends StatelessWidget {
  const NeonCard({
    required this.child,
    this.color = AppTheme.cyan,
    this.onTap,
    super.key,
  });

  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 28,
            spreadRadius: -12,
          ),
        ],
      ),
      child: Material(
        color: AppTheme.surfaceBright,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: color.withValues(alpha: 0.38)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
