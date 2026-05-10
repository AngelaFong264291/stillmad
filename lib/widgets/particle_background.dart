import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stillmad/core/theme/app_theme.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({required this.child, super.key});

  final Widget child;

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(progress: _controller.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _ParticlePainter extends CustomPainter {
  const _ParticlePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < 42; i++) {
      final seed = i * 37.17;
      final x = (sin(seed) * 0.5 + 0.5) * size.width;
      final drift = sin((progress * pi * 2) + seed) * 16;
      final y = ((cos(seed * 1.7) * 0.5 + 0.5 + progress) % 1) * size.height;
      final radius = 1.4 + (i % 5) * 0.55;
      final color = switch (i % 4) {
        0 => AppTheme.neonRed,
        1 => AppTheme.ember,
        2 => AppTheme.ink,
        _ => AppTheme.ember,
      };

      paint.color = color.withValues(alpha: 0.10 + (i % 3) * 0.035);
      canvas.drawCircle(Offset(x + drift, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
