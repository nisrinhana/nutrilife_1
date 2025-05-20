import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrilife/services/api_service.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Exercise exercise;
  int _secondsLeft = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Exercise?;
    if (args != null) {
      exercise = args;
      _secondsLeft = exercise.duration; // Set durasi awal dari exercise
    } else {
      Navigator.pop(context); // Kembali jika tidak ada argumen
    }
  }

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_secondsLeft > 0) {
            _secondsLeft--;
          } else {
            _timer?.cancel();
            _isRunning = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Latihan selesai!')),
            );
            // Opsional: Panggil API untuk menyimpan status selesai
            // ApiService().completeExercise(exercise.id, true);
          }
        });
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      _secondsLeft = exercise.duration;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exercise.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '${_secondsLeft ~/ 60}:${(_secondsLeft % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : startTimer,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _isRunning ? stopTimer : null,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}