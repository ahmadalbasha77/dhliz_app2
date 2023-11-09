class ApiNewResponse<T> {
  T response;
  List<String> error;
  dynamic validatorError;
  bool isSuccess;

  ApiNewResponse({
    required this.response,
    required this.error,
    required this.validatorError,
    required this.isSuccess,
  });

  factory ApiNewResponse.fromJson(Map<String, dynamic> json) {
    return ApiNewResponse<T>(
      response: json['response'] as T,
      error: (json['error'] as List).cast<String>(),
      validatorError: json['validatorError'],
      isSuccess: json['isSuccess'],
    );
  }
}
