import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_app/domain/constants/constants.dart';
import 'package:flutter_login_app/domain/network_client/network_exceptions.dart';

@optionalTypeArgs
class NetworkClient {
  final HttpClient _client = HttpClient();

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$path');
    if (parameters != null) return uri.replace(queryParameters: parameters);
    return uri;
  }

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _interceptor(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw const ApiClientException(type: ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw const ApiClientException(type: ApiClientExceptionType.other);
    }
  }

  Future<T> post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.postUrl(url);
      log('${request.method} $url', name: 'Network client');
      log('Params: [${bodyParameters.entries.map((e) => '${e.key}: ${e.value}').join(', ')}]', name: 'Network client');

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());

      log('Response: $json', name: 'Network client');
      _interceptor(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw const ApiClientException(type: ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw const ApiClientException(type: ApiClientExceptionType.other);
    }
  }

  void _interceptor(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 400) {
      log(
        'Error code: ${response.statusCode}. Error message: ${json!['message']}',
        name: 'Network client',
        error: ApiClientExceptionType.auth,
      );
      throw ApiClientException(type: ApiClientExceptionType.auth, code: 400, message: json!['message'] as String);
    } else if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 3) {
        throw const ApiClientException(type: ApiClientExceptionType.sessionExpired);
      } else {
        throw const ApiClientException(type: ApiClientExceptionType.other);
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value) {
      final result = value.join();
      return result;
    }).then<dynamic>((v) => json.decode(v));
  }
}
