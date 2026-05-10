import 'package:flutter/material.dart';
import 'package:stillmad/core/routes/app_routes.dart';
import 'package:stillmad/core/theme/app_theme.dart';

enum ReleaseMode {
  breakIt(
    title: 'Break it',
    verb: 'Crack the pressure',
    description: 'A kinetic ritual for when the feeling needs impact.',
    route: AppRoutes.breakIt,
    icon: Icons.bolt,
    color: AppTheme.cyan,
  ),
  voidIt(
    title: 'Void it',
    verb: 'Send it nowhere',
    description: 'Drop the thought into a quiet black hole.',
    route: AppRoutes.voidIt,
    icon: Icons.blur_on,
    color: AppTheme.acid,
  ),
  burnIt(
    title: 'Burn it',
    verb: 'Let it ash out',
    description: 'Transform the charge into heat, then smoke.',
    route: AppRoutes.burnIt,
    icon: Icons.local_fire_department,
    color: AppTheme.ember,
  ),
  moveIt(
    title: 'Move it',
    verb: 'Shake it loose',
    description: 'Use motion, breath, and rhythm to discharge.',
    route: AppRoutes.moveIt,
    icon: Icons.directions_run,
    color: AppTheme.rose,
  ),
  tossItAway(
    title: 'Toss it away',
    verb: 'Throw it out',
    description: 'Name it, ball it up, and send it off-screen.',
    route: AppRoutes.tossItAway,
    icon: Icons.outbond,
    color: Color(0xFFFFD166),
  );

  const ReleaseMode({
    required this.title,
    required this.verb,
    required this.description,
    required this.route,
    required this.icon,
    required this.color,
  });

  final String title;
  final String verb;
  final String description;
  final String route;
  final IconData icon;
  final Color color;
}
