import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/banner/data/repository/banner_repository_impl.dart';
import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';
import 'package:gocery/feature/banner/domain/usecase/index_banner.dart';
import 'package:gocery/feature/category/data/model/category_model.dart';
import 'package:gocery/feature/category/data/repository/category_repository_impl.dart';
import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/category/domain/usecase/index_category.dart';
import 'package:gocery/feature/customer/data/repository/customer_repository_impl.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';
import 'package:gocery/feature/customer/domain/usecase/show_customer_account.dart';
import 'package:gocery/feature/customer/domain/usecase/update_fcm.dart';

class HomePageController extends GetxController {
  final _updateCustomerFcmUsecase =
      UpdateFcm(repository: Get.find<CustomerRepositoryImpl>());
  final _showCustomerAccountUsecase =
      ShowCustomerAccount(repository: Get.find<CustomerRepositoryImpl>());
  final _indexCategory =
      IndexCategory(repository: Get.find<CategoryRepositoryImpl>());
  final _indexBanner =
      IndexBanner(repository: Get.find<BannerRepositoryImpl>());

  final bannerActive = 0.obs;

  final customerAccount = ResponseModel<CustomerAccountEntity>().obs;
  final categoriesState = ResponseModel<List<CategoryEntity>>().obs;
  final bannersState = ResponseModel<List<BannerEntity>>().obs;

  Future<void> _updateFcm() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      await _updateCustomerFcmUsecase(fcmToken: fcmToken);
    }
  }

  Future<void> _showCustomer() async {
    customerAccount(
        ResponseModel<CustomerAccountEntity>(status: Status.loading));

    await _showCustomerAccountUsecase().then((model) {
      customerAccount(ResponseModel<CustomerAccountEntity>(
        status: Status.success,
        data: model,
      ));
    });
  }

  Future<void> customerData() async {
    try {
      await _updateFcm();

      await _showCustomer();
    } catch (e) {
      MToast.show('Gagal memuat point');

      customerAccount(
          ResponseModel<CustomerAccountEntity>(status: Status.error));
    }
  }

  Future<void> categories() async {
    try {
      categoriesState(
          ResponseModel<List<CategoryEntity>>(status: Status.loading));

      await _indexCategory().then((models) {
        List<CategoryEntity> datas = models;

        //"ALL CATEGORY" OPTION
        datas.add(
          CategoryModel(
            name: 'Semua',
            color: '0xff64BA02',
            image:
                'https://res.cloudinary.com/vjtechsolution/image/upload/v1601044196/mock/groceries.svg',
          ),
        );

        categoriesState(ResponseModel<List<CategoryEntity>>(
          status: Status.success,
          data: datas,
        ));
      });
    } catch (e) {
      debugPrint(e.toString());

      MToast.show('Gagal memuat kategori');

      categoriesState(
          ResponseModel<List<CategoryEntity>>(status: Status.error));
    }
  }

  Future<void> banners() async {
    try {
      bannersState(ResponseModel<List<BannerEntity>>(status: Status.loading));

      await _indexBanner().then((models) {
        bannersState(ResponseModel<List<BannerEntity>>(
          status: Status.success,
          data: models,
        ));
      });
    } catch (e) {
      debugPrint(e.toString());

      MToast.show('Gagal memuat banner');

      bannersState(ResponseModel<List<BannerEntity>>(status: Status.error));
    }
  }

  void init() async {
    customerData();
    categories();
    banners();
  }

  @override
  void onInit() {
    init();

    super.onInit();
  }
}
