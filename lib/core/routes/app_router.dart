import 'package:flutter/material.dart';
import 'package:stillmad/core/routes/app_routes.dart';
import 'package:stillmad/screens/break_it/break_it_screen.dart';
import 'package:stillmad/screens/burn_it/burn_it_screen.dart';
import 'package:stillmad/screens/home/home_screen.dart';
import 'package:stillmad/screens/move_it/move_it_screen.dart';
import 'package:stillmad/screens/rituals/rituals_screen.dart';
import 'package:stillmad/screens/safety/safety_screen.dart';
import 'package:stillmad/screens/splash/splash_screen.dart';
import 'package:stillmad/screens/toss_it_away/toss_it_away_screen.dart';
import 'package:stillmad/screens/void_it/void_it_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<void> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => switch (settings.name) {
        AppRoutes.splash => const SplashScreen(),
        AppRoutes.home => const HomeScreen(),
        AppRoutes.breakIt => const BreakItScreen(),
        AppRoutes.voidIt => const VoidItScreen(),
        AppRoutes.burnIt => const BurnItScreen(),
        AppRoutes.moveIt => const MoveItScreen(),
        AppRoutes.tossItAway => const TossItAwayScreen(),
        AppRoutes.rituals => const RitualsScreen(),
        AppRoutes.safety => const SafetyScreen(),
        _ => const HomeScreen(),
      },
    );
  }
}
