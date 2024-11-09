import 'package:flutter/material.dart';
import '../models/album.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final VoidCallback onTap;

  AlbumCard({required this.album, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Image.network(
              album.cover,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 150),
            ),
            ListTile(
              title: Text(album.name),
              subtitle: Text(album.artist),
            ),
          ],
        ),
      ),
    );
  }
}
