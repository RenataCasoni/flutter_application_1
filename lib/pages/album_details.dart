import 'package:flutter/material.dart';

class AlbumDetailsPage extends StatelessWidget {
  final Map<String, dynamic> album;

  AlbumDetailsPage({required this.album});

  @override
  Widget build(BuildContext context) {
    final tracks = List<String>.from(album['tracks'] ?? []); // Garante que tracks não é nulo e é uma lista de strings
    return Scaffold(
      appBar: AppBar(
        title: Text(album['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(album['cover']),
            SizedBox(height: 16),
            Text(
              album['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Artista: ${album['artist']}'),
            Text('Ano: ${album['year']}'),
            SizedBox(height: 16),
            Text(
              'Músicas:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tracks[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
