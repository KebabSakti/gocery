import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/model/response_model.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class SearchAddressPageController extends GetxController {
  final addressState =
      ResponseModel<List<ShippingAddressEntity>>(status: Status.empty).obs;

  final keyword = ''.obs;

  void placesPrediction() async {
    addressState(ResponseModel(status: Status.loading));

    final GoogleMapsPlaces googleMapsPlaces = GoogleMapsPlaces(apiKey: kMapKey);

    PlacesAutocompleteResponse response = await googleMapsPlaces.autocomplete(
      keyword(),
      location: Location(lat: -0.49732531314209866, lng: 117.14187383609166),
      radius: 10000,
      strictbounds: true,
      language: 'id',
      components: [Component('country', 'id')].toList(),
    );

    if (response.status == 'OK') {
      final model = ResponseModel(
        status: Status.success,
        data: response.predictions.map<ShippingAddressEntity>((e) {
          return ShippingAddressEntity(address: e.description);
        }).toList(),
      );

      addressState(model);
    } else {
      addressState(ResponseModel(status: Status.error));
    }
  }

  Future<void> selectAddress({required ShippingAddressEntity param}) async {
    try {
      MDialog.loading();

      final GoogleMapsGeocoding geocoding =
          GoogleMapsGeocoding(apiKey: kMapKey);

      GeocodingResponse response =
          await geocoding.searchByAddress(param.address!);

      if (response.status == 'OK') {
        var result = param.copyWith(
          latitude: response.results[0].geometry.location.lat.toString(),
          longitude: response.results[0].geometry.location.lng.toString(),
        );

        Get.back(result: result);
      }
    } catch (e) {
      e;

      MToast.close();
    }
  }

  void initListener() {
    debounce(keyword, (String value) {
      if (value.length > 2) {
        placesPrediction();
      } else {
        addressState(ResponseModel(status: Status.empty));
      }
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onInit() {
    initListener();

    super.onInit();
  }
}
