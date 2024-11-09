import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/pages/album_details.dart';

void main() {
  group('AlbumDetailsPage', () {
    testWidgets('Exibe detalhes do álbum corretamente', (WidgetTester tester) async {
      final album = {
        'name': 'Thriller',
        'artist': 'Michael Jackson',
        'cover': 'http://example.com/thriller.jpg',
        'year': '1982',
        'tracks': [
          'Wanna Be Startin\' Somethin\'',
          'Baby Be Mine'
        ]
      };

      await tester.pumpWidget(MaterialApp(home: AlbumDetailsPage(album: album)));

      expect(find.text('Thriller'), findsOneWidget);
      expect(find.text('Michael Jackson'), findsOneWidget);
      expect(find.text('1982'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });
  });
}
