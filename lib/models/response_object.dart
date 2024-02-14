// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseObject {
  final int id;
  final String? name;

  ResponseObject({required this.id, this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ResponseObject.fromMap(Map<String, dynamic> map) {
    return ResponseObject(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseObject.fromJson(String source) =>
      ResponseObject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseObject(id: $id, name: $name)';
}
