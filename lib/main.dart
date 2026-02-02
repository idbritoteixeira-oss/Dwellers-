import 'package:flutter/material.dart';
import 'pages/register-step-1.dart';
import 'pages/register-step-2.dart';
import 'pages/register-step-3.dart';
import 'pages/register-step-4.dart';
import 'pages/login-step-1.dart'; 
import 'pages/login-step-2.dart';
import 'pages/processing.dart'; 
import 'pages/dashboard.dart'; 
import 'pages/splash.dart';     
import 'style.dart';

void main() {
  // Inicialização vital para o AudioPlayer e Services do EnX OS
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DwellersApp());
}

class DwellersApp extends StatelessWidget {
  const DwellersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dwellers',
      theme: EnXStyle.theme,
      
      // O sistema desperta na Splash, que agora contém o Menu Principal
      initialRoute: '/splash', 
      
      routes: {
        // Agora o ponto de entrada único é a Splash unificada
        '/splash': (context) => const EnXSplashScreen(),
        
        // Fluxo de Login
        '/login-step-1': (context) => const LoginStep1(),
        '/login-step-2': (context) => const LoginStep2(),
        
        // Fluxo de Registro
        '/register-step-1': (context) => RegisterStep1(),
        '/register-step-2': (context) => RegisterStep2(),
        '/register-step-3': (context) => const RegisterStep3(),
        '/register-step-4': (context) => RegisterStep4(),
        
        // Processamento de Criptografia EnX18 / ID Public-Private
        '/processing': (context) => const ProcessingPage(),
        
        // Dashboard do Habitante
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
