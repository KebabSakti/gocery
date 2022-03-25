import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

abstract class MapApiContract {
  void init();

  Future<PlacesAutocompleteResponse> placesByKeyword({String keyword = ''});

  Future<GeocodingResponse> searchByAddress({required String address});
}

class MapApiImpl implements MapApiContract {
  MapApiImpl({required this.implementation}) {
    init();
  }

  final MapApiContract implementation;

  @override
  void init() {
    implementation.init();
  }

  @override
  Future<PlacesAutocompleteResponse> placesByKeyword(
      {String keyword = ''}) async {
    return await implementation.placesByKeyword(keyword: keyword);
  }

  @override
  Future<GeocodingResponse> searchByAddress({required String address}) async {
    return await implementation.searchByAddress(address: address);
  }
}
