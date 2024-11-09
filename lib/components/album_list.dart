import 'package:flutter/material.dart';
import '../models/album.dart';
import 'album_card.dart';

class AlbumList extends StatelessWidget {
  final List<Album> albums;

  AlbumList({required this.albums});

  @override
  Widget build(BuildContext context) {
    return albums.isEmpty
        ? Center(child: Text('Nenhum álbum disponível'))
        : ListView.builder(
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return AlbumCard(
                album: album,
                onTap: () {
                  // Defina a ação ao clicar no álbum
                },
              );
            },
          );
  }
}
