import 'package:get/get.dart';
import 'package:gocery/feature/product/data/model/index_product_param_model.dart';

class ProductFilterController extends GetxController {
  final filter = IndexProductParamModel(page: 1).obs;
}
