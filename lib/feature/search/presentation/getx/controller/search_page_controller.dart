import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final searchField = TextEditingController();
  final searchMode = false.obs;

  @override
  void onInit() {
    searchField.addListener(() {
      searchMode(searchField.text.isNotEmpty);
    });

    super.onInit();
  }
}
