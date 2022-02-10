import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/product/data/repository/product_repository_impl.dart';
import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';
import 'package:gocery/feature/product/domain/usecase/index_product.dart';
import 'package:gocery/feature/product/domain/usecase/show_product.dart';
import 'package:gocery/feature/product/domain/usecase/toggle_product_favourite.dart';

class ProductDetailPageController extends GetxController {
  final ProductEntity argument = Get.arguments;
  final ScrollController scrollController = ScrollController();

  final _showProduct =
      ShowProduct(repository: Get.find<ProductRepositoryImpl>());
  final _indexProduct =
      IndexProduct(repository: Get.find<ProductRepositoryImpl>());
  final _toggleProductFavourite =
      ToggleFavouriteProduct(repository: Get.find<ProductRepositoryImpl>());

  final productState = ResponseModel<ProductEntity>().obs;
  final productsSimiliarState = ResponseModel<ProductPagingEntity>().obs;
  final favourite = false.obs;

  void toProductDetail({required ProductEntity productEntity}) async {
    scrollController.jumpTo(scrollController.position.minScrollExtent);

    product(uid: productEntity.uid!);

    productsSimiliar(uid: productEntity.categoryUid!);
  }

  Future<void> product({required String uid}) async {
    try {
      productState(ResponseModel<ProductEntity>(status: Status.loading));

      favourite(true);

      await _showProduct(uid: uid).then((model) {
        productState(
            ResponseModel<ProductEntity>(status: Status.success, data: model));

        favourite(false);
      });
    } catch (e) {
      MToast.show('Gagal memuat detail produk');

      productState(ResponseModel<ProductEntity>(status: Status.error));

      favourite(false);
    }
  }

  Future<void> productsSimiliar({required String uid}) async {
    try {
      productsSimiliarState(
          ResponseModel<ProductPagingEntity>(status: Status.loading));

      await _indexProduct(
        param: IndexProductParamEntity(page: 1, category: uid),
      ).then((model) {
        productsSimiliarState(ResponseModel<ProductPagingEntity>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat produk serupa');

      productsSimiliarState(
          ResponseModel<ProductPagingEntity>(status: Status.error));
    }
  }

  Future<void> productFavourite({required String uid}) async {
    try {
      favourite(true);

      await _toggleProductFavourite(uid: uid).then((model) {
        productState(
            ResponseModel<ProductEntity>(status: Status.success, data: model));

        favourite(false);

        MToast.show('Berhasil update produk favorit');
      });
    } catch (e) {
      MToast.show('Gagal menambah favorit produk');

      favourite(false);
    }
  }

  void init() async {
    product(uid: argument.uid!);

    productsSimiliar(uid: argument.categoryUid!);
  }

  @override
  void onInit() {
    init();

    super.onInit();
  }
}
