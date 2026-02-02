import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class ProcessingPage extends StatefulWidget {
  const ProcessingPage({super.key});

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  double _progress = 0.0;
  String _currentTask = "LOAD ENX_OS.SYS...";

  bool _dwellerReady = false;
  bool _inasxReady = false;
  bool _pigeonReady = false;
  bool _marketReady = false;

  @override
  void initState() {
    super.initState();
    // Pré-carrega o áudio no cache para evitar atraso na primeira execução
    _audioPlayer.setSource(AssetSource('sounds/sync.mp3'));
    _startSystemCheck();
  }

  // CORREÇÃO: Função de áudio robusta para disparos repetitivos
  Future<void> _playSyncSound() async {
    try {
      // Para o som atual e volta para o início instantaneamente
      await _audioPlayer.stop(); 
      await _audioPlayer.play(AssetSource('sounds/sync.mp3'), volume: 0.6);
    } catch (e) {
      debugPrint("Erro de sincronia de áudio: $e");
    }
  }

  Future<void> _startSystemCheck() async {
    // Pequena pausa inicial para o usuário se situar na tela
    await Future.delayed(const Duration(milliseconds: 1000));

    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    // 1. Dwellers - Frameworks/Dwellers/nation
    await _playSyncSound();
    setState(() {
      _dwellerReady = true;
      _progress = 0.25;
      _currentTask = "SYNCING DWELLER VAULT...";
    });
    await Future.delayed(const Duration(milliseconds: 1500));

    // 2. Inasx - Frameworks/Inasx/multiverse
    await _playSyncSound();
    setState(() {
      _inasxReady = true;
      _progress = 0.50;
      _currentTask = "CONNECTING INASX MULTIVERSE...";
    });
    await Future.delayed(const Duration(milliseconds: 1500));

    // 3. Pigeon - Frameworks/Pigeon/mailbox
    await _playSyncSound();
    setState(() {
      _pigeonReady = true;
      _progress = 0.75;
      _currentTask = "OPENING PIGEON TUNNEL...";
    });
    await Future.delayed(const Duration(milliseconds: 1500));

    // 4. FreeMarket - Frameworks/FreeMarket/seller
    await _playSyncSound();
    setState(() {
      _marketReady = true;
      _progress = 1.0;
      _currentTask = "FREE-MARKET READY";
    });

    // Boot Final do EnX OS
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/dashboard', arguments: args);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // O restante do build e _buildModuleStatus permanecem intactos como você pediu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'enx_logo',
                child: Image.asset('assets/images/enx.png', width: 60)
              ),
              const SizedBox(height: 50),
              Wrap(
                spacing: 25,
                runSpacing: 25,
                alignment: WrapAlignment.center,
                children: [
                  _buildModuleStatus('logo.png', "DWELLERS", _dwellerReady),
                  _buildModuleStatus('inx.png', "INASX", _inasxReady),
                  _buildModuleStatus('pig.png', "PIGEON", _pigeonReady),
                  _buildModuleStatus('mkt.png', "MARKET", _marketReady),
                ],
              ),
              const SizedBox(height: 60),
              Text(
                _currentTask,
                style: const TextStyle(color: Colors.white38, fontSize: 9, letterSpacing: 2, fontFamily: 'monospace'),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 1,
                  backgroundColor: Colors.white10,
                  color: const Color(0xFF1D2A4E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleStatus(String assetName, String label, bool isReady) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 400),
      scale: isReady ? 1.0 : 0.8,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isReady ? 1.0 : 0.05,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isReady ? const Color(0xFF1D2A4E).withOpacity(0.1) : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isReady ? const Color(0xFF1D2A4E) : Colors.white10,
                  width: 1
                ),
              ),
              child: Image.asset('assets/images/$assetName', width: 30, height: 30),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white24, fontSize: 7, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
