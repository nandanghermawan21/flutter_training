import 'package:geolocator/geolocator.dart';

class GeolocatorModel {
  static Future<Position> myLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return position;
  }

  static Future<String> getAddress(double lat, double lon) {
    return Geolocator().placemarkFromCoordinates(lat, lon).then((onValue) {
      return changeToAddress(onValue.first);
    }).catchError((onError) {
      return "$onError";
    });
  }

  static String changeToAddress(Placemark place) {
    return "${place.thoroughfare} ${place.subThoroughfare} ${place.subLocality} ${place.locality} ${place.subAdministrativeArea} ${place.administrativeArea} ${place.country} ${place.postalCode}";
  }
}
