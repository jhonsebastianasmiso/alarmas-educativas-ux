import '../../../../shared/styles/mobile_text_styles.dart';
import '../../../sync/presentation/screens/mobile_connect_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/widgets/layouts/apple_logout_dialog.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _tasks1 = [
    {'title': 'Lista funcionalidades', 'date': '17/08', 'completed': true},
    {'title': 'Read Route', 'date': '18/08', 'completed': true},
    {'title': 'Desarrollo MVP', 'date': '18/08', 'completed': true},
    {'title': 'User Flow', 'date': '19/08', 'completed': false},
  ];

  final List<Map<String, dynamic>> _tasks2 = [
    {'title': 'Detallar HU', 'date': '17/08', 'completed': true},
    {'title': 'Revisión IA', 'date': '18/08', 'completed': true},
    {'title': 'Revisión Par', 'date': '18/08', 'completed': true},
    {'title': 'Bitácora', 'date': '19/08', 'completed': false},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openConnect() {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => const MobileConnectScreen()),
    );
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF007AFF);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Alarma P.', style: MobileTextStyles.title),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _openConnect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text(
                        'Conectar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildPageContent(
                    title: 'MISW-4302 UX',
                    subtitle:
                        'Entrega de validación de\nrequisitos funcionales',
                    accentColor: const Color(0xFFD92EEB),
                    tasks: _tasks1,
                  ),
                  _buildPageContent(
                    title: 'MISW-4101 Prácticas',
                    subtitle: 'Entrega grupal del proyecto del\ncurso semana 3',
                    accentColor: const Color(0xFF00C7E6),
                    tasks: _tasks2,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _goToPage(0),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == 0
                            ? primaryBlue
                            : Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _goToPage(1),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == 1
                            ? primaryBlue
                            : Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                bottom: 30.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.grey.shade300, width: 0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildNavItem(
                        CupertinoIcons.square_arrow_right,
                        'Salir',
                        false,
                        primaryBlue,
                        () {
                          showAppleLogoutDialog(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildNavItem(
                        CupertinoIcons.house_fill,
                        'Inicio',
                        true,
                        primaryBlue,
                        () {},
                      ),
                    ),
                    Expanded(
                      child: _buildNavItem(
                        CupertinoIcons.arrow_2_circlepath,
                        'Sincronizar',
                        false,
                        primaryBlue,
                        _openConnect,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({
    required String title,
    required String subtitle,
    required Color accentColor,
    required List<Map<String, dynamic>> tasks,
  }) {
    const Color bgGrey = Color(0xFFF2F2F7);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: bgGrey,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(color: accentColor, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'En una semana',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                'Agosto 23',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 32),

          const Text(
            'Entregas pendientes:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          ...List.generate(tasks.length, (index) {
            final task = tasks[index];
            return _buildTaskItem(
              task['title'] as String,
              task['date'] as String,
              task['completed'] as bool,
              accentColor,
              () {
                setState(() {
                  task['completed'] = !(task['completed'] as bool);
                });
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    String title,
    String date,
    bool isCompleted,
    Color accentColor,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Icon(
              isCompleted
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.circle,
              color: isCompleted ? accentColor : Colors.grey.shade400,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isSelected,
    Color primaryBlue,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE5E5EA) : Colors.transparent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: primaryBlue, size: 26),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
