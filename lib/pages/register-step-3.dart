import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class RegisterStep3 extends StatefulWidget {
  const RegisterStep3({super.key});

  @override
  _RegisterStep3State createState() => _RegisterStep3State();
}

class _RegisterStep3State extends State<RegisterStep3> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscure = true;
  bool _isLoading = false;

  Future<void> _sendToIntegration() async {
    // MEMÓRIA CONSOLIDADA: Captura Nation, ID e Nick vindos das telas anteriores
    final Map<String, dynamic>? args = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (args == null) {
      _showSnackbar("Erro: Dados de origem não encontrados.");
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      // SOBERANIA: O JSON agora envia o pacote completo para o C++
      final response = await http.post(
        Uri.parse('https://8b48ce67-8062-40e3-be2d-c28fd3ae4f01-00-117turwazmdmc.janeway.replit.dev/integration'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nick': args['nick'],
          'nat': args['nation'],
          'id': args['id'], // Novo dado incluído na varredura
          'key': _passController.text,
        }),
      ).timeout(const Duration(seconds: 15)); // Evita o "girar" infinito

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (mounted) {
          Navigator.pushNamed(context, '/register-step-4', arguments: data);
        }
      } else {
        _showSnackbar(data['message'] ?? "Portal EnX: Acesso Negado");
      }
    } catch (e) {
      _showSnackbar("Falha de conexão: Verifique se o Portal está Online");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    bool isReady = _passController.text.length == 6 && 
                  _passController.text == _confirmController.text;

    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SECURITY KEY", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 40),
              _buildField(_passController, "PASSWORD (6 DÍGITOS)", true),
              const SizedBox(height: 20),
              _buildField(_confirmController, "CONFIRM PASSWORD", false),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (isReady && !_isLoading) ? _sendToIntegration : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    disabledBackgroundColor: Colors.white10,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                    : const Text("FINALIZAR REGISTRO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, bool suffix) {
    return TextField(
      controller: ctrl,
      obscureText: _obscure,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      maxLength: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0x1A1D2A4E),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1D2A4E))),
        suffixIcon: suffix ? IconButton(
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: Colors.white38),
          onPressed: () => setState(() => _obscure = !_obscure),
        ) : null,
      ),
      onChanged: (val) => setState(() {}),
    );
  }
}
