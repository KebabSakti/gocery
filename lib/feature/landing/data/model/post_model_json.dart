import 'package:gocery/feature/landing/domain/entity/post_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model_json.g.dart';

PostModelJson postfromJson(Map<String, dynamic> json) =>
    PostModelJson.fromJson(json);

Map<String, dynamic> postToJson() => PostModelJson().toJson();

@JsonSerializable()
class PostModelJson extends PostEntity {
  PostModelJson({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) : super(
          userId: userId,
          id: id,
          title: title,
          body: body,
        );

  factory PostModelJson.fromJson(Map<String, dynamic> json) =>
      _$PostModelJsonFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelJsonToJson(this);
}
