import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone/provider/add_request.dart';

class Providers {
  static Future<String> searchCordinateAddress(Position position) async {
    String placeAddress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}";
    var response = await Request.getRequest(url);

    if (response != "Failed") {
      placeAddress = response['results'][0]['formatted_address'];
    }
    return placeAddress;
  }
}
