import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginStep2 extends StatefulWidget {
  const LoginStep2({super.key});

  @override
  _LoginStep2State createState() => _LoginStep2State();
}

class _LoginStep2State extends State<LoginStep2> {
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  // SOBERANIA: Captura o GeoIP real antes do login
  Future<Map<String, String>> _getGeoData() async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json')).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'ip': data['query'] ?? '0.0.0.0',
          'city': "${data['city']}, ${data['countryCode']}"
        };
      }
    } catch (_) {}
    return {'ip': '0.0.0.0', 'city': 'DESCONHECIDO'};
  }

  Future<void> _attemptLogin(String pubId, String nation) async {
    setState(() => _isLoading = true);

    try {
      // Reavaliação Cognitiva: Obtendo localização atual para atualização do .dat
      final geo = await _getGeoData();

      final response = await http.post(
        Uri.parse('https://8b48ce67-8062-40e3-be2d-c28fd3ae4f01-00-117turwazmdmc.janeway.replit.dev/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'pub': pubId,
          'key': _passController.text,
          'nat': nation,
          'geoip': geo['city'], // Envia a localização real
          'id': geo['ip'],      // Envia o IP real
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (!mounted) return;
        
        // Memória Consolidada: Dados completos para a Dashboard
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/dashboard', 
          (route) => false,
          arguments: data['data'] ?? data, // Garante o repasse da estrutura correta
        );
      } else {
        _showError(data['message'] ?? "Credenciais inválidas.");
      }
    } catch (e) {
      _showError("Erro de conexão com o Núcleo.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent)
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String pubId = args['pub'];
    final String nation = args['nat'];

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
              const SizedBox(height: 5),
              Text("ID: $pubId | TERRITÓRIO: $nation", style: const TextStyle(color: Colors.white24, fontSize: 10)),
              const SizedBox(height: 50),
              TextField(
                controller: _passController,
                obscureText: _obscure,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: Colors.white, letterSpacing: 10, fontSize: 20),
                onChanged: (v) => setState(() {}),
                decoration: InputDecoration(
                  labelText: "INSIRA SUA SENHA",
                  labelStyle: const TextStyle(color: Colors.white38),
                  counterStyle: const TextStyle(color: Colors.white10),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: Colors.white38),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (_passController.text.length == 6 && !_isLoading) 
                      ? () => _attemptLogin(pubId, nation) 
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    disabledBackgroundColor: Colors.white10,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: _isLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                      : const Text("ACESSAR SISTEMA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
