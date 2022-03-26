import 'package:gocery/core/service/map_api/map_api.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class MapApiService implements MapApiContract {
  MapApiService({
    required this.geocoding,
    required this.places,
  });

  final GoogleMapsGeocoding geocoding;
  final GoogleMapsPlaces places;

  @override
  Future<PlacesAutocompleteResponse> placesByKeyword(
      {String keyword = ''}) async {
    PlacesAutocompleteResponse response = await places.autocomplete(
      keyword,
      location: Location(lat: -0.49732531314209866, lng: 117.14187383609166),
      radius: 10000,
      strictbounds: true,
      language: 'id',
      components: [Component('country', 'id')].toList(),
    );

    return response;
  }

  @override
  Future<GeocodingResponse> searchByAddress({required String address}) async {
    GeocodingResponse response = await geocoding.searchByAddress(address);

    return response;
  }
}
