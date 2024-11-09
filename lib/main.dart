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
        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(), 
      routes: {
        '/home': (context) => HomeScreen(), 
        '/addAlbum': (context) => AlbumForm(), 
        '/dashboard': (context) => DashboardScreen(), 
      },
    );
  }
}
