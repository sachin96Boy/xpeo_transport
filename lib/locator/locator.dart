import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';
import '../provider/userprovider.dart';
import './add_request.dart';

class NewLocator {
  Future<String> searchCordinateAddress(
      Position position, BuildContext context) async {
    String placeAddress = "";
    String st1 = "";
    String st2 = "";
    String st3 = "";
    String st4 = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}";
    var response = await Request.getRequest(url);

    if (response != "Failed") {
      st1 = response['results'][0]['address_components'][3]['long_name'];
      st2 = response['results'][0]['address_components'][4]['long_name'];
      st3 = response['results'][0]['address_components'][5]['long_name'];
      st4 = response['results'][0]['address_components'][6]['long_name'];
      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      var userPickupAddress = Address(
          placeFormattedAddress: placeAddress,
          placeId: Random().nextInt(1000000).toString(),
          latitude: position.latitude,
          longitude: position.longitude,
          placeName: placeAddress);

      Provider.of<UserProvider>(context, listen: false)
          .updatePickupLocationAddress(userPickupAddress);
    }
    return placeAddress;
  }
}
