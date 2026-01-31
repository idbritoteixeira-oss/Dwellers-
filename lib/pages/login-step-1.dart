import 'package:flutter/material.dart';
import '/nation.dart'; // Certifique-se que o caminho está correto

class LoginStep1 extends StatefulWidget {
  const LoginStep1({super.key});

  @override
  _LoginStep1State createState() => _LoginStep1State();
}

class _LoginStep1State extends State<LoginStep1> {
  final TextEditingController _idController = TextEditingController();
  String? _selectedNation;

  @override
  Widget build(BuildContext context) {
    // Só habilita o botão se houver Nação e um ID Público (geralmente longo)
    bool isIdValid = _idController.text.length >= 5 && _selectedNation != null;

    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("ENTRANCE", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 10),
              const Text("Selecione seu território e insira seu ID Público.", style: TextStyle(color: Colors.white38, fontSize: 12)),
              
              const SizedBox(height: 40),

              // DROPDOWN usando o seu isoNations oficial
              DropdownButtonFormField<String>(
                value: _selectedNation,
                dropdownColor: const Color(0xFF1D2A4E),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "TERRITÓRIO",
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0x1A1D2A4E),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1D2A4E))),
                ),
                // Usando o mapa importado do nation.dart
                items: isoNations.entries.map((e) => DropdownMenuItem(
                  value: e.key, 
                  child: Text(e.value, style: const TextStyle(fontSize: 14))
                )).toList(),
                onChanged: (val) => setState(() => _selectedNation = val),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: "PUBLIC ID",
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: "ID gerado no registro",
                  hintStyle: TextStyle(color: Colors.white10),
                  filled: true,
                  fillColor: Color(0x1A1D2A4E),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1D2A4E))),
                ),
                onChanged: (val) => setState(() {}),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isIdValid 
                    ? () => Navigator.pushNamed(context, '/login-step-2', arguments: {
                        'pub': _idController.text,
                        'nat': _selectedNation
                      })
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    disabledBackgroundColor: Colors.white10,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Text("VERIFICAR IDENTIDADE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
