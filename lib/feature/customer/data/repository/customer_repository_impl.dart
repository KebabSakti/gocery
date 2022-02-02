import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/feature/customer/data/datasource/remote/customer_remote_datasource.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';
import 'package:gocery/feature/customer/domain/repository/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerRepositoryImpl({required this.remoteDatasource});

  final CustomerRemoteDatasource remoteDatasource;

  @override
  Future<CustomerAccountEntity> showCustomerAccount() async {
    try {
      return await remoteDatasource.showCustomerAccount();
    } catch (e, _) {
      if (e is DioError) {
        if (e.response == null) {
          throw Failure(
              'Koneksi internet bermasalah, cobalah beberapa saat lagi',
              error: e);
        }

        throw Failure(e.message, error: e);
      } else {
        throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
            error: e);
      }
    }
  }

  @override
  Future<void> updateFcm({required String fcmToken}) async {
    try {
      await remoteDatasource.updateFcm(fcmToken: fcmToken);
    } catch (e, _) {
      if (e is DioError) {
        if (e.response == null) {
          throw Failure(
              'Koneksi internet bermasalah, cobalah beberapa saat lagi',
              error: e);
        }

        throw Failure(e.message, error: e);
      } else {
        throw Failure('Terjadi kesalahan, harap coba beberapa saat lagi',
            error: e);
      }
    }
  }
}
