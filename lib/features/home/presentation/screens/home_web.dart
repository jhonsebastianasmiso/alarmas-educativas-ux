import '../../../alarms/domain/alarm_data.dart';
import '../../../alarms/presentation/screens/edit_alarm_screen.dart';
import 'package:flutter/material.dart';
import '../../../alarms/presentation/screens/create_alarm_screen.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import '../../../../shared/widgets/layouts/apple_main_header.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  int? _expandedIndex;

  final _alarms = <AlarmData>[
    AlarmData(
      name: 'Primera entrega UX',
      details:
          '1. Diseñar los prototipos en papel\n2. Realizar las pruebas del prototipo web\n3. Realizar las pruebas del prototipo mobile\n4. Realizar pruebas con usuario\n5. Entregar actividad',
      date: DateTime(2025, 4, 1),
      time: const TimeOfDay(hour: 9, minute: 41),
      days: const ['Lunes', 'Miércoles', 'Sábado'],
    ),
    AlarmData(
      name: 'Segunda entrega desarrollo de apps',
      details: 'Entrega de prototipo de papel',
      date: DateTime(2025, 12, 6),
      time: const TimeOfDay(hour: 17, minute: 50),
    ),
    AlarmData(
      name: 'Lectura arquitectura',
      details: 'Lectura sobre el libro de buenas prácticas',
      date: DateTime(2025, 12, 4),
      time: const TimeOfDay(hour: 20, minute: 0),
    ),
    AlarmData(
      name: 'Lectura métodos de UI',
      details: 'Lectura sobre los diferentes métodos y análisis de UI',
      date: DateTime(2025, 12, 7),
      time: const TimeOfDay(hour: 23, minute: 6),
    ),
  ];

  Future<void> _openAlarm({int? index}) async {
    final result = await Navigator.push<AlarmData>(
      context,
      MaterialPageRoute(
        builder: (_) => index == null
            ? const CreateAlarmScreen()
            : EditAlarmScreen(alarm: _alarms[index]),
      ),
    );
    if (!mounted || result == null) return;
    setState(() {
      if (index == null) {
        _alarms.add(result);
      } else {
        _alarms[index] = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: WebLayout(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 380;
              final createButton = AppleButton(
                text: 'Crear Alarma',
                height: 40,
                isFullWidth: false,
                onPressed: () => _openAlarm(),
              );
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 16, 22, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppleMainHeader(
                          currentScreen: 'home',
                          rightActionWidget: compact ? null : createButton,
                        ),
                        if (compact)
                          Align(
                            alignment: Alignment.centerRight,
                            child: createButton,
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                        itemCount: _alarms.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final alarm = _alarms[index];
                          return _AlarmCard(
                            onTap: () => setState(() {
                              _expandedIndex = _expandedIndex == index
                                  ? null
                                  : index;
                            }),
                            expanded: _expandedIndex == index,
                            onEdit: () => _openAlarm(index: index),
                            fullDetails: alarm.details,
                            title: alarm.name,
                            detail: alarm.details.split('\n').first,
                            time: alarm.time.format(context),
                            date: '${alarm.date.day}/${alarm.date.month}',
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AlarmCard extends StatelessWidget {
  const _AlarmCard({
    required this.onTap,
    required this.expanded,
    required this.onEdit,
    required this.fullDetails,
    required this.title,
    required this.detail,
    required this.time,
    required this.date,
  });

  final VoidCallback onTap;
  final VoidCallback onEdit;
  final bool expanded;
  final String fullDetails;
  final String title;
  final String detail;
  final String time;
  final String date;

  @override
  Widget build(BuildContext context) {
    const headingStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
    const detailStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    final header = Semantics(
      expanded: expanded,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final description = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: headingStyle),
                  const SizedBox(height: 10),
                  Text(detail, style: detailStyle),
                ],
              );
              final schedule = Column(
                children: [
                  Text(time, style: headingStyle),
                  const SizedBox(height: 10),
                  Text(date, style: detailStyle),
                ],
              );
              if (constraints.maxWidth < 340) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: description),
                        Icon(
                          expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(alignment: Alignment.centerRight, child: schedule),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: description),
                  const SizedBox(width: 20),
                  schedule,
                  const SizedBox(width: 8),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        header,
        if (expanded) ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 90),
                  child: Text(
                    fullDetails.isEmpty ? 'Sin detalles' : fullDetails,
                    style: detailStyle,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppleButton(
                    text: 'Editar Alarma',
                    height: 40,
                    isFullWidth: false,
                    onPressed: onEdit,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
