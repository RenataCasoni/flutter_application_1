class Album {
  final int id;
  final String name;
  final String artist;
  final String cover;
  final int year;
  
  Album({
    required this.id,
    required this.name,
    required this.artist,
    required this.cover,
    required this.year,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      artist: json['artist'],
      cover: json['cover'],
      year: int.parse(json['release_date'].split('-')[0]),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'artist': artist,
        'cover': cover,
        'year': year,
      };
}
