import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // Captura inteligente: Tenta pegar da raiz ou do objeto 'data' vindo do C++
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic> rawData = (args is Map<String, dynamic>) ? args : {};
    final Map<String, dynamic> data = rawData['data'] ?? rawData;

    return Scaffold(
      backgroundColor: const Color(0xFF020306),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com Logo e Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(
                    data['usernick']?.toString() ?? 'HABITANTE', 
                    data['status']?.toString() ?? 'OPERACIONAL'
                  ),
                  Hero(
                    tag: 'enx_logo',
                    child: Image.asset('assets/images/logo.png', width: 40),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Container de Identidade Rápida
              _buildIdentityBar(data['pub']?.toString() ?? '---'),
              
              const SizedBox(height: 30),

              // Grade de Dados do Sistema
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  children: [
                    _item("NATION", data['nat']),
                    _item("GEOIP", data['geoip']),
                    _item("DATETIME", data['datetime']),
                    _item("ID_INASX", data['id_inasx']),
                    _item("ID_PIGEON", data['id_pigeon']),
                    _item("ID_MARKET", data['id_market']),
                  ],
                ),
              ),

              const Divider(color: Colors.white10),
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("ENX CORE v1.0", 
                    style: TextStyle(color: Colors.white10, fontSize: 9, letterSpacing: 2)),
                  IconButton(
                    icon: const Icon(Icons.power_settings_new, color: Colors.redAccent, size: 18),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/index'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String nick, String status) {
    bool isOp = status.toUpperCase() == "OPERACIONAL";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nick.toUpperCase(), 
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.circle, color: isOp ? Colors.greenAccent : Colors.redAccent, size: 7),
            const SizedBox(width: 8),
            Text(status, 
              style: TextStyle(
                color: isOp ? Colors.greenAccent : Colors.redAccent, 
                fontSize: 10, 
                fontWeight: FontWeight.w600, 
                letterSpacing: 1
              )
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIdentityBar(String pubId) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D2A4E).withOpacity(0.1),
        border: const Border(left: BorderSide(color: Color(0xFF1D2A4E), width: 3))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("PUBLIC_ID", style: TextStyle(color: Colors.white38, fontSize: 9)),
          Text(pubId, style: const TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _item(String label, dynamic value) {
    String displayValue = (value == null || value.toString().isEmpty || value == "0") ? "---" : value.toString();
    
    return GestureDetector(
      onLongPress: () {
        if (displayValue != "---") {
          Clipboard.setData(ClipboardData(text: displayValue));
          HapticFeedback.heavyImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$label COPIADO PARA O CLIPBOARD"),
              backgroundColor: const Color(0xFF1D2A4E),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white24, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 6),
          Text(
            displayValue, 
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 14, 
              fontWeight: FontWeight.bold, 
              fontFamily: 'monospace'
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
