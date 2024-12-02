import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final String? uid;
  final String? email;
  final String? name;
  final String? createdOn;
  final String? profilepic;
  final String? bio;

  UserData(
      {this.email,
      this.createdOn,
      this.name,
      this.profilepic,
      this.uid,
      this.bio});

  // ignore: non_constant_identifier_names
  factory UserData.fromJson(Map<String, dynamic> Json) =>
      _$UserDataFromJson(Json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
