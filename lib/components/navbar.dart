import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Album Music App'),
      actions: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        IconButton(
          icon: Icon(Icons.library_music),
          onPressed: () => Navigator.pushNamed(context, '/dashboard'),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/addAlbum'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
