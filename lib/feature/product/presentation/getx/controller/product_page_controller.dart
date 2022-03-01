import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/app/presentation/getx/controller/add_to_cart_panel_controller.dart';
import 'package:gocery/feature/app/presentation/getx/controller/scroll_top_button_controller.dart';
import 'package:gocery/feature/category/data/model/category_model.dart';
import 'package:gocery/feature/category/data/repository/category_repository_impl.dart';
import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'package:gocery/feature/category/domain/usecase/index_category.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/data/repository/product_repository_impl.dart';
import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';
import 'package:gocery/feature/product/domain/usecase/index_product.dart';
import 'package:gocery/feature/product/presentation/getx/controller/product_filter_controller.dart';

class ProductPageController extends GetxController {
  ProductPageController({required this.controllerTag}) {
    scrollController = ScrollController();

    productFilterController =
        Get.put(ProductFilterController(), tag: controllerTag);

    addToCartPanelController =
        Get.put(AddToCartPanelController(), tag: controllerTag);
  }

  late final String controllerTag;
  late final ScrollController scrollController;
  late final ProductFilterController productFilterController;
  late final ScrollTopButtonController scrollTopButtonController;
  late final AddToCartPanelController addToCartPanelController;

  final IndexProductParamModel? argument = Get.arguments;

  final _indexCategory =
      IndexCategory(repository: Get.find<CategoryRepositoryImpl>());
  final _indexProduct =
      IndexProduct(repository: Get.find<ProductRepositoryImpl>());

  final paging = false.obs;
  final activeTab = 0.obs;

  final categoriesState = ResponseModel<List<CategoryEntity>>().obs;
  final productsState = ResponseModel<ProductPagingEntity>().obs;

  Future<void> categories() async {
    try {
      categoriesState(
          ResponseModel<List<CategoryEntity>>(status: Status.loading));

      await _indexCategory().then((models) {
        List<CategoryEntity> datas = models;

        datas.insert(
          0,
          CategoryModel(uid: '', name: 'Semua'),
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

  Future<bool> onBackButtonPressed() async {
    if (addToCartPanelController.panelController.isPanelOpen) {
      addToCartPanelController.panelController.close();

      return false;
    } else {
      return true;
    }
  }

  void setInitialTabItem() {
    if (argument?.category != null) {
      int index = categoriesState()
          .data!
          .indexWhere((element) => element.uid! == argument!.category!);

      if (index >= 0) {
        activeTab(index);
      }
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
    await categories();

    setInitialTabItem();

    productFilterController.filter(argument);
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }
}
