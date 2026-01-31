import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      body: Stack(
        children: [
          // Sutil brilho de fundo para destacar o logo
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1D2A4E).withOpacity(0.1),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Column(
              children: [
                const Spacer(flex: 5),
                
                // O LOGO substitui a biometria e o texto "DWELLERS"
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 180, // Tamanho de destaque
                    fit: BoxFit.contain,
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
