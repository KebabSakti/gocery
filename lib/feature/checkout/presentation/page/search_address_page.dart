import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/widget/shimmer_loader.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/presentation/getx/controller/search_address_page_controller.dart';

class SearchAddressPage extends GetView<SearchAddressPageController> {
  const SearchAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Cari Alamat'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(kMediumPadding),
            child: Container(
              height: 44,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: kLightColor100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                onChanged: (value) {
                  controller.keyword(value);
                },
                autofocus: true,
                textInputAction: TextInputAction.search,
                style: Get.textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: 'Ketik di sini',
                  hintStyle: Get.theme.textTheme.bodyText2,
                  contentPadding: const EdgeInsets.only(right: 8, top: 4),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  suffixIconConstraints:
                      const BoxConstraints(maxWidth: 32, maxHeight: 32),
                  suffixIcon: SizedBox(
                    width: 32,
                    height: 32,
                    child: Material(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        child: const Icon(
                          AppIcon.search,
                          color: kLightColor,
                          size: 20,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Obx(() {
            final addresState = controller.addressState();

            if (addresState.status == Status.loading) {
              return ListView.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
                  child: Divider(height: 1),
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(kMediumPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerLoader(height: 16),
                        SizedBox(height: kTinyPadding),
                        ShimmerLoader(height: 16),
                      ],
                    ),
                  );
                },
              );
            }

            if (addresState.data != null) {
              final List<ShippingAddressEntity> addresses = addresState.data!;

              return ListView.separated(
                itemCount: addresses.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
                  child: Divider(height: 1),
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      controller.selectAddress(param: addresses[index]);
                    },
                    contentPadding: const EdgeInsets.all(kMediumPadding),
                    title: Text(addresses[index].address!),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          }))
        ],
      ),
    );
  }
}
