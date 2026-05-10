import 'dart:math';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _enterApp(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _openPrivacy(BuildContext context) {}
  void _openTerms(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ink,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 0.72, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.10),
                    Colors.black.withValues(alpha: 0.60),
                    Colors.black.withValues(alpha: 0.82),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                const SizedBox(height: 430),

                // Glowing tagline
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Beat the stress. Not people.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.3,
                        color: Colors.transparent,
                        shadows: [
                          Shadow(
                            color: const Color(0xFFFF2200).withValues(alpha: 0.85),
                            blurRadius: 40,
                          ),
                          Shadow(
                            color: const Color(0xFFFF4400).withValues(alpha: 0.5),
                            blurRadius: 80,
                          ),
                        ],
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFAA66),
                          Color(0xFFDD2200),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'Beat the stress. Not people.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.6,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: const Color(0xFFFF3300).withValues(alpha: 0.9),
                              blurRadius: 14,
                            ),
                            Shadow(
                              color: const Color(0xFFFF1100).withValues(alpha: 0.6),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFFF4400).withValues(alpha: 0.28),
                            Colors.transparent,
                          ],
                          radius: 0.75,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 42),
                      child: ParchmentButton(
                        onPressed: () => _enterApp(context),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                _PrivacyTermsLinks(
                  onPrivacyTap: () => _openPrivacy(context),
                  onTermsTap: () => _openTerms(context),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Parchment Button ────────────────────────────────────────────────────────

class ParchmentButton extends StatefulWidget {
  final VoidCallback? onPressed;
  const ParchmentButton({super.key, this.onPressed});

  @override
  State<ParchmentButton> createState() => _ParchmentButtonState();
}

class _ParchmentButtonState extends State<ParchmentButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late final AnimationController _emberController;
  late final Animation<double> _emberAnimation;

  @override
  void initState() {
    super.initState();
    _emberController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _emberAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _emberController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: AnimatedBuilder(
          animation: _emberAnimation,
          builder: (context, _) {
            final ember = _pressed ? 0.3 : _emberAnimation.value;

            // Parchment colors darken and desaturate when pressed
            final parchmentColors = _pressed
                ? const [
                    Color(0xFF8C5A20), // dark pressed top
                    Color(0xFF7A4415), // darker mid
                    Color(0xFF6A3410), // deep shadow
                    Color(0xFF7A4018), // pressed bottom
                  ]
                : const [
                    Color(0xFFD4924A),
                    Color(0xFFC07832),
                    Color(0xFFAA5E1A),
                    Color(0xFFBB6E28),
                  ];

            return CustomPaint(
              painter: _BurnedEdgePainter(
                emberIntensity: ember,
                pressed: _pressed,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    // Flip gradient direction when pressed — light comes from below
                    begin: _pressed ? Alignment.bottomLeft : Alignment.topLeft,
                    end: _pressed ? Alignment.topRight : Alignment.bottomRight,
                    colors: parchmentColors,
                    stops: const [0.0, 0.35, 0.72, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    // Inner shadow overlay when pressed
                    if (_pressed)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.35),
                                Colors.black.withValues(alpha: 0.10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        // Nudge content down 2px when pressed for depth feel
                        vertical: _pressed ? 15 : 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _StampSeal(pressed: _pressed),
                          const SizedBox(width: 14),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 100),
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              // Text darkens when pressed
                              color: _pressed
                                  ? const Color(0xFF3A0D00)
                                  : const Color(0xFF5C1A00),
                              letterSpacing: 0.3,
                              shadows: _pressed
                                  ? []
                                  : [
                                      Shadow(
                                        color: const Color(0xFF3A0800)
                                            .withValues(alpha: 0.45),
                                        offset: const Offset(1, 1.5),
                                        blurRadius: 2,
                                      ),
                                    ],
                            ),
                            child: const Text('Start Releasing'),
                          ),
                          const SizedBox(width: 16),
                          _ParchmentArrow(pressed: _pressed),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Burned Edge Painter ─────────────────────────────────────────────────────

class _BurnedEdgePainter extends CustomPainter {
  final double emberIntensity;
  final bool pressed;
  final _rng = Random(42);

  _BurnedEdgePainter({required this.emberIntensity, required this.pressed});

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildRoughRect(size);

    // Outer bloom — much dimmer when pressed
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFFF4400).withValues(alpha: 0.55 * emberIntensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = pressed ? 10 : 18
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, pressed ? 6 : 14),
    );

    // Mid glow
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFFF6600).withValues(alpha: 0.65 * emberIntensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = pressed ? 4 : 8
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, pressed ? 2 : 5),
    );

    // Tight bright core — hidden when pressed
    if (!pressed)
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0xFFFFAA44).withValues(alpha: 0.75 * emberIntensity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
      );

    // Charred edge — darker when pressed
    canvas.drawPath(
      path,
      Paint()
        ..color = pressed
            ? const Color(0xFF0D0400).withValues(alpha: 0.95)
            : const Color(0xFF1A0800).withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = pressed ? 2.2 : 1.5,
    );
  }

  Path _buildRoughRect(Size size) {
    const jitter = 3.5;
    const steps = 60;
    final path = Path();
    final w = size.width;
    final h = size.height;
    double j() => (_rng.nextDouble() - 0.5) * jitter * 2;

    path.moveTo(j(), j());
    for (int i = 1; i <= steps; i++) path.lineTo((w / steps) * i + j(), j());
    for (int i = 1; i <= steps; i++) path.lineTo(w + j(), (h / steps) * i + j());
    for (int i = steps - 1; i >= 0; i--) path.lineTo((w / steps) * i + j(), h + j());
    for (int i = steps - 1; i >= 0; i--) path.lineTo(j(), (h / steps) * i + j());
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_BurnedEdgePainter old) =>
      old.emberIntensity != emberIntensity || old.pressed != pressed;
}

// ─── Stamp Seal ──────────────────────────────────────────────────────────────

class _StampSeal extends StatelessWidget {
  final bool pressed;
  const _StampSeal({required this.pressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        border: Border.all(
          color: pressed
              ? const Color(0xFF5C1000)
              : const Color(0xFF8B1A00),
          width: pressed ? 1.5 : 2,
        ),
        borderRadius: BorderRadius.circular(3),
        color: pressed
            ? const Color(0xFF5C1000).withValues(alpha: 0.25)
            : const Color(0xFF8B1A00).withValues(alpha: 0.15),
      ),
      child: Center(
        child: Text(
          '放',
          style: TextStyle(
            fontSize: 20,
            color: pressed
                ? const Color(0xFF5C1000)
                : const Color(0xFF8B1A00),
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

// ─── Parchment Arrow ─────────────────────────────────────────────────────────

class _ParchmentArrow extends StatelessWidget {
  final bool pressed;
  const _ParchmentArrow({required this.pressed});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(34, 18),
      painter: _ArrowPainter(
        color: pressed ? const Color(0xFF3A0D00) : const Color(0xFF5C1A00),
        strokeWidth: pressed ? 1.8 : 2.2,
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  const _ArrowPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final double cy = size.height / 2;
    final double headW = size.width * 0.36;
    final double shaftEnd = size.width - headW * 0.82;

    final path = Path()
      ..moveTo(strokeWidth / 2, cy)
      ..lineTo(shaftEnd, cy)
      ..moveTo(size.width - headW, 0)
      ..lineTo(size.width, cy)
      ..lineTo(size.width - headW, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}

// ─── Footer ───────────────────────────────────────────────────────────────────

class _PrivacyTermsLinks extends StatelessWidget {
  final VoidCallback onPrivacyTap;
  final VoidCallback onTermsTap;
  const _PrivacyTermsLinks({
    required this.onPrivacyTap,
    required this.onTermsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'No login. No judgment. Nothing saved.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.muted.withValues(alpha: 0.80),
            fontSize: 13,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink(label: 'Privacy', onTap: onPrivacyTap),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '·',
                style: TextStyle(
                  color: AppTheme.muted.withValues(alpha: 0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _FooterLink(label: 'Terms', onTap: onTermsTap),
          ],
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: AppTheme.muted.withValues(alpha: 0.80),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: AppTheme.muted.withValues(alpha: 0.35),
          ),
        ),
      ),
    );
  }
}