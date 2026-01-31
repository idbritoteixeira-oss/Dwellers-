import 'package:http/http.dart' as http;
import 'dart:convert';

class EnXService {
  static const String _baseUrl = 'https://8b48ce67-8062-40e3-be2d-c28fd3ae4f01-00-117turwazmdmc.janeway.replit.dev';

  // Função privada para capturar o IP e Localização real sem inflar o APK
  static Future<Map<String, String>> _getGeoData() async {
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

  static Future<Map<String, dynamic>?> sendIntegration({
    required String nick,
    required String key,
    required String nat,
  }) async {
    try {
      // Reavaliação Cognitiva: Captura os dados reais antes de enviar
      final geo = await _getGeoData();

      final response = await http.post(
        Uri.parse('$_baseUrl/integration'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nick': nick,
          'key': key,
          'nat': nat,
          'geoip': geo['city'], // Envia a localização (Ex: São Paulo, BR)
          'id': geo['ip'],      // Envia o IP real para o log do servidor
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Erro de conexão EnX: $e");
    }
    return null;
  }
}
