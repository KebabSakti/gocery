import 'package:gocery/feature/customer/domain/repository/customer_repository.dart';

class UpdateFcm {
  UpdateFcm({required this.repository});

  final CustomerRepository repository;

  Future<void> call() async {
    await repository.updateFcm();
  }
}
