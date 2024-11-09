import 'package:flutter/material.dart';
import '../components/navbar.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Center(
        child: Text(
          'Lira Music!',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'LiraFont', 
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addAlbum');
        },
      ),
    );
  }
}
