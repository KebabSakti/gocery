import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/app/presentation/getx/controller/add_to_cart_panel_controller.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';
import 'package:gocery/feature/product/data/repository/product_repository_impl.dart';
import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_entity.dart';
import 'package:gocery/feature/product/domain/entity/product_paging_entity.dart';
import 'package:gocery/feature/product/domain/usecase/index_product.dart';
import 'package:gocery/feature/product/domain/usecase/product_view_history.dart';
import 'package:gocery/feature/search/data/repository/search_repository_impl.dart';
import 'package:gocery/feature/search/domain/entity/search_entity.dart';
import 'package:gocery/feature/search/domain/usecase/delete_search.dart';
import 'package:gocery/feature/search/domain/usecase/index_search.dart';
import 'package:gocery/feature/search/domain/usecase/suggestion_search.dart';

class SearchPageController extends GetxController {
  SearchPageController({required this.controllerTag}) {
    addToCartPanelController =
        Get.put(AddToCartPanelController(), tag: controllerTag);
  }

  late final String controllerTag;
  late final AddToCartPanelController addToCartPanelController;

  final searchField = TextEditingController();

  final _indexSearch =
      IndexSearch(repository: Get.find<SearchRepositoryImpl>());
  final _lastViewProduct =
      ProductViewHistory(repository: Get.find<ProductRepositoryImpl>());
  final _mostSearchProduct =
      IndexProduct(repository: Get.find<ProductRepositoryImpl>());
  final _deleteSearchHistory =
      DeleteSearch(repository: Get.find<SearchRepositoryImpl>());
  final _keywordSuggestion =
      SuggestionSearch(repository: Get.find<SearchRepositoryImpl>());
  final _productSuggestion =
      IndexProduct(repository: Get.find<ProductRepositoryImpl>());

  final productHistoryState =
      ResponseModel<List<ProductEntity>>(status: Status.loading).obs;
  final searchsState =
      ResponseModel<List<SearchEntity>>(status: Status.loading).obs;
  final mostSearchProductState =
      ResponseModel<ProductPagingEntity>(status: Status.loading).obs;
  final keywordSuggestionState =
      ResponseModel<List<SearchEntity>>(status: Status.loading).obs;
  final productSuggestionState =
      ResponseModel<ProductPagingEntity>(status: Status.loading).obs;

  final searchKeyword = ''.obs;

  Future<void> productHistories() async {
    try {
      productHistoryState(
          ResponseModel<List<ProductEntity>>(status: Status.loading));

      await _lastViewProduct().then((models) {
        if (models.isNotEmpty) {
          productHistoryState(ResponseModel<List<ProductEntity>>(
            status: Status.success,
            data: models,
          ));
        } else {
          productHistoryState(
              ResponseModel<List<ProductEntity>>(status: Status.empty));
        }
      });
    } catch (e) {
      MToast.show('Gagal memuat riwayat produk');

      productHistoryState(
          ResponseModel<List<ProductEntity>>(status: Status.error));
    }
  }

  Future<void> searches() async {
    try {
      searchsState(ResponseModel<List<SearchEntity>>(status: Status.loading));

      await _indexSearch().then((models) {
        searchsState(ResponseModel<List<SearchEntity>>(
          status: Status.success,
          data: models,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat riwayat pencarian');

      searchsState(ResponseModel<List<SearchEntity>>(status: Status.error));
    }
  }

  Future<void> deleteSearch({required String uid}) async {
    try {
      MDialog.loading();

      await _deleteSearchHistory(uid: uid).then((models) {
        MDialog.close();

        MToast.show('Data berahasil dihapus');

        searches();
      });
    } catch (e) {
      MDialog.close();

      MToast.show('Gagal menghapus data, coba beberapa saat lagi');
    }
  }

  Future<void> products() async {
    try {
      mostSearchProductState(
          ResponseModel<ProductPagingEntity>(status: Status.loading));

      await _mostSearchProduct(
              param: IndexProductParamEntity(sorting: 'search'))
          .then((model) {
        mostSearchProductState(ResponseModel<ProductPagingEntity>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat produk paling dicari');

      mostSearchProductState(
          ResponseModel<ProductPagingEntity>(status: Status.error));
    }
  }

  Future<void> keywordSuggestions({required String keyword}) async {
    try {
      keywordSuggestionState(
          ResponseModel<List<SearchEntity>>(status: Status.loading));

      await _keywordSuggestion(keyword: keyword).then((model) {
        keywordSuggestionState(ResponseModel<List<SearchEntity>>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat kata kunci');

      keywordSuggestionState(
          ResponseModel<List<SearchEntity>>(status: Status.error));
    }
  }

  Future<void> productSuggestion({required String keyword}) async {
    try {
      productSuggestionState(
          ResponseModel<ProductPagingEntity>(status: Status.loading));

      await _productSuggestion(param: IndexProductParamEntity(name: keyword))
          .then((model) {
        productSuggestionState(ResponseModel<ProductPagingEntity>(
          status: Status.success,
          data: model,
        ));
      });
    } catch (e) {
      MToast.show('Gagal memuat produk sesuai kata kunci');

      productSuggestionState(
          ResponseModel<ProductPagingEntity>(status: Status.error));
    }
  }

  void toProductDetail({required ProductEntity param}) {
    Get.toNamed(kProductDetailPage, arguments: param);
  }

  void toProductPage({required IndexProductParamModel param}) {
    Get.toNamed(kProductPage, arguments: param);
  }

  void initListener() {
    debounce(searchKeyword, (String keyword) {
      if (keyword.length > 2) {
        keywordSuggestions(keyword: keyword);

        productSuggestion(keyword: keyword);
      } else {
        keywordSuggestionState(
            ResponseModel<List<SearchEntity>>(status: Status.empty));

        productSuggestionState(
            ResponseModel<ProductPagingEntity>(status: Status.empty));
      }
    }, time: const Duration(milliseconds: 200));

    searchField.addListener(() {
      searchKeyword(searchField.text);
    });
  }

  void init() {
    productHistories();

    searches();

    products();
  }

  @override
  void onInit() {
    initListener();

    init();

    super.onInit();
  }

  @override
  void onClose() {
    searchField.dispose();
    super.onClose();
  }
}
