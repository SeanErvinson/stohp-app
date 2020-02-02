import 'package:google_maps_webservice/places.dart';

class PlacesRepository {
  static const String API_KEY = "AIzaSyDjhvBKoej7NWdGR5AOXUNaJLpLr4it5AY";

  Future<List<PlacesSearchResult>> fetchPlaces(String query) async {
    final places = new GoogleMapsPlaces(apiKey: API_KEY);
    PlacesSearchResponse response = await places.searchByText(query);
    return response.results;
  }
}
