import 'package:flutter/material.dart';

class DBUserModel {
  int userId;
  String email;
  int phoneNumber;
  DateTime createdTimestamp;
  String createdBy;
  DateTime modifiedTimestamp;
  String modifiedBy;
  DateTime lastUserActivityTimestamp;

  DBUserModel(
      {this.userId,
      this.email,
      this.phoneNumber,
      this.createdTimestamp,
      this.createdBy,
      this.modifiedTimestamp,
      this.modifiedBy,
      this.lastUserActivityTimestamp});

  DBUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    createdTimestamp = json['created_timestamp'];
    createdBy = json['created_by'];
    modifiedTimestamp = json['modified_timestamp'];
    modifiedBy = json['modified_by'];
    lastUserActivityTimestamp = json['last_user_activity_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['created_timestamp'] = this.createdTimestamp.toString();
    data['created_by'] = this.createdBy;
    data['modified_timestamp'] = this.modifiedTimestamp.toString();
    data['modified_by'] = this.modifiedBy;
    data['last_user_activity_timestamp'] = this.lastUserActivityTimestamp.toString();
    return data;
  }
}