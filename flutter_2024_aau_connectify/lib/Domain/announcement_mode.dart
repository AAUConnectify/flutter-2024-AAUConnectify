import 'dart:convert';

class Announcement {
  final String id;
  final String title;
  final String content;
  final String category;
  final String summary;
  final String date;
  final String image;
  final String tag;
  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.summary,
    required this.date,
    required this.image,
    required this.tag,
  });

  Announcement copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    String? summary,
    String? date,
    String? image,
    String? tag,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      summary: summary ?? this.summary,
      date: date ?? this.date,
      image: image ?? this.image,
      tag: tag ?? this.tag,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'_id': id});
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'category': category});
    result.addAll({'summary': summary});
    result.addAll({'date': date});
    result.addAll({'image': image});
    result.addAll({'tag': tag});
  
    return result;
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '',
      summary: map['summary'] ?? '',
      date: map['date'] ?? '',
      image: map['image'] ?? '',
      tag: map['tag'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) => Announcement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Announcement(id: $id, title: $title, content: $content, category: $category, summary: $summary, date: $date, image: $image, tag: $tag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Announcement &&
      other.id == id &&
      other.title == title &&
      other.content == content &&
      other.category == category &&
      other.summary == summary &&
      other.date == date &&
      other.image == image &&
      other.tag == tag;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      category.hashCode ^
      summary.hashCode ^
      date.hashCode ^
      image.hashCode ^
      tag.hashCode;
  }
}
