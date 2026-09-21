import 'package:alarmas_educativas/features/home/presentation/screens/home_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Alarm headers expand and collapse without opening the editor', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeWeb()));
    expect(find.text('Editar Alarma'), findsNothing);
    await tester.tap(find.text('Primera entrega UX'));
    await tester.pumpAndSettle();
    expect(find.textContaining('5. Entregar actividad'), findsOneWidget);
    expect(find.byType(TextFormField), findsNothing);
    expect(find.text('Editar Alarma'), findsOneWidget);
    await tester.tap(find.text('Primera entrega UX'));
    await tester.pumpAndSettle();
    expect(find.textContaining('5. Entregar actividad'), findsNothing);
    expect(find.text('Editar Alarma'), findsNothing);
    await tester.tap(find.text('Segunda entrega desarrollo de apps'));
    await tester.pumpAndSettle();
    expect(find.text('Editar Alarma'), findsOneWidget);
    expect(find.byType(TextFormField), findsNothing);
  });
  testWidgets(
    'Edit saves values to the selected card and reopening keeps them',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MaterialApp(home: HomeWeb()));
      await tester.tap(find.text('Primera entrega UX'));
      await tester.pumpAndSettle();
      expect(find.text('Editar alarma'), findsNothing);
      expect(find.text('Editar Alarma'), findsOneWidget);
      await tester.tap(find.text('Editar Alarma'));
      await tester.pumpAndSettle();
      expect(find.text('Editar alarma'), findsOneWidget);
      expect(find.text('Lunes, Miércoles, Sábado'), findsOneWidget);
      await tester.enterText(
        find.byType(TextFormField).first,
        'Entrega revisada',
      );
      await tester.ensureVisible(find.text('Guardar cambios'));
      await tester.tap(find.text('Guardar cambios'));
      await tester.pumpAndSettle();
      expect(find.text('Entrega revisada'), findsOneWidget);
      await tester.tap(find.text('Editar Alarma'));
      await tester.pumpAndSettle();
      expect(find.text('Entrega revisada'), findsOneWidget);
      await tester.enterText(
        find.byType(TextFormField).first,
        'Cambio descartado',
      );
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();
      expect(find.text('Entrega revisada'), findsOneWidget);
      expect(find.text('Cambio descartado'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Narrow editing screen scrolls without overflowing', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: HomeWeb()));
    await tester.tap(find.text('Primera entrega UX'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Editar Alarma'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Editar Alarma'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Guardar cambios'));
    expect(tester.takeException(), isNull);
  });
}

