import '../../domain/alarm_data.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/widgets/layouts/apple_main_header.dart';
import '../../../../shared/widgets/forms/apple_top_label_field.dart';
import '../../../../shared/widgets/forms/apple_date_time_pills.dart';
import '../../../../shared/widgets/forms/apple_dropdown_field.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';

class ColorOption {
  final String name;
  final Color color;
  const ColorOption(this.name, this.color);
}

const List<ColorOption> _colorOptions = [
  ColorOption('Azul', Color(0xFF007AFF)),
  ColorOption('Rojo', Color(0xFFFF3B30)),
  ColorOption('Verde', Color(0xFF34C759)),
  ColorOption('Amarillo', Color(0xFFFFCC00)),
  ColorOption('Naranja', Color(0xFFFF9500)),
];

const List<String> _dayOptions = [
  'Lunes',
  'Martes',
  'Miércoles',
  'Jueves',
  'Viernes',
  'Sábado',
  'Domingo',
];

const List<String> _months = [
  'Ene',
  'Feb',
  'Mar',
  'Abr',
  'May',
  'Jun',
  'Jul',
  'Ago',
  'Sep',
  'Oct',
  'Nov',
  'Dic',
];

class AlarmFormScreen extends StatefulWidget {
  const AlarmFormScreen({super.key, this.initialAlarm});
  final AlarmData? initialAlarm;

  @override
  State<AlarmFormScreen> createState() => _AlarmFormScreenState();
}

class _AlarmFormScreenState extends State<AlarmFormScreen> {
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  ColorOption _selectedColor = _colorOptions.first;
  final List<String> _selectedDays = [];

  bool get _isEditing => widget.initialAlarm != null;

  @override
  void initState() {
    super.initState();
    final alarm = widget.initialAlarm;
    if (alarm != null) {
      _nameController.text = alarm.name;
      _detailsController.text = alarm.details;
      _selectedDate = alarm.date;
      _selectedTime = alarm.time;
      _selectedColor = _colorOptions.firstWhere(
        (option) => option.name == alarm.colorName,
        orElse: () => _colorOptions.first,
      );
      _selectedDays.addAll(alarm.days);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _createAlarm() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un nombre para la alarma.')),
      );
      return;
    }
    Navigator.pop(
      context,
      AlarmData(
        name: _nameController.text.trim(),
        details: _detailsController.text.trim(),
        date: _selectedDate,
        time: _selectedTime,
        colorName: _selectedColor.name,
        color: _selectedColor.color,
        days: List.unmodifiable(_selectedDays),
      ),
    );
  }

  String get formattedDate =>
      '${_months[_selectedDate.month - 1]} ${_selectedDate.day}, ${_selectedDate.year}';

  String get formattedTime => _selectedTime.format(context);

  String get formattedDays {
    if (_selectedDays.isEmpty) return 'Nunca';
    if (_selectedDays.length == 7) return 'Todos los días';
    return _selectedDays.join(', ');
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: _selectedDate,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
        );
      },
    );
  }

  void _showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(
              2020,
              1,
              1,
              _selectedTime.hour,
              _selectedTime.minute,
            ),
            onDateTimeChanged: (DateTime newTime) {
              setState(() {
                _selectedTime = TimeOfDay.fromDateTime(newTime);
              });
            },
          ),
        );
      },
    );
  }

  void _showColorPicker() {
    int initialIndex = _colorOptions.indexOf(_selectedColor);
    if (initialIndex < 0) initialIndex = 0;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: initialIndex,
                  ),
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      _selectedColor = _colorOptions[index];
                    });
                  },
                  children: _colorOptions.map((option) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: option.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(option.name, style: const TextStyle(fontSize: 20)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDaysPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Material(
              type: MaterialType.transparency,
              child: Container(
                height: 450,
                color: const Color(0xFFF2F2F7),
                child: Column(
                  children: [
                    Container(
                      height: 44,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Color(0xFF007AFF)),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Repeticiones',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text(
                              'Listo',
                              style: TextStyle(
                                color: Color(0xFF007AFF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFC6C6C8)),

                    Expanded(
                      child: ListView(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: _dayOptions.asMap().entries.map((
                                entry,
                              ) {
                                final index = entry.key;
                                final day = entry.value;
                                final isSelected = _selectedDays.contains(day);
                                return GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      if (isSelected) {
                                        _selectedDays.remove(day);
                                      } else {
                                        _selectedDays.add(day);
                                      }
                                    });
                                    setState(
                                      () {},
                                    );
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 14.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              day,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                              ),
                                            ),
                                            if (isSelected)
                                              const Icon(
                                                CupertinoIcons.check_mark,
                                                color: Color(0xFF007AFF),
                                                size: 20,
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (index < _dayOptions.length - 1)
                                        const Divider(
                                          height: 1,
                                          indent: 16,
                                          color: Color(0xFFE5E5EA),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Detalle de alarma',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF007AFF),
            ),
          ),
          const SizedBox(height: 24),
          AppleTopLabelField(controller: _nameController, label: 'Nombre'),
          const SizedBox(height: 24),
          AppleDateTimePills(
            label: 'Fecha y Hora',
            dateText: formattedDate,
            timeText: formattedTime,
            onDateTap: _showDatePicker,
            onTimeTap: _showTimePicker,
          ),
          const SizedBox(height: 24),
          AppleTopLabelField(
            controller: _detailsController,
            label: 'Detalle tarea',
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildDesignCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Diseño alarma',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF007AFF),
            ),
          ),
          const SizedBox(height: 24),
          AppleDropdownField(
            label: 'Color de la tarea',
            valueText: _selectedColor.name,
            indicatorColor: _selectedColor.color,
            onTap: _showColorPicker,
          ),
          const SizedBox(height: 24),
          AppleDropdownField(
            label: 'Repeticiones',
            valueText: formattedDays,
            onTap: _showDaysPicker,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _isEditing ? 'Editar alarma' : 'Crear alarma';
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: WebLayout(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < 500;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - 32).clamp(
                      0.0,
                      double.infinity,
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppleMainHeader(
                          currentScreen: _isEditing
                              ? 'edit_alarm'
                              : 'create_alarm',
                          title: narrow ? null : title,
                          showBackButton: true,
                        ),
                        if (narrow)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF007AFF),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        if (constraints.maxWidth >= 580)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: _buildDetailsCard()),
                              const SizedBox(width: 16),
                              Expanded(flex: 2, child: _buildDesignCard()),
                            ],
                          )
                        else ...[
                          _buildDetailsCard(),
                          const SizedBox(height: 16),
                          _buildDesignCard(),
                        ],
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 16),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AppleButton(
                              text: _isEditing
                                  ? 'Guardar cambios'
                                  : 'Crear Alarma',
                              onPressed: _createAlarm,
                              isFullWidth: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
