import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String studentId;
  final String studentPassword;
  final String role;
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.studentId,
    required this.studentPassword,
    required this.role,
  });
  

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? studentId,
    String? studentPassword,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      studentId: studentId ?? this.studentId,
      studentPassword: studentPassword ?? this.studentPassword,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'fullName': fullName});
    result.addAll({'email': email});
    result.addAll({'studentId': studentId});
    result.addAll({'studentPassword': studentPassword});
    result.addAll({'role': role});
  
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      studentId: map['studentId'] ?? '',
      studentPassword: map['studentPassword'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, email: $email, studentId: $studentId, studentPassword: $studentPassword, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.fullName == fullName &&
      other.email == email &&
      other.studentId == studentId &&
      other.studentPassword == studentPassword &&
      other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      studentId.hashCode ^
      studentPassword.hashCode ^
      role.hashCode;
  }
}


class Profile {
   final String user;
  final String fullName;
  final String bio;
  final String fieldOfStudy;
  final String profilePicture;
  Profile({
    required this.user,
    required this.fullName,
    required this.bio,
    required this.fieldOfStudy,
    required this.profilePicture,
  });

  Profile copyWith({
    String? user,
    String? fullName,
    String? bio,
    String? fieldOfStudy,
    String? profilePicture,
  }) {
    return Profile(
      user: user ?? this.user,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'user': user});
    result.addAll({'fullName': fullName});
    result.addAll({'bio': bio});
    result.addAll({'fieldOfStudy': fieldOfStudy});
    result.addAll({'profilePicture': profilePicture});
  
    return result;
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      user: map['user'] ?? '',
      fullName: map['fullName'] ?? '',
      bio: map['bio'] ?? '',
      fieldOfStudy: map['fieldOfStudy'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(user: $user, fullName: $fullName, bio: $bio, fieldOfStudy: $fieldOfStudy, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Profile &&
      other.user == user &&
      other.fullName == fullName &&
      other.bio == bio &&
      other.fieldOfStudy == fieldOfStudy &&
      other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return user.hashCode ^
      fullName.hashCode ^
      bio.hashCode ^
      fieldOfStudy.hashCode ^
      profilePicture.hashCode;
  }
}
