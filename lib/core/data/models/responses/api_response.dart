
class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool? error;


  const ApiResponse({
    this.data,
    this.message,
    this.error,
  });


  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic)? fromJsonT,
      ) {
    return ApiResponse<T>(
      data: json['data'] == null ? null : (fromJsonT == null ? null : fromJsonT(json['data'])),
      message: json['message'] as String?,
      error: json['error'] as bool?,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => {
    'data': data == null ? null : toJsonT(data as T),
    'message': message,
    'error': error,
  };

  @override
  String toString() => 'ApiResponse<$T>(error: $error, data: $data)';
}

