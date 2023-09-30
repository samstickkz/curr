class LoginResponse {
  String? token;
  String? refreshToken;
  String? refreshTokenExpiryTime;

  LoginResponse({this.token, this.refreshToken, this.refreshTokenExpiryTime});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiryTime = json['refreshTokenExpiryTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpiryTime'] = this.refreshTokenExpiryTime;
    return data;
  }
}