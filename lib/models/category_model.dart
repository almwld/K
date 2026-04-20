class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

// قائمة جميع الفئات الـ 52 مع صور حقيقية من الإنترنت
final List<Category> allCategories = [
  Category(
    id: 'agriculture',
    name: 'الزراعة',
    imageUrl: 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=300',
    description: 'معدات زراعية، بذور، أسمدة',
  ),
  Category(
    id: 'electronics',
    name: 'الإلكترونيات',
    imageUrl: 'https://images.unsplash.com/photo-1550009158-9ebf69173e03?w=300',
    description: 'هواتف، كمبيوترات، أجهزة',
  ),
  Category(
    id: 'cars',
    name: 'السيارات',
    imageUrl: 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=300',
    description: 'سيارات جديدة ومستعملة',
  ),
  Category(
    id: 'realestate',
    name: 'العقارات',
    imageUrl: 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=300',
    description: 'شقق، فلل، أراضي',
  ),
  Category(
    id: 'fashion',
    name: 'الأزياء',
    imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300',
    description: 'ملابس، أحذية، إكسسوارات',
  ),
  Category(
    id: 'furniture',
    name: 'الأثاث',
    imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300',
    description: 'غرف نوم، مجالس، مطابخ',
  ),
  Category(
    id: 'restaurants',
    name: 'المطاعم',
    imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300',
    description: 'وجبات، منيو، عروض',
  ),
  Category(
    id: 'services',
    name: 'الخدمات',
    imageUrl: 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=300',
    description: 'خدمات منزلية، مهنية',
  ),
  Category(
    id: 'gaming',
    name: 'الألعاب',
    imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=300',
    description: 'بلاي ستيشن، ألعاب كمبيوتر',
  ),
  Category(
    id: 'beauty',
    name: 'الصحة والجمال',
    imageUrl: 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300',
    description: 'مكياج، عناية بالبشرة',
  ),
  Category(
    id: 'education',
    name: 'التعليم',
    imageUrl: 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=300',
    description: 'كتب، دورات، مستلزمات',
  ),
  Category(
    id: 'baby',
    name: 'مستلزمات الأطفال',
    imageUrl: 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300',
    description: 'ألعاب، ملابس أطفال',
  ),
  Category(
    id: 'sports',
    name: 'الرياضة',
    imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe807baa261?w=300',
    description: 'معدات رياضية، ملابس',
  ),
  Category(
    id: 'jewelry',
    name: 'المجوهرات',
    imageUrl: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300',
    description: 'ذهب، فضة، أحجار كريمة',
  ),
  Category(
    id: 'watches',
    name: 'الساعات',
    imageUrl: 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=300',
    description: 'ساعات فاخرة، رقمية',
  ),
  Category(
    id: 'perfumes',
    name: 'العطور',
    imageUrl: 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=300',
    description: 'عطور رجالية ونسائية',
  ),
  Category(
    id: 'bags',
    name: 'الحقائب',
    imageUrl: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=300',
    description: 'شنط يد، سفر',
  ),
  Category(
    id: 'shoes',
    name: 'الأحذية',
    imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=300',
    description: 'رجالية، نسائية، رياضية',
  ),
  Category(
    id: 'phones',
    name: 'الجوالات',
    imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300',
    description: 'آيفون، سامسونج، شاومي',
  ),
  Category(
    id: 'laptops',
    name: 'الكمبيوترات',
    imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300',
    description: 'لابتوب، اكسسوارات',
  ),
  Category(
    id: 'tv',
    name: 'الشاشات',
    imageUrl: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=300',
    description: 'تلفزيونات، شاشات',
  ),
  Category(
    id: 'home_appliances',
    name: 'الأجهزة المنزلية',
    imageUrl: 'https://images.unsplash.com/photo-1586008214976-3d9d6c5f2e5d?w=300',
    description: 'ثلاجات، غسالات، مكيفات',
  ),
  Category(
    id: 'kitchen',
    name: 'أدوات المطبخ',
    imageUrl: 'https://images.unsplash.com/photo-1556909114-44e3ef1e0d71?w=300',
    description: 'قدور، خلاطات، أواني',
  ),
  Category(
    id: 'tools',
    name: 'أدوات كهربائية',
    imageUrl: 'https://images.unsplash.com/photo-1581147036323-c68037e363f7?w=300',
    description: 'مفكات، مثاقب',
  ),
  Category(
    id: 'construction',
    name: 'مواد البناء',
    imageUrl: 'https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122?w=300',
    description: 'اسمنت، حديد، رمل',
  ),
  Category(
    id: 'medical',
    name: 'المعدات الطبية',
    imageUrl: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=300',
    description: 'أجهزة طبية، مستلزمات',
  ),
  Category(
    id: 'pets',
    name: 'الحيوانات الأليفة',
    imageUrl: 'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=300',
    description: 'طعام، مستلزمات',
  ),
  Category(
    id: 'books',
    name: 'الكتب',
    imageUrl: 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=300',
    description: 'روايات، كتب دينية',
  ),
  Category(
    id: 'flowers',
    name: 'الورود والهدايا',
    imageUrl: 'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=300',
    description: 'باقات ورد، هدايا',
  ),
  Category(
    id: 'bakery',
    name: 'المخبوزات',
    imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=300',
    description: 'خبز، معجنات',
  ),
  Category(
    id: 'grocery',
    name: 'المواد الغذائية',
    imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=300',
    description: 'تمور، أرز، زيت',
  ),
  Category(
    id: 'meat',
    name: 'اللحوم',
    imageUrl: 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=300',
    description: 'لحم، دجاج',
  ),
  Category(
    id: 'vegetables',
    name: 'الخضروات والفواكه',
    imageUrl: 'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?w=300',
    description: 'طازجة يومياً',
  ),
  Category(
    id: 'dairy',
    name: 'منتجات الألبان',
    imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=300',
    description: 'حليب، جبن، زبادي',
  ),
  Category(
    id: 'drinks',
    name: 'المشروبات',
    imageUrl: 'https://images.unsplash.com/photo-1527960471264-932f39eb5846?w=300',
    description: 'عصائر، غازيات',
  ),
  Category(
    id: 'coffee',
    name: 'القهوة',
    imageUrl: 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=300',
    description: 'بن، مكائن قهوة',
  ),
  Category(
    id: 'dates',
    name: 'التمور',
    imageUrl: 'https://images.unsplash.com/photo-1604671801908-29f0cb3b6162?w=300',
    description: 'تمر، عسل',
  ),
  Category(
    id: 'honey',
    name: 'العسل',
    imageUrl: 'https://images.unsplash.com/photo-1587049352847-4a222e784d33?w=300',
    description: 'عسل طبيعي',
  ),
  Category(
    id: 'incense',
    name: 'البخور والعود',
    imageUrl: 'https://images.unsplash.com/photo-1583422409519-37f2e1de7ec9?w=300',
    description: 'عود، بخور، مباخر',
  ),
  Category(
    id: 'carpets',
    name: 'السجاد',
    imageUrl: 'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=300',
    description: 'سجاد، موكيت',
  ),
  Category(
    id: 'lighting',
    name: 'الإضاءة',
    imageUrl: 'https://images.unsplash.com/photo-1565814636199-ae8133055c1c?w=300',
    description: 'ثريات، لمبات',
  ),
  Category(
    id: 'curtains',
    name: 'الستائر',
    imageUrl: 'https://images.unsplash.com/photo-1509644056419-6e2b3f9ee1de?w=300',
    description: 'ستائر، مفروشات',
  ),
  Category(
    id: 'painting',
    name: 'الدهانات',
    imageUrl: 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=300',
    description: 'دهانات، أدوات',
  ),
  Category(
    id: 'plumbing',
    name: 'السباكة',
    imageUrl: 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=300',
    description: 'مواسير، خلاطات',
  ),
  Category(
    id: 'ac',
    name: 'التكييف',
    imageUrl: 'https://images.unsplash.com/photo-1633608607992-28810f6df2db?w=300',
    description: 'مكيفات، صيانة',
  ),
  Category(
    id: 'cleaning',
    name: 'مواد التنظيف',
    imageUrl: 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=300',
    description: 'منظفات، معدات',
  ),
  Category(
    id: 'stationery',
    name: 'القرطاسية',
    imageUrl: 'https://images.unsplash.com/photo-1596496181871-9681eacf9764?w=300',
    description: 'أدوات مكتبية',
  ),
  Category(
    id: 'gifts',
    name: 'الهدايا',
    imageUrl: 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=300',
    description: 'هدايا متنوعة',
  ),
  Category(
    id: 'handicrafts',
    name: 'الحرف اليدوية',
    imageUrl: 'https://images.unsplash.com/photo-1532529867795-3c40b9da7c8e?w=300',
    description: 'منتجات يدوية',
  ),
  Category(
    id: 'antiques',
    name: 'التحف',
    imageUrl: 'https://images.unsplash.com/photo-1561124738-67dab8f6146a?w=300',
    description: 'تحف، عملات',
  ),
  Category(
    id: 'cameras',
    name: 'الكاميرات',
    imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=300',
    description: 'كاميرات، تصوير',
  ),
  Category(
    id: 'drones',
    name: 'الطائرات',
    imageUrl: 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=300',
    description: 'درون، طائرات',
  ),
];

