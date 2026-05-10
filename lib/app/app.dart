import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stillmad/core/routes/app_router.dart';
import 'package:stillmad/core/routes/app_routes.dart';
import 'package:stillmad/core/theme/app_theme.dart';
import 'package:stillmad/services/haptic_service.dart';
import 'package:stillmad/services/privacy_service.dart';
import 'package:stillmad/services/sound_service.dart';

class StillmadApp extends StatelessWidget {
  const StillmadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => HapticService()),
        Provider(create: (_) => SoundService()),
        ChangeNotifierProvider(create: (_) => PrivacyService()..load()),
      ],
      child: MaterialApp(
        title: 'Stillmad',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
