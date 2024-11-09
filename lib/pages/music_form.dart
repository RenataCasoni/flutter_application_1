import 'package:flutter/material.dart';
import '../models/music.dart';
import '../service/api_service.dart';


class MusicForm extends StatefulWidget {
  @override
  _MusicFormState createState() => _MusicFormState();
}

class _MusicFormState extends State<MusicForm> {
  final TextEditingController _songController = TextEditingController();
  bool isLoading = false;

  Future<void> _addMusic() async {
    setState(() {
      isLoading = true;
    });

    try {
      final songTitle = _songController.text;
      if (songTitle.isNotEmpty) {
        
        final albumData = await ApiService.fetchAlbumFromDeezer(songTitle);

        
        await ApiService.addAlbum(albumData);

        
        await ApiService.addSongs(albumData['tracks']);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Música e álbum adicionados com sucesso!'),
        ));
      }
    } catch (e) {
      print('Erro: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao adicionar música'),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Música'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _songController,
              decoration: InputDecoration(labelText: 'Título da Música'),
            ),
            SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _addMusic,
                    child: Text('Adicionar Música'),
                  ),
          ],
        ),
      ),
    );
  }
}
