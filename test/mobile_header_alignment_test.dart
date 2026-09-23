import 'support/android_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alarmas_educativas/features/home/presentation/screens/mobile_home_screen.dart';
import 'package:alarmas_educativas/features/sync/presentation/screens/mobile_connect_screen.dart';
import 'package:alarmas_educativas/features/sync/presentation/screens/found_information_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAndroidFont);
  for (final height in [760.0, 920.0]) {
    testWidgets(
      'Mobile titles share home typography and top alignment at $height',
      (tester) async {
        tester.view.physicalSize = Size(390, height);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(const MaterialApp(home: MobileHomeScreen()));
        final homeStyle = tester.widget<Text>(find.text('Alarma P.')).style;
        await tester.pumpWidget(const MaterialApp(home: MobileConnectScreen()));
        final connectTitle = tester.getRect(find.text('Conectar'));
        final connectArrow = tester.getRect(find.byTooltip('Volver'));
        final connectIntro = tester.getTopLeft(
          find.text(
            'Sincroniza tus actividades y crea alarmas para no faltar a ninguna entrega',
          ),
        );
        expect(tester.widget<Text>(find.text('Conectar')).style, homeStyle);
        await tester.pumpWidget(
          const MaterialApp(home: FoundInformationScreen()),
        );
        final title = find.text('Información\nencontrada');
        expect(tester.widget<Text>(title).style, homeStyle);
        expect(tester.getRect(title).top, closeTo(connectTitle.top, 1));
        expect(
          tester.getRect(title).center.dx,
          closeTo(connectTitle.center.dx, 1),
        );
        expect(tester.getRect(find.byTooltip('Volver')), connectArrow);
        expect(
          tester
              .getTopLeft(find.text('Selecciona la información a\nsincronizar'))
              .dy,
          closeTo(connectIntro.dy, 1),
        );
        expect(tester.getRect(title).top, lessThan(40));
        expect(tester.takeException(), isNull);
      },
    );
  }
}
