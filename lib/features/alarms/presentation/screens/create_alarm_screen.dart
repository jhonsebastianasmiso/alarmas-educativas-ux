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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _colorOptions.length,
            itemBuilder: (context, index) {
              final option = _colorOptions[index];
              return ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: option.color,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(option.name, style: const TextStyle(fontSize: 18)),
                trailing: _selectedColor == option
                    ? const Icon(Icons.check, color: Color(0xFF007AFF))
                    : null,
                onTap: () {
                  setState(() {
                    _selectedColor = option;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showDaysPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Repeticiones',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ..._dayOptions.map((day) {
                    final isSelected = _selectedDays.contains(day);
                    return CheckboxListTile(
                      title: Text(day, style: const TextStyle(fontSize: 18)),
                      value: isSelected,
                      activeColor: const Color(0xFF007AFF),
                      onChanged: (bool? value) {
                        setModalState(() {
                          if (value == true) {
                            _selectedDays.add(day);
                          } else {
                            _selectedDays.remove(day);
                          }
                        });
                        setState(() {}); // Update main screen state
                      },
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007AFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Listo',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
