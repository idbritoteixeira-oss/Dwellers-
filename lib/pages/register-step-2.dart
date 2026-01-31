import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterStep2 extends StatefulWidget {
  @override
  _RegisterStep2State createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  final TextEditingController _nickController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // REAVALIAÇÃO: Captura os dados que vieram da Step 1
    final Map<String, dynamic>? args = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("USERNICK", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2A4E).withOpacity(0.1),
                  border: Border.all(color: const Color(0xFF1D2A4E), width: 0.5),
                ),
                child: const Text(
                  "GUIA DE IDENTIDADE:\n1. O UserNick é seu nome público.\n2. Apenas letras, números e underline (_).\n3. Mínimo de 3 caracteres.",
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: _nickController,
                style: const TextStyle(color: Colors.white),
                maxLength: 16,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
                ],
                decoration: const InputDecoration(
                  labelText: "NOME DE EXIBIÇÃO",
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: "Ex: EnX_Dweller",
                  hintStyle: TextStyle(color: Colors.white12),
                  filled: true,
                  fillColor: Color(0x1A1D2A4E),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1D2A4E))),
                ),
                onChanged: (val) => setState(() {}),
              ),
              
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _nickController.text.length >= 3 
                    ? () {
                        // PARIDADE: Repassa Nation/ID da Step 1 + o novo Nick
                        Navigator.pushNamed(
                          context, 
                          '/register-step-3',
                          arguments: {
                            'nation': args?['nation'] ?? '??',
                            'id': args?['id'] ?? '000',
                            'nick': _nickController.text,
                          },
                        );
                      }
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    disabledBackgroundColor: Colors.white10,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Text("VINCULAR IDENTIDADE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
