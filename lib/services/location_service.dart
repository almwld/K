import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('خدمة الموقع غير مفعلة');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('تم رفض صلاحيات الموقع');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('صلاحيات الموقع مرفوضة بشكل دائم');
    }

    return await Geolocator.getCurrentPosition();
  }

  static double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371; // كيلومتر
    
    double dLat = _toRadians(lat2 - lat1);
    double dLng = _toRadians(lng2 - lng1);
    
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
               math.cos(_toRadians(lat1)) * math.cos(_toRadians(lat2)) *
               math.sin(dLng / 2) * math.sin(dLng / 2);
    
    double c = 2 * math.asin(math.sqrt(a));
    
    return earthRadius * c;
  }

  static double _toRadians(double degree) {
    return degree * math.pi / 180.0;
  }

  static String formatDistance(double distance) {
    if (distance < 1) {
      return '${(distance * 1000).round()} متر';
    } else {
      return '${distance.toStringAsFixed(1)} كم';
    }
  }
}
