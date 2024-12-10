import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback onFinish;

  const CountdownTimer({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onFinish,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  String timeRemaining = '';

  @override
  void initState() {
    super.initState();
    // Initial update
    _updateTimeRemaining();

    // Start the timer to update the countdown every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTimeRemaining();
    });
  }

  // Function to calculate and update the remaining time
  void _updateTimeRemaining() {
    final now = DateTime.now();
    final difference = widget.endTime.difference(now);

    if (difference.isNegative) {
      // If the target time has passed, stop the timer and call the onFinish callback
      _timer.cancel();
      setState(() {
        timeRemaining = 'Time has passed';
      });
      widget.onFinish(); // Call the onFinish action
    } else {
      setState(() {
        timeRemaining =
            '${difference.inDays}d ${difference.inHours % 24}h ${difference.inMinutes % 60}m ${difference.inSeconds % 60}s';
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Remaining time: $timeRemaining",
      style: const TextStyle(fontSize: 16),
    );
  }
}
