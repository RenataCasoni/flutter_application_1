import 'package:flutter/material.dart';
import '../service/api_service.dart';

class AlbumForm extends StatefulWidget {
  @override
  _AlbumFormState createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  final TextEditingController _albumController = TextEditingController();
  bool _isLoading = false;
  String? _statusMessage;

  Future<void> _searchAndAddAlbum() async {
    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      final albumName = _albumController.text;
      if (albumName.isNotEmpty) {
        final albumData = await ApiService.fetchAlbumFromDeezer(albumName);

        await ApiService.addAlbum(albumData);

        await ApiService.addSongs(albumData['tracks']);

        setState(() {
          _statusMessage = 'Álbum e músicas adicionados com sucesso!';
        });
      } else {
        setState(() {
          _statusMessage = 'Por favor, insira o nome do álbum.';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Erro ao adicionar álbum: $e';
      });
      print('Erro: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar e Adicionar Álbum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _albumController,
              decoration: InputDecoration(labelText: 'Nome do Álbum'),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _searchAndAddAlbum,
                    child: Text('Adicionar Álbum'),
                  ),
            SizedBox(height: 16),
            if (_statusMessage != null)
              Text(
                _statusMessage!,
                style: TextStyle(color: _statusMessage == 'Álbum e músicas adicionados com sucesso!' ? Colors.green : Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
