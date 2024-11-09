import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service/api_service.dart';
import 'album_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> albums = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    try {
      print('Iniciando carregamento dos álbuns');
      final response = await http.get(Uri.parse('${ApiService.baseUrl}/albums'));
      print('Status da resposta: ${response.statusCode}');
      print('Corpo da resposta: ${response.body}');
      
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        print('Álbuns carregados com sucesso');
        final List<dynamic> albumList = json.decode(response.body);
        setState(() {
          albums = albumList.cast<Map<String, dynamic>>().map((album) => {
            ...album,
            'tracks': List<String>.from(album['tracks'] ?? []),  // Garante que tracks é uma lista de strings
          }).toList();
          print('Álbuns carregados na Dashboard: $albums'); // Adiciona log para depuração
        });
      } else {
        print('Erro ao carregar álbuns: ${response.statusCode}');
        throw Exception('Erro ao carregar álbuns');
      }
    } catch (e) {
      print('Erro ao carregar álbuns: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Construindo UI do Dashboard');
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: albums.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(album['cover']),
                      title: Text(album['name']),
                      subtitle: Text('Artista: ${album['artist']}'),
                      trailing: Text('Ano: ${album['year']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlbumDetailsPage(album: album),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
