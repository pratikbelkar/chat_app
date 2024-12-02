import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageData {
  final String? message;
  final String? senderid;
  final String? reciverid;
  final String? type;
  final String? timestamp;

  MessageData({
    this.message,
    this.senderid,
    this.reciverid,
    this.timestamp,
    this.type,
  });
  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
