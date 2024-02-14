// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenData {
  String token;
  UserData userData;
  TokenData({
    required this.token,
    required this.userData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userData': userData.toMap(),
    };
  }

  factory TokenData.fromMap(Map<String, dynamic> map) {
    return TokenData(
      token: map['token'] as String,
      userData: UserData.fromMap(map['userData'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenData.fromJson(String source) =>
      TokenData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserData {
  String name;
  int userId;
  int roleId;
  int goverId;
  int districtId;
  UserData({
    required this.name,
    required this.userId,
    required this.roleId,
    required this.goverId,
    required this.districtId,
  });

  UserData copyWith({
    String? name,
    int? userId,
    int? roleId,
    int? goverId,
    int? districtId,
  }) {
    return UserData(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      roleId: roleId ?? this.roleId,
      goverId: goverId ?? this.goverId,
      districtId: districtId ?? this.districtId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'roleId': roleId,
      'goverId': goverId,
      'districtId': districtId,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] as String,
      userId: map['userId'] as int,
      roleId: map['roleId'] as int,
      goverId: map['goverId'] as int,
      districtId: map['districtId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(name: $name, userId: $userId, roleId: $roleId, goverId: $goverId, districtId: $districtId)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.userId == userId &&
        other.roleId == roleId &&
        other.goverId == goverId &&
        other.districtId == districtId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        userId.hashCode ^
        roleId.hashCode ^
        goverId.hashCode ^
        districtId.hashCode;
  }
}
