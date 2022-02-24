import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/app/presentation/getx/controller/add_to_cart_panel_controller.dart';
import 'package:gocery/feature/app/presentation/getx/controller/scroll_top_button_controller.dart';
import 'package:gocery/feature/banner/data/repository/banner_repository_impl.dart';
import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';
import 'package:gocery/feature/banner/domain/usecase/index_banner.dart';
import 'package:gocery/feature/bundle/data/repository/bundle_repository_impl.dart';
import 'package:gocery/feature/bundle/domain/entity/bundle_entity.dart';
import 'package:gocery/feature/bundle/domain/usecase/index_bundle.dart';
import 'package:gocery/feature/cart/presentation/getx/controller/cart_controller.dart';
import 'package:gocery/feature/category/data/model/category_model.dart';
import 'package:gocery/feature/category/data/repository/category_repository_impl.dart';
import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/category/domain/usecase/index_category.dart';
import 'package:gocery/feature/customer/data/repository/customer_repository_impl.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';
import 'package:gocery/feature/customer/domain/usecase/show_customer_account.dart';
import 'package:gocery/feature/customer/domain/usecase/update_fcm.dart';
import 'package:gocery/feature/home/presentation/getx/controller/banner_carousel_controller.dart';
import 'package:gocery/feature/product/data/repository/product_repository_impl.dart';
import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';
import 'package:gocery/feature/product/domain/usecase/index_product.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_filter_controller.dart';

class HomePageController extends GetxController {
  HomePageController() {
    Get.put(BannerCarouselController());

    scrollController = ScrollController();

    productFilterController =
        Get.put(ProductFilterController(), tag: 'HomePage');

    scrollTopButtonController = Get.put(
        ScrollTopButtonController(scrollController: scrollController),
        tag: 'HomePage');

    cartController = Get.find<CartController>();

    addToCartPanelController =
        Get.find<AddToCartPanelController>(tag: 'AppPage');
  }

  late final ScrollController scrollController;
  late final ProductFilterController productFilterController;
  late final ScrollTopButtonController scrollTopButtonController;
  late final CartController cartController;
  late final AddToCartPanelController addToCartPanelController;

  final _updateCustomerFcmUsecase =
      UpdateFcm(repository: Get.find<CustomerRepositoryImpl>());
  final _showCustomerAccountUsecase =
      ShowCustomerAccount(repository: Get.find<CustomerRepositoryImpl>());
  final _indexCategory =
      IndexCategory(repository: Get.find<CategoryRepositoryImpl>());
  final _indexBanner =
      IndexBanner(repository: Get.find<BannerRepositoryImpl>());
  final _indexProduct =
      IndexProduct(repository: Get.find<ProductRepositoryImpl>());
  final _indexBundle =
      IndexBundle(repository: Get.find<BundleRepositoryImpl>());

  final customerAccount =
      ResponseModel<CustomerAccountEntity>(status: Status.loading).obs;
  final categoriesState =
      ResponseModel<List<CategoryEntity>>(status: Status.loading).obs;
  final bannersState =
      ResponseModel<List<BannerEntity>>(status: Status.loading).obs;
  final producPopulartState =
      ResponseModel<ProductPagingEntity>(status: Status.loading).obs;
  final bundlesState =
      ResponseModel<List<BundleEntity>>(status: Status.loading).obs;
  final productsState =
      ResponseModel<ProductPagingEntity>(status: Status.loading).obs;

  final paging = false.obs;

  void toProductDetail({required ProductEntity productEntity}) async {
    Get.toNamed(kProductDetailPage, arguments: productEntity);
  }

  Future<void> fcm() async {
    try {
      await _updateCustomerFcmUsecase();
    } catch (e) {
      customerAccount(
          ResponseModel<CustomerAccountEntity>(status: Status.error));
    }
  }

  Future<void> customer() async {
    try {
      customerAccount(
          ResponseModel<CustomerAccountEntity>(status: Status.loading));

      await _showCustomerAccountUsecase().then((model) {
        customerAccount(ResponseModel<CustomerAccountEntity>(
          status: Status.success,
          data: model,
        ));
      });
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
        datas.insert(
          0,
          CategoryModel(
            uid: '',
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
      MToast.show('Gagal memuat banner');

      bannersState(ResponseModel<List<BannerEntity>>(status: Status.error));
    }
  }

  Future<void> productsPopular() async {
    try {
      producPopulartState(
          ResponseModel<ProductPagingEntity>(status: Status.loading));

      await _indexProduct(
        param: IndexProductParamEntity(page: 1, sorting: 'sold'),
      ).then((model) {
        producPopulartState(ResponseModel<ProductPagingEntity>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat produk paling laku');

      producPopulartState(
          ResponseModel<ProductPagingEntity>(status: Status.error));
    }
  }

  Future<void> bundles() async {
    try {
      bundlesState(ResponseModel<List<BundleEntity>>(status: Status.loading));

      await _indexBundle().then((model) {
        bundlesState(ResponseModel<List<BundleEntity>>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat bundle produk');

      bundlesState(ResponseModel<List<BundleEntity>>(status: Status.error));
    }
  }

  Future<void> products({required IndexProductParamEntity param}) async {
    try {
      productsState(ResponseModel<ProductPagingEntity>(status: Status.loading));

      await _indexProduct(param: param).then((model) {
        productsState(ResponseModel<ProductPagingEntity>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat produk');

      productsState(ResponseModel<ProductPagingEntity>(status: Status.error));
    }
  }

  Future<void> productsPaging({required IndexProductParamEntity param}) async {
    try {
      paging(true);

      await _indexProduct(param: param).then((model) {
        final List<ProductEntity> datas =
            productsState().data!.data! + model.data!;

        final ProductPagingEntity pagingEntity = ProductPagingEntity(
            data: datas, links: model.links, meta: model.meta);

        productsState(ResponseModel<ProductPagingEntity>(
          status: Status.success,
          data: pagingEntity,
        ));

        paging(false);
      });
    } catch (e) {
      MToast.show('Gagal memuat produk');

      paging(false);

      productsState(ResponseModel<ProductPagingEntity>(status: Status.error));
    }
  }

  void initListener() {
    //PRODUCT FILTER LISTENER
    debounce(productFilterController.filter, (IndexProductParamEntity filter) {
      products(param: filter);
    }, time: const Duration(milliseconds: 500));

    //SCROLL LISTENER
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double offset = scrollController.offset;

      if (maxScroll == offset &&
          paging() == false &&
          productsState().data?.links?.next != null) {
        productsPaging(
            param: productFilterController
                .filter()
                .copyWith(page: productsState().data!.meta!.currentPage! + 1));
      }
    });
  }

  void init() async {
    fcm();
    customer();
    categories();
    banners();
    productsPopular();
    bundles();
    products(param: productFilterController.filter());
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }
}
