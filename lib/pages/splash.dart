import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class EnXSplashScreen extends StatefulWidget {
  const EnXSplashScreen({super.key});

  @override
  State<EnXSplashScreen> createState() => _EnXSplashScreenState();
}

class _EnXSplashScreenState extends State<EnXSplashScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _bootSystem();
  }

  Future<void> _bootSystem() async {
    // Toca o som de introdução (Caminho baseado no seu pubspec assets/sounds/)
    try {
      await _audioPlayer.play(AssetSource('sounds/into.mp3'));
    } catch (e) {
      debugPrint("Erro ao carregar áudio: $e");
    }

    // Tempo de exposição do logo antes de ir para a Index
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/index');
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      body: Center(
        child: Hero(
          tag: 'enx_logo',
          child: Image.asset(
            'assets/images/logo.png',
            width: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
