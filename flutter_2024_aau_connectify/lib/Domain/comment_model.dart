import 'dart:convert';

class Comment {
  /* {"
  _id":"66603c7cbc5e647c8f005cc7",
  "content":"this is a comment",
  "userId":"6654898984d7632cf314011e",
  "announcementId":"6659c2aa873a77f0ed228a6e","
  __v":0
  } */
  final String id;
  final String content;
  final String userId;
  final String announcementId;
  final String fullName; 
  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.announcementId,
    required this.fullName,
  });
  

  Comment copyWith({
    String? id,
    String? content,
    String? userId,
    String? announcementId,
    String? fullName,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      announcementId: announcementId ?? this.announcementId,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'content': content});
    result.addAll({'userId': userId});
    result.addAll({'announcementId': announcementId});
    result.addAll({'fullName': fullName});
  
    return result;
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['_id'] ?? '',
      content: map['content'] ?? '',
      userId: map['userId']['_id'] ?? '',
      announcementId: map['announcementId'] ?? '',
      fullName: map['userId']['fullName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, userId: $userId, announcementId: $announcementId, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Comment &&
      other.id == id &&
      other.content == content &&
      other.userId == userId &&
      other.announcementId == announcementId &&
      other.fullName == fullName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      content.hashCode ^
      userId.hashCode ^
      announcementId.hashCode ^
      fullName.hashCode;
  }
}
