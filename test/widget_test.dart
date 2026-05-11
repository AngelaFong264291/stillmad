import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stillmad/main.dart';

void main() {
  testWidgets('VENT 躁 boots into the splash screen', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const VentApp());

    expect(find.text('Start Releasing'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('VENT 躁 shows release modes on home', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const VentApp());
    await tester.tap(find.text('Start Releasing'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Break it'), findsOneWidget);
    expect(find.text('Void it'), findsOneWidget);
    expect(find.text('Burn it'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
