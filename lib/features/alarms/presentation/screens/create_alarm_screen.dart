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
  'Domingo'
];

const List<String> _months = [
  'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
];

class CreateAlarmScreen extends StatefulWidget {
  const CreateAlarmScreen({super.key});

  @override
  State<CreateAlarmScreen> createState() => _CreateAlarmScreenState();
}

class _CreateAlarmScreenState extends State<CreateAlarmScreen> {
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  ColorOption _selectedColor = _colorOptions.first;
  final List<String> _selectedDays = [];

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _createAlarm() {
    // Implement create alarm logic
    Navigator.pop(context); // just pop back for now
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
                  scrollController: FixedExtentScrollController(initialItem: initialIndex),
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
                color: const Color(0xFFF2F2F7), // Fondo agrupado de iOS
                child: Column(
                  children: [
                    // Barra superior (Toolbar)
                    Container(
                      height: 44,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text('Cancelar', style: TextStyle(color: Color(0xFF007AFF))),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text('Repeticiones', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text('Listo', style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.w600)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFC6C6C8)),
                    
                    // Lista de opciones estilo iOS Inset Grouped
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
                              children: _dayOptions.asMap().entries.map((entry) {
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
                                    setState(() {}); // Reflejar en la pantalla principal
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(day, style: const TextStyle(fontSize: 17, color: Colors.black)),
                                            if (isSelected)
                                              const Icon(CupertinoIcons.check_mark, color: Color(0xFF007AFF), size: 20),
                                          ],
                                        ),
                                      ),
                                      if (index < _dayOptions.length - 1)
                                        const Divider(height: 1, indent: 16, color: Color(0xFFE5E5EA)),
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
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          )
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
          AppleTopLabelField(
            controller: _nameController,
            label: 'Nombre',
          ),
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
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildDesignCard() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          )
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
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: AppleMainHeader(
                currentScreen: 'create_alarm',
                title: 'Crear alarma',
                showBackButton: true,
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 850;
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36.0,
                                vertical: 16.0,
                              ),
                              child: isWide
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: _buildDetailsCard(),
                                        ),
                                        const SizedBox(width: 32),
                                        Expanded(
                                          flex: 3,
                                          child: _buildDesignCard(),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _buildDetailsCard(),
                                        const SizedBox(height: 24),
                                        _buildDesignCard(),
                                      ],
                                    ),
                            ),
                            const Spacer(flex: 1),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 36.0,
                                bottom: 32.0,
                                top: 24.0,
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: AppleButton(
                                  text: 'Crear Alarma',
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
          ],
        ),
      ),
    );
  }
}
