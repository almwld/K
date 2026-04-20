import 'package:latlong2/latlong.dart';

class YemenCity {
  final String name;
  final String nameAr;
  final String governorate;
  final LatLng coordinates;
  final int population;
  final String type;
  final String description;
  final String imageUrl;

  YemenCity({
    required this.name,
    required this.nameAr,
    required this.governorate,
    required this.coordinates,
    required this.population,
    required this.type,
    required this.description,
    required this.imageUrl,
  });
}

class YemenCitiesData {
  static List<YemenCity> getAllCities() {
    return [
      YemenCity(name: 'Sanaa', nameAr: 'صنعاء', governorate: 'أمانة العاصمة', coordinates: LatLng(15.3694, 44.1910), population: 2950000, type: 'عاصمة', description: 'العاصمة السياسية والتاريخية لليمن', imageUrl: 'https://images.unsplash.com/photo-1584551246678-0daf3dfa2a0c?w=400'),
      YemenCity(name: 'Aden', nameAr: 'عدن', governorate: 'عدن', coordinates: LatLng(12.7855, 45.0187), population: 865000, type: 'مدينة ساحلية', description: 'العاصمة الاقتصادية لليمن', imageUrl: 'https://images.unsplash.com/photo-1580418827493-f2b22c0a76cb?w=400'),
      YemenCity(name: 'Taiz', nameAr: 'تعز', governorate: 'تعز', coordinates: LatLng(13.5776, 44.0179), population: 615000, type: 'مدينة تاريخية', description: 'العاصمة الثقافية لليمن', imageUrl: 'https://images.unsplash.com/photo-1590077428593-a55c8427c2b1?w=400'),
      YemenCity(name: 'Al Hudaydah', nameAr: 'الحديدة', governorate: 'الحديدة', coordinates: LatLng(14.7909, 42.9712), population: 617000, type: 'مدينة ساحلية', description: 'ميناء رئيسي على البحر الأحمر', imageUrl: 'https://images.unsplash.com/photo-1582657118090-5e1e4c7c5413?w=400'),
      YemenCity(name: 'Ibb', nameAr: 'إب', governorate: 'إب', coordinates: LatLng(13.9667, 44.1833), population: 225000, type: 'مدينة جبلية', description: 'اللواء الأخضر', imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400'),
      YemenCity(name: 'Mukalla', nameAr: 'المكلا', governorate: 'حضرموت', coordinates: LatLng(14.5424, 49.1278), population: 566000, type: 'مدينة ساحلية', description: 'عاصمة حضرموت', imageUrl: 'https://images.unsplash.com/photo-1580418827493-f2b22c0a76cb?w=400'),
    ];
  }
  
  static List<YemenCity> getMajorCities() {
    return getAllCities().where((c) => c.type == 'عاصمة' || c.type == 'مدينة ساحلية').toList();
  }
}

