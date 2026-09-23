import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alarmas_educativas/features/home/presentation/screens/mobile_home_screen.dart';
import 'package:alarmas_educativas/features/sync/presentation/screens/mobile_connect_screen.dart';

void main() {
  for (final screenHeight in [760.0, 920.0]) {
    testWidgets('Connect header stays at the top on height $screenHeight', (
      tester,
    ) async {
      tester.view.physicalSize = Size(390, screenHeight);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MaterialApp(home: MobileConnectScreen()));
      final title = tester.getRect(find.text('Conectar'));
      final back = tester.getRect(find.byTooltip('Volver'));
      final introduction = tester.getRect(
        find.text(
          'Sincroniza tus actividades y crea alarmas para no faltar a ninguna entrega',
        ),
      );
      expect(title.top, lessThan(40));
      expect(title.center.dx, closeTo(195, 1));
      expect(title.center.dy, closeTo(back.center.dy, 1));
      expect(introduction.top, inInclusiveRange(160, 190));
      expect(
        tester.getRect(find.text('Iniciar sincronización')).bottom,
        lessThan(screenHeight),
      );
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('Both mobile actions open Connect and back returns home', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: MobileHomeScreen()));
    for (final label in ['Conectar', 'Sincronizar']) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      expect(find.byType(MobileConnectScreen), findsOneWidget);
      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();
      expect(find.byType(MobileConnectScreen), findsNothing);
      expect(find.text('Alarma P.'), findsOneWidget);
    }
  });

  testWidgets(
    'Validate fields and explicit consent without claiming a real sync',
    (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MobileConnectScreen()));
      final submit = find.text('Iniciar sincronización');
      await tester.ensureVisible(submit);
      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(
        find.text('Ingresa la plataforma que deseas conectar.'),
        findsOneWidget,
      );
      await tester.enterText(find.byType(TextFormField).first, 'Campus');
      await tester.enterText(
        find.byType(TextFormField).last,
        'correo-invalido',
      );
      await tester.ensureVisible(submit);
      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(find.text('Ingresa un correo asociado válido.'), findsOneWidget);
      await tester.enterText(
        find.byType(TextFormField).last,
        'alumno@example.com',
      );
      await tester.ensureVisible(submit);
      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(
        find.text('Acepta los términos y condiciones para continuar.'),
        findsOneWidget,
      );
      await tester.tap(find.byType(Checkbox));
      await tester.ensureVisible(submit);
      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pumpAndSettle();
      expect(find.text('Cursos de ejemplo'), findsOneWidget);
      expect(find.byType(Checkbox), findsNWidgets(4));
      await tester.tap(find.byTooltip('Volver'));
      await tester.pumpAndSettle();
      expect(find.text('Campus'), findsOneWidget);
    },
  );

  for (final width in [320.0, 350.0, 412.0]) {
    testWidgets('Connect fits width $width with keyboard and large text', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 760);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.3),
              viewInsets: const EdgeInsets.only(bottom: 280),
            ),
            child: child!,
          ),
          home: const MobileConnectScreen(),
        ),
      );
      await tester.ensureVisible(find.text('Iniciar sincronización'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
