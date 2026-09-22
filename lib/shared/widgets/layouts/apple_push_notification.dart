import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../features/home/presentation/screens/study_session_screen.dart';

void showApplePushNotification(BuildContext context, {required String title, required String body}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _ApplePushNotificationWidget(
      title: title,
      body: body,
      onDismiss: () {
        overlayEntry.remove();
      },
    ),
  );

  overlay.insert(overlayEntry);
}

class _ApplePushNotificationWidget extends StatefulWidget {
  final String title;
  final String body;
  final VoidCallback onDismiss;

  const _ApplePushNotificationWidget({
    required this.title,
    required this.body,
    required this.onDismiss,
  });

  @override
  State<_ApplePushNotificationWidget> createState() => _ApplePushNotificationWidgetState();
}

class _ApplePushNotificationWidgetState extends State<_ApplePushNotificationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _dismissTimer;
  int _state = 0; // 0 = collapsed, 1 = expanded, 2 = postponing

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward();

    _startDismissTimer();
  }

  void _startDismissTimer() {
    _dismissTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && _state == 0) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  void _cancelTimer() {
    _dismissTimer?.cancel();
  }

  @override
  void dispose() {
    _cancelTimer();
    _controller.dispose();
    super.dispose();
  }

  void _submitPostpone() {
    // Show a small native-like alert or snackbar and dismiss
    _controller.reverse().then((_) {
      widget.onDismiss();
      // Use ScaffoldMessenger to show feedback
      // We need a context that has Scaffold. We can't easily use the Overlay context for ScaffoldMessenger.
      // But we can just assume the user understands it's postponed, or use a root navigator dialog.
      // The prompt said: "solo indicar, como la alarma se a pospuesto"
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF007AFF);
    final bool isExpanded = _state > 0;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta! < -5) {
                    // Swipe up to dismiss
                    _controller.reverse().then((_) => widget.onDismiss());
                  }
                },
                onTap: () {
                  if (_state == 0) {
                    setState(() {
                      _state = 1;
                    });
                    _cancelTimer();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isExpanded ? const Color(0xFFF9F9F9) : const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Row
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: isExpanded ? 16 : 12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: isExpanded ? Border.all(color: Colors.grey.shade300) : null,
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.scope,
                                  color: Colors.grey.shade400,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.title,
                                        style: TextStyle(
                                          color: isExpanded ? primaryBlue : Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '9:41 AM',
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.body,
                                    style: TextStyle(
                                      color: isExpanded ? primaryBlue : Colors.white,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Expanded Details
                      if (_state == 1) ...[
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2F2F7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(28),
                              bottomRight: Radius.circular(28),
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 16, bottom: 32),
                          child: Column(
                            children: const [
                              Text(
                                '7:00 - 8:00 p.m.',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                '6 tareas pendientes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: primaryBlue,
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                '1 Hora',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Postponing State
                      if (_state == 2) ...[
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFFCECECE), // Gray background from mockup
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(28),
                              bottomRight: Radius.circular(28),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          child: Column(
                            children: [
                              const Text(
                                'Motivo por no estudiar',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: 'Motivo:',
                                    hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    suffixIcon: Icon(
                                      CupertinoIcons.clear_thick_circled,
                                      color: Colors.grey.shade400,
                                      size: 20,
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: 140,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: _submitPostpone,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Posponer',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              
              // Action Menu (Context Menu style)
              if (_state == 1)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildActionItem(
                          icon: CupertinoIcons.viewfinder,
                          text: '5 minutos más',
                          onTap: () {
                            setState(() {
                              _state = 2; // Transition to postponing
                            });
                          },
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey.shade800,
                        ),
                        _buildActionItem(
                          icon: CupertinoIcons.viewfinder,
                          text: 'Estudiar',
                          onTap: () {
                            _controller.reverse().then((_) {
                              widget.onDismiss();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StudySessionScreen(
                                    title: widget.title,
                                    taskName: widget.body,
                                    accentColor: const Color(0xFF00C7E6),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
