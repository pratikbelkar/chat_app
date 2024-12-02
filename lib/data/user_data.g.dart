// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      email: json['email'] as String?,
      createdOn: json['createdOn'] as String?,
      name: json['name'] as String?,
      profilepic: json['profilepic'] as String?,
      uid: json['uid'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'createdOn': instance.createdOn,
      'profilepic': instance.profilepic,
      'bio': instance.bio,
    };
