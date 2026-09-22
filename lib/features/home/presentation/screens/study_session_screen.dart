import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';
import '../../../../shared/widgets/layouts/apple_finish_task_dialog.dart';

class StudySessionScreen extends StatefulWidget {
  final String title;
  final String taskName;
  final Color accentColor;

  const StudySessionScreen({
    super.key,
    required this.title,
    required this.taskName,
    required this.accentColor,
  });

  @override
  State<StudySessionScreen> createState() => _StudySessionScreenState();
}

class _StudySessionScreenState extends State<StudySessionScreen> with SingleTickerProviderStateMixin {
  late Timer _timer;
  Duration _timeLeft = const Duration(hours: 1);

  // Animation for the long-press button
  late AnimationController _progressController;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft = _timeLeft - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // 2 seconds hold to finish
    );

    _progressController.addListener(() {
      setState(() {});
      if (_progressController.isCompleted) {
        // Finish task
        _finishTask();
      }
    });
  }

  void _finishTask() {
    showAppleFinishTaskDialog(context, onConfirm: () {
      _timer.cancel();
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _progressController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF007AFF);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: WebLayout(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // Pill Container for Title
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: widget.accentColor, width: 1.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.grey.shade200,
                      ],
                    ),
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: widget.accentColor,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Task details (Left aligned)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.taskName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Link: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'coursera.org/learn/ux-experie...',
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(flex: 2),
                
                // Timer Icon
                Icon(
                  CupertinoIcons.timer, // Placeholder for the exact icon
                  size: 60,
                  color: primaryBlue,
                ),
                const SizedBox(height: 16),
                
                // Timer Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tiempo ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      _timeLeft.inHours == 1 && _timeLeft.inMinutes == 60 ? '1 HORA' : _formatDuration(_timeLeft),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Schedule
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '7:00 p.m.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 24),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 24),
                    Text(
                      '8:00 p.m.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                
                const Spacer(flex: 2),
                
                // Hold-to-finish Button
                GestureDetector(
                  onTapDown: (_) {
                    setState(() => _isHolding = true);
                    _progressController.forward();
                  },
                  onTapUp: (_) {
                    setState(() => _isHolding = false);
                    _progressController.reverse();
                  },
                  onTapCancel: () {
                    setState(() => _isHolding = false);
                    _progressController.reverse();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.diagonal3Values(_isHolding ? 0.95 : 1.0, _isHolding ? 0.95 : 1.0, 1.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background Pill
                        Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        // Fill progress
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 200 * _progressController.value,
                            decoration: BoxDecoration(
                              color: const Color(0xFF004499), // Darker blue
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        // Text
                        const Text(
                          'Finalizar tarea',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                const Text(
                  'Manten presionado para finalizar',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
