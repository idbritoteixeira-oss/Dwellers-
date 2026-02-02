import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      body: Stack(
        children: [
          // Sutil brilho de fundo - Ajustado para não sobrepor o logo
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1D2A4E).withOpacity(0.15),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          
          SafeArea( // Adicionado para garantir que o logo não fique sob a barra de status
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                children: [
                  const Spacer(flex: 5),
                  
                  // O LOGO - Adicionado height fixo e cache de renderização
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 180, 
                      height: 180, // Definir a altura evita que o Spacer o comprima a zero
                      fit: BoxFit.contain,
                      // Garante que o Flutter tente renderizar mesmo se houver pressão de memória
                      gaplessPlayback: true, 
                    ),
                  ),
                  
                  const Spacer(flex: 6),
                  
                  // Botão LOGIN
                  _buildMenuButton(
                    context, 
                    "ENTRAR NO SISTEMA", 
                    '/login-step-1', 
                    const Color(0xFF1D2A4E)
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Botão REGISTER
                  _buildMenuButton(
                    context, 
                    "NOVO HABITANTE", 
                    '/register-step-1', 
                    Colors.transparent,
                    showBorder: true
                  ),
                  
                  const Spacer(flex: 2),
                  
                  const Text(
                    "ENX OS SOBERANIA DIGITAL © 2026",
                    style: TextStyle(color: Colors.white10, fontSize: 8, letterSpacing: 2),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
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
