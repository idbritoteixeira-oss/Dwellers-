import 'package:flutter/material.dart';
import 'pages/index.dart';
import 'pages/register-step-1.dart';
import 'pages/register-step-2.dart';
import 'pages/register-step-3.dart';
import 'pages/register-step-4.dart';
import 'pages/login-step-1.dart'; 
import 'pages/login-step-2.dart';
import 'pages/processing.dart'; // Nova ponte de validação
import 'pages/dashboard.dart'; 
import 'pages/splash.dart';     // Tela de abertura com som intro
import 'style.dart';

void main() {
  // Garante que os plugins (como audioplayers) sejam inicializados antes do runApp
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DwellersApp());
}

class DwellersApp extends StatelessWidget {
  const DwellersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EnX Dwellers',
      theme: EnXStyle.theme,
      
      // O sistema agora desperta na SplashScreen
      initialRoute: '/splash', 
      
      routes: {
        '/splash': (context) => const EnXSplashScreen(),
        '/index': (context) => const IndexPage(),
        
        // Fluxo de Login
        '/login-step-1': (context) => const LoginStep1(),
        '/login-step-2': (context) => const LoginStep2(),
        
        // Fluxo de Registro
        '/register-step-1': (context) => RegisterStep1(),
        '/register-step-2': (context) => RegisterStep2(),
        '/register-step-3': (context) => const RegisterStep3(),
        '/register-step-4': (context) => RegisterStep4(),
        
        // O "Coração" da validação dos Frameworks
        '/processing': (context) => const ProcessingPage(),
        
        // Destino Final
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
