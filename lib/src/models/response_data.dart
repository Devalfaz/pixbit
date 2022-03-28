class AccessToken {
/*
{
  "token_type": "Bearer",
  "access_token": "xRlWo638w6FlR9wvC72kEGkxhoQOA0GR4S7wJmsFp4uxUXFP3TESqZGm4zzGZ4sp59bNiTikFCqkj8gD"
} 
*/

  String? tokenType;
  String? accessToken;

  AccessToken({
    this.tokenType,
    this.accessToken,
  });
  AccessToken.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type']?.toString();
    accessToken = json['access_token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token_type'] = tokenType;
    data['access_token'] = accessToken;
    return data;
  }
}

class LoginData {
/*
{
  "message": "User Logged in",
  "data": {
    "token_type": "Bearer",
    "access_token": "xRlWo638w6FlR9wvC72kEGkxhoQOA0GR4S7wJmsFp4uxUXFP3TESqZGm4zzGZ4sp59bNiTikFCqkj8gD"
  }
} 
*/

  String? message;
  AccessToken? data;

  LoginData({
    this.message,
    this.data,
  });
  LoginData.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    data = (json['data'] != null) ? AccessToken.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
