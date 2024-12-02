// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      message: json['message'] as String?,
      senderid: json['senderid'] as String?,
      reciverid: json['reciverid'] as String?,
      timestamp: json['timestamp'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'senderid': instance.senderid,
      'reciverid': instance.reciverid,
      'type': instance.type,
      'timestamp': instance.timestamp,
    };
