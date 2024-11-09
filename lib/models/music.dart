class Music {
  final int id;
  final String name;
  final String albumId; 
  final String artist;
  final String previewUrl;
  
  Music({
    required this.id,
    required this.name,
    required this.albumId,
    required this.artist,
    required this.previewUrl,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'],
      name: json['name'],
      albumId: json['albumId'],
      artist: json['artist'],
      previewUrl: json['previewUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'albumId': albumId,
      'artist': artist,
      'previewUrl': previewUrl,
    };
  }
}
