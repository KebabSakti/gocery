import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
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
  final ProductEntity productEntity = Get.arguments;

  final _showProduct =
      ShowProduct(repository: Get.find<ProductRepositoryImpl>());
  final _indexProduct =
      IndexProduct(repository: Get.find<ProductRepositoryImpl>());
  final _toggleProductFavourite =
      ToggleFavouriteProduct(repository: Get.find<ProductRepositoryImpl>());

  final productState = ResponseModel<ProductEntity>().obs;
  final productsSimiliarState = ResponseModel<ProductPagingEntity>().obs;

  void toProductDetail({required ProductEntity productEntity}) async {
    Get.offNamed(kProductDetailPage,
        preventDuplicates: false, arguments: productEntity);
  }

  Future<void> product() async {
    try {
      productState(ResponseModel<ProductEntity>(status: Status.loading));

      await _showProduct(uid: productEntity.uid!).then((model) {
        productState(
            ResponseModel<ProductEntity>(status: Status.success, data: model));
      });
    } catch (e) {
      MToast.show('Gagal memuat detail produk');

      productState(ResponseModel<ProductEntity>(status: Status.error));
    }
  }

  Future<void> productsSimiliar() async {
    try {
      productsSimiliarState(
          ResponseModel<ProductPagingEntity>(status: Status.loading));

      await _indexProduct(
        param: IndexProductParamEntity(
            page: 1, category: productEntity.categoryUid),
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

  Future<void> toggleProductFavourite({required String uid}) async {
    try {
      await _toggleProductFavourite(uid: uid).then((_) {
        // final ProductEntity favouritedProduct = ProductModel();
      });
    } catch (e) {
      MToast.show('Gagal menambah favorit produk');
    }
  }

  void init() async {
    product();

    productsSimiliar();
  }

  @override
  void onInit() {
    init();

    super.onInit();
  }
}
