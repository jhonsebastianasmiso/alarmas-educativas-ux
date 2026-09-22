import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  bool _isExpanded = false;

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
      if (mounted && !_isExpanded) {
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

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF007AFF);

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
                  if (!_isExpanded) {
                    setState(() {
                      _isExpanded = true;
                    });
                    _cancelTimer();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: _isExpanded ? 16 : 12,
                  ),
                  decoration: BoxDecoration(
                    color: _isExpanded ? const Color(0xFFF2F2F7) : const Color(0xFF1E1E1E),
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
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: _isExpanded ? Border.all(color: Colors.grey.shade300) : null,
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
                                        color: _isExpanded ? primaryBlue : Colors.white,
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
                                    color: _isExpanded ? primaryBlue : Colors.white,
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
                      
                      // Expanded Details
                      if (_isExpanded) ...[
                        const SizedBox(height: 32),
                        const Text(
                          '7:00 - 8:00 p.m.',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '6 tareas pendientes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          '1 Hora',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
              
              // Action Menu (Context Menu style)
              if (_isExpanded)
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
                            _controller.reverse().then((_) => widget.onDismiss());
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
                            _controller.reverse().then((_) => widget.onDismiss());
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
