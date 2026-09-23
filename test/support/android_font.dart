import 'dart:io';
import 'package:flutter/services.dart';

Future<void> loadAndroidFont() async {
  final artifacts = File(Platform.resolvedExecutable).parent.parent.parent;
  final font = File('${artifacts.path}/material_fonts/roboto-regular.ttf');
  final loader = FontLoader('Roboto');
  loader.addFont(Future.value(ByteData.sublistView(await font.readAsBytes())));
  await loader.load();
}
