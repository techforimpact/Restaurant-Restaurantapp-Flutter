import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  String? sessionToken;

  static const String androidKey = 'AIzaSyB1j0A0N-irCzLOoRIYrfgj25hOK1_LY30';
  static const String iosKey = 'AIzaSyCnkYLrWX6p51sdUFK7P-kWxbLaoC4KG4A';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      log("FetchResults--->>> $result");

      if (result['status'] == 'OK') {
        return List.generate(
            result['predictions'].length,
            (index) => Suggestion(result['predictions'][index]['place_id'],
                result['predictions'][index]['description']));
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<dynamic> getPlaceDetailFromId(String placeId) async {
    try {
      final request =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&'
          'fields=geometry/location&key=$apiKey&sessiontoken=$sessionToken';
      final response = await client.get(Uri.parse(request));

      log(request);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        log('Location Result--->> ${result['result']['geometry']['location']}');
        if (result['status'] == 'OK') {
          Map<String, dynamic> components =
              result['result']['geometry']['location'];
          log("the logn and lat is $components");
          return components;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
