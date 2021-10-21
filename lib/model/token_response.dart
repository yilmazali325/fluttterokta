class TokenResponse {
  final String token_type;
  final int expires_in;
  final String access_token;
  final String scope;
  final String refresh_token;
  final String id_token;

  TokenResponse(
      {this.token_type,
      this.expires_in,
      this.access_token,
      this.scope,
      this.refresh_token,
      this.id_token});

  Map<String, dynamic> toJson() => {
        'token_type': token_type,
        'expires_in': expires_in,
        'access_token': access_token,
        'scope': scope,
        'refresh_token': refresh_token,
        'id_token': id_token,
      };

  TokenResponse.fromJson(Map<String, dynamic> data)
      : token_type = data['token_type'],
        expires_in = data['expires_in'],
        access_token = data['access_token'],
        scope = data['scope'],
        refresh_token = data['refresh_token'],
        id_token = data['id_token'];

  // TokenResponse.fromApiResponse(Map<String, dynamic> data)
  //     : id = data['_embedded']['user']['id'],
  //       login = data['_embedded']['user']['profile']['login'],
  //       firstName = data['_embedded']['user']['profile']['firstName'],
  //       lastName = data['_embedded']['user']['profile']['lastName'],
  //       locale = data['_embedded']['user']['profile']['locale'],
  //       timeZone = data['_embedded']['user']['profile']['timeZone'];
}
