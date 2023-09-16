import 'dart:convert';

ResModel resModelFromJson(String str) => ResModel.fromJson(json.decode(str));
String resModelToJson(ResModel data) => json.encode(data.toJson());

String resModelDataToString(dynamic data) => json.encode(data);
dynamic resModelDataToJson(String data) => json.decode(data);

class ResModel {
  // dynamic? data;
  bool? successful;
  String? message;

  ResModel({this.successful, this.message});

  ResModel.fromJson(Map<String, dynamic> json) {
    // data = json['data'];
    successful = json['successful'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['data'] = this.data;
    data['successful'] = this.successful;
    data['message'] = this.message;
    return data;
  }
}