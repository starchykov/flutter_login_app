import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_entity.g.dart';

@immutable
@JsonSerializable()
class Token {
  final String accessToken;

  const Token({required this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  String toString() {
    return 'Token{accessToken: $accessToken}';
  }
}
