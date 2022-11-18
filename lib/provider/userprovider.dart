import 'package:flutter/foundation.dart';

import '../models/address.dart';

class UserProvider extends ChangeNotifier {
  Address pickupLocation;

  UserProvider(this.pickupLocation);

  void updatePickupLocationAddress(Address newPickuplocation) {
    pickupLocation = newPickuplocation;
    notifyListeners();
  }
}
