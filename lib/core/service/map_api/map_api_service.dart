import 'package:gocery/core/service/map_api/map_api.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class MapApiService implements MapApiContract {
  MapApiService() {
    init();
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  Future<PlacesAutocompleteResponse> placesByKeyword(
      {String keyword = ''}) async {
    // TODO: implement placesByKeyword
    throw UnimplementedError();
  }

  @override
  Future<GeocodingResponse> searchByAddress({required String address}) async {
    // TODO: implement searchByAddress
    throw UnimplementedError();
  }
}
