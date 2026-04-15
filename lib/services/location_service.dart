import 'package:geolocator/geolocator.dart';

class LocationService {
  // التحقق من صلاحيات الموقع
  static Future<bool> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return permission == LocationPermission.whileInUse || 
           permission == LocationPermission.always;
  }

  // الحصول على الموقع الحالي
  static Future<Position?> getCurrentLocation() async {
    bool hasPermission = await checkPermissions();
    if (!hasPermission) return null;
    
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );
    } catch (e) {
      print('خطأ في الحصول على الموقع: $e');
      return null;
    }
  }

  // حساب المسافة بين نقطتين (كيلومترات)
  static double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371;
    double dLat = _toRadians(lat2 - lat1);
    double dLng = _toRadians(lng2 - lng1);
    double a = (dLat / 2).sin() * (dLat / 2).sin() +
               _toRadians(lat1).cos() * _toRadians(lat2).cos() *
               (dLng / 2).sin() * (dLng / 2).sin();
    double c = 2 * a.asin();
    return earthRadius * c;
  }

  static double _toRadians(double degree) {
    return degree * 3.14159 / 180;
  }

  // تنسيق المسافة للعرض
  static String formatDistance(double km) {
    if (km < 1) {
      return '${(km * 1000).toInt()} م';
    }
    return '${km.toStringAsFixed(1)} كم';
  }
}
