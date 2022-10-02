enum ApiClientExceptionType { network, auth, other, sessionExpired }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;
  final int code;
  final String message;

  const ApiClientException({
    this.type = ApiClientExceptionType.other,
    this.code = 0,
    this.message = '',
  });
}
