import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../lib/service/api_service.dart';

// Criação de uma classe Mock para HttpClient
class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    late MockClient client; // Use `late` para indicar que será inicializada no método `setUp`

    setUp(() {
      client = MockClient();
    });

    test('fetchAlbumFromDeezer retorna dados do álbum', () async {
      final albumName = 'Thriller';
      final searchUrl = 'https://api.deezer.com/search/album?q=$albumName';
      final detailsUrl = 'https://api.deezer.com/album/123';
      final responseSearch = {
        "data": [
          {
            "id": "123",
            "title": "Thriller"
          }
        ]
      };
      final responseDetails = {
        "title": "Thriller",
        "artist": {"name": "Michael Jackson"},
        "cover_big": "http://example.com/thriller.jpg",
        "release_date": "1982-11-30",
        "tracks": {
          "data": [
            {"title": "Wanna Be Startin' Somethin'", "preview": "http://example.com/preview1.mp3"},
            {"title": "Baby Be Mine", "preview": "http://example.com/preview2.mp3"}
          ]
        }
      };

      when(client.get(Uri.parse(searchUrl))).thenAnswer((_) async => http.Response(jsonEncode(responseSearch), 200));
      when(client.get(Uri.parse(detailsUrl))).thenAnswer((_) async => http.Response(jsonEncode(responseDetails), 200));

      final result = await ApiService.fetchAlbumFromDeezer(albumName);

      expect(result['name'], 'Thriller');
      expect(result['artist'], 'Michael Jackson');
      expect(result['cover'], 'http://example.com/thriller.jpg');
      expect(result['year'], '1982');
      expect(result['tracks'].length, 2);
    });

    test('addAlbum envia dados do álbum corretamente', () async {
      final albumData = {
        'name': 'Thriller',
        'artist': 'Michael Jackson',
        'cover': 'http://example.com/thriller.jpg',
        'year': '1982',
        'tracks': ['Wanna Be Startin\' Somethin\'', 'Baby Be Mine']
      };

      final albumUrl = Uri.parse('http://localhost:3000/albums');

      when(client.post(albumUrl, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 201));

      await ApiService.addAlbum(albumData);

      verify(client.post(
        albumUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(albumData),
      )).called(1);
    });

    test('addSongs envia dados das músicas corretamente', () async {
      final trackList = ['Wanna Be Startin\' Somethin\'', 'Baby Be Mine'];
      final songsUrl = Uri.parse('http://localhost:3000/songs');

      when(client.post(songsUrl, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 201));

      await ApiService.addSongs(trackList);

      for (var track in trackList) {
        verify(client.post(
          songsUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'title': track}),
        )).called(1);
      }
    });
  });
}
