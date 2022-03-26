import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

abstract class MapApiContract {
  Future<PlacesAutocompleteResponse> placesByKeyword({String keyword = ''});

  Future<GeocodingResponse> searchByAddress({required String address});
}

class MapApiImpl implements MapApiContract {
  MapApiImpl({required this.implementation});

  final MapApiContract implementation;

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
