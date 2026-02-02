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
  bool _showMenu = false; // Controla quando os botões aparecem

  @override
  void initState() {
    super.initState();
    _bootSystem();
  }

  Future<void> _bootSystem() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/into.mp3'));
    } catch (e) {
      debugPrint("Erro ao carregar áudio: $e");
    }

    // Tempo do áudio e da animação de boot
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _showMenu = true; // Libera o menu na mesma tela
        });
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
      body: Stack(
        children: [
          // Brilho de fundo que surge com o menu
          AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: _showMenu ? 0.15 : 0.0,
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1D2A4E),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo animado: Sobe quando o menu aparece
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(bottom: _showMenu ? 40 : 0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png', // Verifique se o path está correto (assets/images/ ou assets/)
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Menu que aparece após o som
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: _showMenu ? 1.0 : 0.0,
                  child: _showMenu 
                    ? Column(
                        children: [
                          _buildMenuButton(
                            context, 
                            "ENTRAR NO SISTEMA", 
                            '/login-step-1', 
                            const Color(0xFF1D2A4E)
                          ),
                          const SizedBox(height: 15),
                          _buildMenuButton(
                            context, 
                            "NOVO HABITANTE", 
                            '/register-step-1', 
                            Colors.transparent,
                            showBorder: true
                          ),
                          const SizedBox(height: 50),
                          const Text(
                            "ENX OS SOBERANIA DIGITAL © 2026",
                            style: TextStyle(color: Colors.white10, fontSize: 8, letterSpacing: 2),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, String route, Color bgColor, {bool showBorder = false}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: showBorder ? const BorderSide(color: Colors.white24) : BorderSide.none,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
    );
  }
}
