enum Status { empty, loading, success, error }

class ResponseModel<T> {
  ResponseModel({
    this.status = Status.empty,
    this.data,
  });

  final Status status;
  final T? data;

  ResponseModel copyWith({
    Status responseStatus = Status.empty,
    T? data,
  }) =>
      ResponseModel(
        status: responseStatus,
        data: data ?? this.data,
      );
}
