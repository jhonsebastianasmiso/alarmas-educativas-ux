import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alarmas_educativas/features/sync/presentation/screens/found_information_screen.dart';
import 'package:alarmas_educativas/features/sync/presentation/screens/sync_success_screen.dart';
import 'package:alarmas_educativas/features/home/presentation/screens/mobile_home_screen.dart';

void main() {
  testWidgets(
    'Default courses show prototype totals and finish at mobile home',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FoundInformationScreen()),
      );
      await tester.ensureVisible(find.text('Crear Alarmas'));
      await tester.tap(find.text('Crear Alarmas'));
      await tester.pumpAndSettle();
      expect(find.text('Sincronizado'), findsOneWidget);
      expect(find.text('50 alarmas'), findsOneWidget);
      expect(find.text('3 asignaturas con'), findsOneWidget);
      expect(find.text('30 Actividades'), findsOneWidget);
      expect(
        find.text('Demostración: no se han creado alarmas reales.'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.text('Entendido'));
      await tester.tap(find.text('Entendido'));
      await tester.pumpAndSettle();
      expect(find.byType(MobileHomeScreen), findsOneWidget);
      expect(
        Navigator.of(tester.element(find.byType(MobileHomeScreen))).canPop(),
        isFalse,
      );
    },
  );

  testWidgets('Android back preserves course selection', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FoundInformationScreen()));
    await tester.tap(find.byType(Checkbox).last);
    await tester.pump();
    await tester.ensureVisible(find.text('Crear Alarmas'));
    await tester.tap(find.text('Crear Alarmas'));
    await tester.pumpAndSettle();
    expect(find.text('62 alarmas'), findsOneWidget);
    expect(find.text('4 asignaturas con'), findsOneWidget);
    expect(find.text('38 Actividades'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      tester
          .widgetList<Checkbox>(find.byType(Checkbox))
          .every((checkbox) => checkbox.value == true),
      isTrue,
    );
  });

  for (final width in [320.0, 350.0, 412.0]) {
    testWidgets('Summary is scrollable at width $width with large text', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.5)),
            child: child!,
          ),
          home: const SyncSuccessScreen(
            alarmCount: 1,
            courseCount: 1,
            activityCount: 1,
          ),
        ),
      );
      expect(find.text('1 alarma'), findsOneWidget);
      expect(find.text('1 asignatura con'), findsOneWidget);
      expect(find.text('1 Actividad'), findsOneWidget);
      await tester.ensureVisible(find.text('Entendido'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
