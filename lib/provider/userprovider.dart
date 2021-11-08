import 'package:flutter/foundation.dart';
import 'package:uber_clone/models/address.dart';

class UserProvider extends ChangeNotifier {
  Address pickupLocation;

  UserProvider(this.pickupLocation);

  void updatePickupLocationAddress(Address newPickuplocation) {
    pickupLocation = newPickuplocation;
    notifyListeners();
  }
}
