import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stillmad/main.dart';

void main() {
  testWidgets('Stillmad boots into the splash screen', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const StillmadApp());

    expect(find.text('STILLMAD'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('Stillmad shows release modes on home', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const StillmadApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.text('Break it'), findsOneWidget);
    expect(find.text('Void it'), findsOneWidget);
    expect(find.text('Burn it'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
