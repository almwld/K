import '../widgets/date_picker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/simple_app_bar.dart';
import '../models/user_model.dart';

class IdentityInfoScreen extends StatefulWidget {
  final UserModel userData;
  
  const IdentityInfoScreen({super.key, required this.userData});

  @override
  State<IdentityInfoScreen> createState() => _IdentityInfoScreenState();
}

class _IdentityInfoScreenState extends State<IdentityInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // بيانات الهوية
  final _idNumberController = TextEditingController();
  final _idIssuerController = TextEditingController();
  final _idExpiryController = TextEditingController();
  final _nationalityController = TextEditingController();
  String _idType = 'national_id';
  
  // معلومات إضافية
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  // تواريخ منفصلة
  int? _birthYear;
  int? _birthMonth;
  int? _birthDay;
  int? _idExpiryYear;
  int? _idExpiryMonth;
  int? _idExpiryDay;
  final _districtController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _companyNameController = TextEditingController();
  
  // الملفات المرفوعة
  File? _idFrontImage;
  File? _idBackImage;
  File? _personalPhoto;
  
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  late AnimationController _progressController;
  
  final ImagePicker _picker = ImagePicker();
  
  final List<String> _cities = [
    'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 
    'إب', 'ذمار', 'صعدة', 'حضرموت', 'سيئون'
  ];
  
  final List<String> _nationalities = [
    'يمني', 'سعودي', 'إماراتي', 'كويتي', 'قطري', 
    'بحريني', 'عماني', 'مصري', 'أردني', 'سوري', 'فلسطيني', 'لبناني'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _progressController.dispose();
    _idNumberController.dispose();
    _idIssuerController.dispose();
    _idExpiryController.dispose();
    _nationalityController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _jobTitleController.dispose();
    _companyNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, Function(File) onImagePicked) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        onImagePicked(File(image.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: DateTime.now().subtract(const Duration(days: 100 * 365)),
      lastDate: DateTime.now(),
      locale: const Locale('ar', 'YE'),
    );
    if (picked != null) {
      setState(() {
        controller.text = '${picked.year}/${picked.month}/${picked.day}';
      });
    }
  }

  void _showImagePickerDialog(Function(File) onImagePicked) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر مصدر الصورة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  icon: Icons.camera_alt,
                  label: 'كاميرا',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera, onImagePicked);
                  },
                ),
                _buildImageSourceOption(
                  icon: Icons.photo_library,
                  label: 'المعرض',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery, onImagePicked);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.goldColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.goldColor, size: 32),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadCard(String title, File? imageFile, Function(File) onImagePicked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: imageFile != null ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
          width: imageFile != null ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _showImagePickerDialog(onImagePicked),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(imageFile, fit: BoxFit.cover, width: double.infinity),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload, color: AppTheme.goldColor, size: 40),
                          const SizedBox(height: 8),
                          Text('اضغط لرفع الصورة', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitIdentity() async {
    if (_idNumberController.text.isEmpty) {
      _showSnackBar('يرجى إدخال رقم الهوية', Colors.red);
      return;
    }
    if (_nationalityController.text.isEmpty) {
      _showSnackBar('يرجى اختيار الجنسية', Colors.red);
      return;
    }
      _showSnackBar('يرجى إدخال تاريخ الميلاد', Colors.red);
      return;
    }
    if (_idFrontImage == null || _idBackImage == null) {
      _showSnackBar('يرجى رفع صورة الهوية (الأمام والخلف)', Colors.red);
      return;
    }
    
    setState(() => _isUploading = true);
    _progressController.forward();
    
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => _uploadProgress = i / 10);
    }
    
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      setState(() => _isUploading = false);
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم إرسال البيانات'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            const Text('تم إرسال بيانات الهوية بنجاح'),
            const SizedBox(height: 8),
            Text('سيتم مراجعة بياناتك من قبل فريق الدعم خلال 24 ساعة', textAlign: TextAlign.center),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/main');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
            child: const Text('متابعة إلى التطبيق'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'بيانات الهوية'),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: AppTheme.getCardColor(context),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: AppTheme.goldColor,
                  labelColor: AppTheme.goldColor,
                  unselectedLabelColor: AppTheme.getSecondaryTextColor(context),
                  tabs: const [
                    Tab(text: 'الهوية', icon: Icon(Icons.badge)),
                    Tab(text: 'معلومات إضافية', icon: Icon(Icons.info)),
                    Tab(text: 'المستندات', icon: Icon(Icons.upload_file)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildIdentityTab(),
                    _buildAdditionalInfoTab(),
                    _buildDocumentsTab(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  border: Border(top: BorderSide(color: AppTheme.getDividerColor(context))),
                ),
                child: CustomButton(
                  text: 'إرسال للمراجعة',
                  onPressed: _submitIdentity,
                  isLoading: _isUploading,
                ),
              ),
            ],
          ),
          if (_isUploading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: AppTheme.goldColor),
                      const SizedBox(height: 16),
                      Text('جاري رفع المستندات...'),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: _uploadProgress, color: AppTheme.goldColor),
                      const SizedBox(height: 8),
                      Text('${(_uploadProgress * 100).toInt()}%'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIdentityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('نوع الهوية', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildIdTypeOption('national_id', 'بطاقة هوية', Icons.credit_card),
                    const SizedBox(width: 12),
                    _buildIdTypeOption('passport', 'جواز سفر', Icons.airplane_ticket),
                    const SizedBox(width: 12),
                    _buildIdTypeOption('driver_license', 'رخصة قيادة', Icons.drive_eta),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _idNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'رقم الهوية',
              prefixIcon: const Icon(Icons.numbers),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _idIssuerController,
            decoration: InputDecoration(
              labelText: 'جهة الإصدار',
              hintText: 'مثال: الأحوال المدنية',
              prefixIcon: const Icon(Icons.business),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _idExpiryController,
            readOnly: true,
            onTap: () => _selectDate(_idExpiryController),
            decoration: InputDecoration(
              labelText: 'تاريخ الانتهاء',
              prefixIcon: const Icon(Icons.calendar_today),
              suffixIcon: const Icon(Icons.arrow_drop_down),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _nationalityController.text.isEmpty ? null : _nationalityController.text,
            decoration: InputDecoration(
              labelText: 'الجنسية',
              prefixIcon: const Icon(Icons.public),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: _nationalities.map((nationality) {
              return DropdownMenuItem(value: nationality, child: Text(nationality));
            }).toList(),
            onChanged: (value) => setState(() => _nationalityController.text = value ?? ''),
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'تاريخ الميلاد',
              prefixIcon: const Icon(Icons.cake),
              suffixIcon: const Icon(Icons.arrow_drop_down),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdTypeOption(String value, String label, IconData icon) {
    final isSelected = _idType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _idType = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppTheme.goldColor : Colors.grey),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 12, color: isSelected ? AppTheme.goldColor : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _addressController,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'العنوان التفصيلي',
              prefixIcon: const Icon(Icons.location_on),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _cityController.text.isEmpty ? null : _cityController.text,
            decoration: InputDecoration(
              labelText: 'المدينة',
              prefixIcon: const Icon(Icons.location_city),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: _cities.map((city) {
              return DropdownMenuItem(value: city, child: Text(city));
            }).toList(),
            onChanged: (value) => setState(() => _cityController.text = value ?? ''),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _districtController,
            decoration: InputDecoration(
              labelText: 'الحي / المنطقة',
              prefixIcon: const Icon(Icons.map),
              filled: true,
              fillColor: AppTheme.getCardColor(context),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('المعلومات المهنية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                TextField(
                  controller: _jobTitleController,
                  decoration: InputDecoration(
                    labelText: 'المسمى الوظيفي',
                    prefixIcon: const Icon(Icons.work),
                    filled: true,
                    fillColor: AppTheme.getCardColor(context),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _companyNameController,
                  decoration: InputDecoration(
                    labelText: 'اسم جهة العمل',
                    prefixIcon: const Icon(Icons.business),
                    filled: true,
                    fillColor: AppTheme.getCardColor(context),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildImageUploadCard('صورة الهوية (الوجه الأمامي)', _idFrontImage, (file) {
            setState(() => _idFrontImage = file);
          }),
          _buildImageUploadCard('صورة الهوية (الوجه الخلفي)', _idBackImage, (file) {
            setState(() => _idBackImage = file);
          }),
          _buildImageUploadCard('صورة شخصية حديثة', _personalPhoto, (file) {
            setState(() => _personalPhoto = file);
          }),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppTheme.goldColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'يجب أن تكون الصور واضحة ومقروءة. الصيغ المدعومة: JPG, PNG',
                    style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
