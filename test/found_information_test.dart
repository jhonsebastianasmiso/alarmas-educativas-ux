import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alarmas_educativas/features/sync/presentation/screens/found_information_screen.dart';

void main() {
  testWidgets(
    'Three courses start selected, toggles work, and empty selection is rejected',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FoundInformationScreen()),
      );
      expect(
        tester
            .widgetList<Checkbox>(find.byType(Checkbox))
            .map((item) => item.value),
        [true, true, true, false],
      );
      for (var i = 0; i < 3; i++) {
        await tester.tap(find.byType(Checkbox).at(i));
        await tester.pump();
      }
      await tester.ensureVisible(find.text('Crear Alarmas'));
      await tester.tap(find.text('Crear Alarmas'));
      await tester.pumpAndSettle();
      expect(find.text('Selecciona al menos un curso.'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      await tester.ensureVisible(find.byType(Checkbox).last);
      await tester.tap(find.byType(Checkbox).last);
      await tester.pump();
      expect(find.text('Selecciona al menos un curso.'), findsNothing);
      await tester.ensureVisible(find.text('Crear Alarmas'));
      await tester.tap(find.text('Crear Alarmas'));
      await tester.pumpAndSettle();
      final content = tester
          .widget<Text>(
            find.descendant(
              of: find.byType(AlertDialog),
              matching: find.textContaining('Estos cursos son de ejemplo'),
            ),
          )
          .data!;
      expect(content, contains('Arquitectura para Big Data'));
      expect(content, isNot(contains('UX mejoramiento')));
      await tester.tap(find.text('Entendido'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widgetList<Checkbox>(find.byType(Checkbox))
            .map((item) => item.value),
        [false, false, false, true],
      );
    },
  );

  for (final width in [320.0, 350.0, 412.0]) {
    testWidgets('Courses scroll at width $width with enlarged text', (
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
          home: const FoundInformationScreen(),
        ),
      );
      await tester.ensureVisible(find.text('Crear Alarmas'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
