// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModelJson _$PostModelJsonFromJson(Map<String, dynamic> json) =>
    PostModelJson(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$PostModelJsonToJson(PostModelJson instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
