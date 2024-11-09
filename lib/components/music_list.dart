import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchAlbumFromDeezer(String albumName) async {
  final searchUrl = 'https://api.deezer.com/search/album?q=$albumName';
  
  final responseSearch = await http.get(Uri.parse(searchUrl));

  if (responseSearch.statusCode == 200) {
    final dataSearch = jsonDecode(responseSearch.body);
    
    if (dataSearch['data'] == null || dataSearch['data'].isEmpty) {
      throw Exception('Nenhum álbum encontrado.');
    }

    final album = dataSearch['data'][0];
    final albumId = album['id'];

    final albumDetailsUrl = 'https://api.deezer.com/album/$albumId';
    final responseDetails = await http.get(Uri.parse(albumDetailsUrl));

    if (responseDetails.statusCode == 200) {
      final dataDetails = jsonDecode(responseDetails.body);
      return {
        'name': dataDetails['title'],
        'artist': dataDetails['artist']['name'],
        'cover': dataDetails['cover_big'],
        'year': dataDetails['release_date'].split('-')[0],
        'tracks': dataDetails['tracks']['data'].map((track) => track['title']).toList(),
      };
    } else {
      throw Exception('Erro ao buscar detalhes do álbum');
    }
  } else {
    throw Exception('Erro ao buscar álbum');
  }
}
