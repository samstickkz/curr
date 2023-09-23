class LoginResponse {
  LoginData? data;
  bool? successful;
  String? message;

  LoginResponse({this.data, this.successful, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    successful = json['successful'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['successful'] = this.successful;
    data['message'] = this.message;
    return data;
  }
}

class LoginData {
  String? token;
  bool? requireTwofaUrl;
  String? email;
  bool? requireTwofa;
  String? expiration;

  LoginData(
      {this.token,
        this.requireTwofaUrl,
        this.email,
        this.requireTwofa,
        this.expiration});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    requireTwofaUrl = json['requireTwofaUrl'];
    email = json['email'];
    requireTwofa = json['requireTwofa'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['requireTwofaUrl'] = this.requireTwofaUrl;
    data['email'] = this.email;
    data['requireTwofa'] = this.requireTwofa;
    data['expiration'] = this.expiration;
    return data;
  }
}
