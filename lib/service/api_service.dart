import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';
  static const String corsProxy = 'https://cors-anywhere.herokuapp.com/';

  static Future<Map<String, dynamic>> fetchAlbumFromDeezer(String albumName) async {
    final encodedAlbumName = Uri.encodeQueryComponent(albumName);
    final searchUrl = 'https://api.deezer.com/search/album?q=$encodedAlbumName';

    try {
      final responseSearch = await http.get(Uri.parse('$corsProxy$searchUrl'));
      print('Status da resposta da busca: ${responseSearch.statusCode}');
      print('Corpo da resposta da busca: ${responseSearch.body}');

      if (responseSearch.statusCode == 200) {
        final dataSearch = jsonDecode(responseSearch.body);
        if (dataSearch['data'] == null || dataSearch['data'].isEmpty) {
          throw Exception('Nenhum álbum encontrado.');
        }

        final album = dataSearch['data'][0];
        final albumId = album['id'];

        final albumDetailsUrl = 'https://api.deezer.com/album/$albumId';
        final responseDetails = await http.get(Uri.parse('$corsProxy$albumDetailsUrl'));
        print('Status da resposta dos detalhes: ${responseDetails.statusCode}');
        print('Corpo da resposta dos detalhes: ${responseDetails.body}');

        if (responseDetails.statusCode == 200) {
          final dataDetails = jsonDecode(responseDetails.body);
          final tracks = List<String>.from(dataDetails['tracks']['data'].map((track) => track['title']));
          return {
            'name': dataDetails['title'],
            'artist': dataDetails['artist']['name'],
            'cover': dataDetails['cover_big'],
            'year': dataDetails['release_date'].split('-')[0],
            'tracks': tracks,
          };
        } else {
          throw Exception('Erro ao buscar detalhes do álbum');
        }
      } else {
        throw Exception('Erro ao buscar álbum');
      }
    } catch (e) {
      print('Exceção em fetchAlbumFromDeezer: $e');
      rethrow;
    }
  }

  static Future<void> addAlbum(Map<String, dynamic> albumData) async {
    final albumUrl = '$baseUrl/albums';

    try {
      final response = await http.post(
        Uri.parse(albumUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': albumData['name'],
          'artist': albumData['artist'],
          'cover': albumData['cover'],
          'year': albumData['year'],
          'tracks': albumData['tracks'],
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Erro ao adicionar o álbum');
      }
    } catch (e) {
      print('Exceção em addAlbum: $e');
      rethrow;
    }
  }

  static Future<void> addSongs(List<String> trackList) async {
    final songsUrl = '$baseUrl/songs';

    try {
      for (var track in trackList) {
        final response = await http.post(
          Uri.parse(songsUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'title': track}),
        );

        if (response.statusCode != 201) {
          throw Exception('Erro ao adicionar a música: $track');
        }
      }
    } catch (e) {
      print('Exceção em addSongs: $e');
      rethrow;
    }
  }
}
