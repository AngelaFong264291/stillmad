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
    final mq = MediaQuery.of(context);
    final sw = mq.size.width;
    final sf = (sw / 390).clamp(0.8, 1.3);

    return Scaffold(
      backgroundColor: AppTheme.ink,
      body: Stack(
        children: [
          Positioned(
            top: 47, // ← tweak this to push bg lower
            left: 0,
            right: 0,
            bottom: -30, // ← keep same number as top (negative)
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final ah =
                    constraints.maxHeight; // available height inside SafeArea

                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: ah),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Tagline
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: sw * 0.08),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                'Beat the stress. Not people.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 12 * sf,
                                  letterSpacing: 1.3,
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                      color: const Color(
                                        0xFFFF2200,
                                      ).withValues(alpha: 0.85),
                                      blurRadius: 40,
                                    ),
                                    Shadow(
                                      color: const Color(
                                        0xFFFF4400,
                                      ).withValues(alpha: 0.5),
                                      blurRadius: 80,
                                    ),
                                  ],
                                ),
                              ),
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
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
                                    fontSize: 17 * sf,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.6,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: const Color(
                                          0xFFFF3300,
                                        ).withValues(alpha: 0.9),
                                        blurRadius: 14,
                                      ),
                                      Shadow(
                                        color: const Color(
                                          0xFFFF1100,
                                        ).withValues(alpha: 0.6),
                                        blurRadius: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ah * 0.018),

                        // Ember glow + button
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: ah * 0.14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    const Color(
                                      0xFFFF4400,
                                    ).withValues(alpha: 0.28),
                                    Colors.transparent,
                                  ],
                                  radius: 0.75,
                                ),
                              ),
                            ),
                            Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: (sw * 0.88).clamp(260, 340),
                                ),
                                child: ParchmentButton(
                                  scaleFactor: sf,
                                  onPressed: () => _enterApp(context),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: ah * 0.02),

                        _PrivacyTermsLinks(
                          scaleFactor: sf,
                          onPrivacyTap: () => _openPrivacy(context),
                          onTermsTap: () => _openTerms(context),
                        ),

                        SizedBox(height: ah * 0.04),
                      ],
                    ),
                  ),
                );
              },
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
  final double scaleFactor;
  const ParchmentButton({super.key, this.onPressed, this.scaleFactor = 1.0});

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
    final sf = widget.scaleFactor;

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

            final parchmentColors = _pressed
                ? const [
                    Color(0xFF8C5A20),
                    Color(0xFF7A4415),
                    Color(0xFF6A3410),
                    Color(0xFF7A4018),
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
                margin: EdgeInsets.all(6 * sf),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    begin: _pressed ? Alignment.bottomLeft : Alignment.topLeft,
                    end: _pressed ? Alignment.topRight : Alignment.bottomRight,
                    colors: parchmentColors,
                    stops: const [0.0, 0.35, 0.72, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
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
                        horizontal: 14 * sf,
                        vertical: (_pressed ? 15 : 13) * sf,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _StampSeal(pressed: _pressed, scaleFactor: sf),
                          SizedBox(width: 12 * sf),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 100),
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 19 * sf,
                                  fontWeight: FontWeight.w700,
                                  color: _pressed
                                      ? const Color(0xFF3A0D00)
                                      : const Color(0xFF5C1A00),
                                  letterSpacing: 0.3,
                                  shadows: _pressed
                                      ? []
                                      : [
                                          Shadow(
                                            color: const Color(
                                              0xFF3A0800,
                                            ).withValues(alpha: 0.45),
                                            offset: const Offset(1, 1.5),
                                            blurRadius: 2,
                                          ),
                                        ],
                                ),
                                child: const Text('Start Releasing'),
                              ),
                            ),
                          ),
                          SizedBox(width: 10 * sf),
                          _ParchmentArrow(pressed: _pressed, scaleFactor: sf),
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

    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(
          0xFFFF4400,
        ).withValues(alpha: 0.55 * emberIntensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = pressed ? 10 : 18
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, pressed ? 6 : 14),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(
          0xFFFF6600,
        ).withValues(alpha: 0.65 * emberIntensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = pressed ? 4 : 8
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, pressed ? 2 : 5),
    );

    if (!pressed) {
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(
            0xFFFFAA44,
          ).withValues(alpha: 0.75 * emberIntensity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
      );
    }

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
    for (int i = 1; i <= steps; i++) {
      path.lineTo((w / steps) * i + j(), j());
    }
    for (int i = 1; i <= steps; i++) {
      path.lineTo(w + j(), (h / steps) * i + j());
    }
    for (int i = steps - 1; i >= 0; i--) {
      path.lineTo((w / steps) * i + j(), h + j());
    }
    for (int i = steps - 1; i >= 0; i--) {
      path.lineTo(j(), (h / steps) * i + j());
    }
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
  final double scaleFactor;
  const _StampSeal({required this.pressed, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    final size = 36 * scaleFactor;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: pressed ? const Color(0xFF5C1000) : const Color(0xFF8B1A00),
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
            fontSize: 18 * scaleFactor,
            color: pressed ? const Color(0xFF5C1000) : const Color(0xFF8B1A00),
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
  final double scaleFactor;
  const _ParchmentArrow({required this.pressed, required this.scaleFactor});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(32 * scaleFactor, 16 * scaleFactor),
      painter: _ArrowPainter(
        color: pressed ? const Color(0xFF3A0D00) : const Color(0xFF5C1A00),
        strokeWidth: (pressed ? 1.8 : 2.2) * scaleFactor,
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
  final double scaleFactor;
  const _PrivacyTermsLinks({
    required this.onPrivacyTap,
    required this.onTermsTap,
    required this.scaleFactor,
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
            fontSize: 12 * scaleFactor,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
          ),
        ),
        SizedBox(height: 8 * scaleFactor),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink(
              label: 'Privacy',
              onTap: onPrivacyTap,
              scaleFactor: scaleFactor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor),
              child: Text(
                '·',
                style: TextStyle(
                  color: AppTheme.muted.withValues(alpha: 0.5),
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _FooterLink(
              label: 'Terms',
              onTap: onTermsTap,
              scaleFactor: scaleFactor,
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double scaleFactor;
  const _FooterLink({
    required this.label,
    required this.onTap,
    required this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4 * scaleFactor,
          vertical: 6 * scaleFactor,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppTheme.muted.withValues(alpha: 0.80),
            fontSize: 12 * scaleFactor,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: AppTheme.muted.withValues(alpha: 0.35),
          ),
        ),
      ),
    );
  }
}
