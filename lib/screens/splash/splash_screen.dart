import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stillmad/core/constants/app_constants.dart';
import 'package:stillmad/core/routes/app_routes.dart';
import 'package:stillmad/core/theme/app_theme.dart';
import 'package:stillmad/widgets/particle_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(milliseconds: 900), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParticleBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppConstants.appName.toUpperCase(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 12),
              const Text(
                'Release it. Keep yourself.',
                style: TextStyle(color: AppTheme.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
