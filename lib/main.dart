import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/dashboard_screen.dart';
import 'pages/album_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Álbuns e Músicas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Agora a HomeScreen é a tela inicial
      routes: {
        '/home': (context) => HomeScreen(),  // Rota para a HomeScreen
        '/addAlbum': (context) => AlbumForm(), // Rota para adicionar álbum
        '/dashboard': (context) => DashboardScreen(), // Rota para o dashboard
      },
    );
  }
}
