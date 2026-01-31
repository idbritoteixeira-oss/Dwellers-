import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/nation.dart'; 

class RegisterStep1 extends StatefulWidget {
  @override
  _RegisterStep1State createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {
  String? selectedIso;
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sortedNations = isoNations.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("NATION SELECTION", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 20),
              
              // --- TUTORIAL BOX ---
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2A4E).withOpacity(0.1),
                  border: Border.all(color: const Color(0xFF1D2A4E), width: 0.5),
                ),
                child: const Text(
                  "GUIA DE IDENTIFICAÇÃO:\n1. Selecione sua nação de origem.\n2. Escolha um código numérico pessoal.\n3. O ID deve conter de 1 a 3 dígitos (001 a 999).",
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                ),
              ),

              const SizedBox(height: 30),
              
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1D2A4E),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "PAÍS DE ORIGEM",
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0xFF020306),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1D2A4E)), borderRadius: BorderRadius.zero),
                ),
                items: sortedNations.map((entry) {
                  return DropdownMenuItem(value: entry.key, child: Text(entry.value));
                }).toList(),
                onChanged: (value) => setState(() => selectedIso = value),
              ),
              
              const SizedBox(height: 20),
              
              TextField(
                controller: _idController,
                style: const TextStyle(color: Colors.white),
                maxLength: 3,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  counterStyle: const TextStyle(color: Colors.white30),
                  hintText: "ID (1-999)",
                  hintStyle: const TextStyle(color: Colors.white12),
                  prefixText: selectedIso != null ? "$selectedIso - " : "",
                  prefixStyle: const TextStyle(color: Color(0xFF1D2A4E), fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: const Color(0xFF1D2A4E).withOpacity(0.1),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1D2A4E)), borderRadius: BorderRadius.zero),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.zero),
                ),
                onChanged: (val) => setState(() {}),
              ),
              
              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (selectedIso != null && _idController.text.isNotEmpty) 
                    ? () {
                        // Memória Consolidada: Enviando argumentos para a Step 2
                        Navigator.pushNamed(
                          context, 
                          '/register-step-2',
                          arguments: {
                            'nation': selectedIso,
                            'id': _idController.text,
                          },
                        );
                      }
                    : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    disabledBackgroundColor: Colors.white10,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Text("PRÓXIMO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
