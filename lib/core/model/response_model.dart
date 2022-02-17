enum Status { empty, loading, success, error }

class ResponseModel<T> {
  ResponseModel({
    this.status,
    this.data,
  });

  final Status? status;
  final T? data;

  ResponseModel<T> copyWith({
    Status? status,
    T? data,
  }) =>
      ResponseModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );
}
