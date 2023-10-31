import 'package:geolocator/geolocator.dart';

Future<bool> checkLocationService() => Geolocator.isLocationServiceEnabled();
Future<Position?> getCurrentLocation() async {
  await Geolocator.requestPermission();
  final status = await Geolocator.checkPermission();
  if (status == LocationPermission.always ||
      status == LocationPermission.whileInUse) {
    return Geolocator.getCurrentPosition();
  }
  return null;
}
