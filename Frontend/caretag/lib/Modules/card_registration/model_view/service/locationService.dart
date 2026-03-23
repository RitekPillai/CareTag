import 'package:geocoding/geocoding.dart';

class Locationservice {
  Future<Map<String, double>?> getCordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location loc = locations.first;
        return {'lat': loc.latitude, 'long': loc.longitude};
      } else {
        throw new Exception("Invaild address");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
