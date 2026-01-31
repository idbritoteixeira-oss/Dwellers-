import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterStep4 extends StatelessWidget {
  const RegisterStep4({super.key});

  String _formatPrivateId(String id) {
    if (id.isEmpty || id == "0") return "PENDENTE";
    String cleanId = id.replaceAll("-", "");
    return cleanId.replaceAllMapped(
      RegExp(r".{4}"), 
      (match) => "${match.group(0)}-").replaceAll(RegExp(r"-$"), ""
    );
  }

  @override
  Widget build(BuildContext context) {
    // Captura segura dos dados retornados pelo servidor C++
    final dynamic rawArgs = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic> args = (rawArgs is Map<String, dynamic>) ? rawArgs : {};
    
    // IDs recebidos da integração
    final String publicId = (args['pub'] ?? args['public_id'] ?? "0").toString();
    final String privateId = _formatPrivateId((args['priv'] ?? args['private_id'] ?? "0").toString());

    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        automaticallyImplyLeading: false, 
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "IDENTITY RECEIPT", 
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D2A4E).withOpacity(0.1),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.5), width: 0.5),
                ),
                child: const Text(
                  "ALERTA DE SEGURANÇA:\n1. O ID PRIVADO é a sua chave digital.\n2. Se perder este código, o acesso será revogado.\n3. Nunca compartilhe estes dados.",
                  style: TextStyle(color: Colors.redAccent, fontSize: 11, height: 1.5, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 40),

              _buildIdCard("ID PÚBLICO (VISÍVEL)", publicId, Icons.public),
              const SizedBox(height: 20),
              _buildIdCard("ID PRIVADO (CHAVE MESTRA)", privateId, Icons.vpn_key),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // SOBERANIA: Em vez de voltar ao início, envia o habitante direto para a Dashboard
                    // Passando os argumentos 'args' que contêm o GeoIP e IDs recebidos do servidor.
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/processing', 
                      (route) => false,
                      arguments: args, 
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A4E),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Text(
                    "CONCLUIR E ENTRAR", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdCard(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(color: Color(0x1A1D2A4E)),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF1D2A4E), size: 18),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  value, 
                  style: const TextStyle(color: Colors.white, fontFamily: 'Courier', fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.copy, color: Colors.white24, size: 18),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: value));
                    HapticFeedback.lightImpact(); // Pequena vibração ao copiar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("COPIADO"), duration: Duration(seconds: 1)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
