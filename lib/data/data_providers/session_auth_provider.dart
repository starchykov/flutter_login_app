import 'package:flutter_login_app/domain/constants/constants.dart';
import 'package:flutter_login_app/domain/entities/token_entity.dart';
import 'package:flutter_login_app/domain/network_client/network_client.dart';
import 'package:flutter_login_app/domain/network_client/network_exceptions.dart';

class SessionAuthProvider {
  final NetworkClient _networkClient = NetworkClient();

  Future<String> login({required String login, required String password}) async {
    final Map<String, dynamic> params = <String, dynamic>{'email': login, 'password': password};

    Token parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = Token.fromJson(jsonMap);
      return response;
    }

    try {
      Token result = await _networkClient.post(ApiEndpoints.login, params, (dynamic json) => parser(json));
      return result.accessToken;
    } on ApiClientException {
      rethrow;
    }
  }

  Future<bool> logout() async {
    return true;
  }
}
