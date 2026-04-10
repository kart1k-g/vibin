// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class SongModel {
  final String id;
  final String song_name;
  final String hex_code;
  final String song_url;
  final String thumbnail_url;
  final String artist;

  SongModel({
    required this.id,
    required this.song_name,
    required this.hex_code,
    required this.song_url,
    required this.thumbnail_url,
    required this.artist,
  });

  SongModel copyWith({
    String? id,
    String? song_name,
    String? hex_code,
    String? song_url,
    String? thumbnail_url,
    String? artist,
  }) {
    return SongModel(
      id: id ?? this.id,
      song_name: song_name ?? this.song_name,
      hex_code: hex_code ?? this.hex_code,
      song_url: song_url ?? this.song_url,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      artist: artist ?? this.artist,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': song_name,
      'hexcode': hex_code,
      'audioUrl': song_url,
      'thumbnailUrl': thumbnail_url,
      'artist': artist,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] ?? '',
      song_name: map['name'] ?? '',
      hex_code: map['hexcode'] ?? '',
      song_url: map['audioUrl'] ?? '',
      thumbnail_url: map['thumbnailUrl'] ?? '',
      artist: map['artist'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) => SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(id: $id, song_name: $song_name, hex_code: $hex_code, song_url: $song_url, thumbnail_url: $thumbnail_url, artist: $artist)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.song_name == song_name &&
      other.hex_code == hex_code &&
      other.song_url == song_url &&
      other.thumbnail_url == thumbnail_url &&
      other.artist == artist;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      song_name.hashCode ^
      hex_code.hashCode ^
      song_url.hashCode ^
      thumbnail_url.hashCode ^
      artist.hashCode;
  }
}
