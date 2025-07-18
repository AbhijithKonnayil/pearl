import 'package:flutter/material.dart';

enum Tag { New, Old, Hot }

Map<Tag, Color> tagColor = {
  Tag.Hot: Colors.red,
  Tag.New: Colors.blue,
  Tag.Old: Colors.pink,
};

class Item {
  final String title;
  bool isFav;
  DateTime timestamp;
  Tag tag;

  Item({
    required this.title,
    this.isFav = false,
    DateTime? timestamp,
    this.tag = Tag.New,
  }) : timestamp = timestamp ?? DateTime.now();

  Item.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      isFav = json['isFav'] ?? false,
      timestamp = DateTime.parse(json['timestamp']),
      tag = Tag.values.byName(json['tag']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isFav': isFav,
      'timestamp': timestamp.toIso8601String(),
      'tag': tag.name,
    };
  }
}
