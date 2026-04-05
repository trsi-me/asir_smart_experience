// بيانات محلية مع صور عسير الحقيقية
class AppData {
  // صور عسير من Visit Saudi ومواقع سياحية
  static const String _rijal = 'https://scth.scene7.com/is/image/scth/rejal-almaa-aseer:crop-1920x1080?defaultImage=rejal-almaa-aseer';
  static const String _soudah = 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/ryYymbaFReNEiGml.jpg';
  static const String _market = 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/iaINwPGODiKWsuZj.jpg';
  static const String _birk = 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/izIZxZLyspbjyifB.webp';

  static const List<Map<String, dynamic>> todayEvents = [
    {'id': '1', 'title': 'مهرجان الضباب', 'time': '٩ ص - ٦ م', 'location': 'أبها', 'image': 'https://tse4.mm.bing.net/th/id/OIP.U5b1M34S1qDwNP1-omJPuwHaE8?rs=1&pid=ImgDetMain&o=7&rm=3'},
    {'id': '2', 'title': 'عرض تراثي', 'time': '٤ م - ٨ م', 'location': 'رجال ألمع', 'image': 'https://www.al-madina.com/uploads/images/2022/12/16/2133869.jpg'},
    {'id': '3', 'title': 'ورشة حرف يدوية', 'time': '١٠ ص - ٢ م', 'location': 'السودة', 'image': 'https://www.alwatan.com.sa/uploads/images/2024/09/18/1086072.jpg'},
  ];

  static const List<Map<String, dynamic>> weekendEvents = [
    {'id': '1', 'title': 'سوق الجمعة', 'day': 'الجمعة', 'location': 'أبها', 'image': 'https://livelovesaudi.net/wp-content/uploads/2024/08/abha_mall4_06d39c684e-1.webp'},
    {'id': '2', 'title': 'مسرح عائلي', 'day': 'السبت', 'location': 'خميس مشيط', 'image': 'https://livelovesaudi.net/wp-content/uploads/2024/08/abha_mall4_06d39c684e-1.webp'},
  ];

  static const List<Map<String, dynamic>> weatherData = [
    {'day': 'اليوم', 'temp': '٢٢°', 'condition': 'مشمس', 'iconId': 'sunny'},
    {'day': 'غداً', 'temp': '١٨°', 'condition': 'ضباب', 'iconId': 'fog'},
    {'day': 'بعد غد', 'temp': '٢٠°', 'condition': 'غائم', 'iconId': 'cloud'},
  ];

  static const List<Map<String, dynamic>> campingSites = [
    {'id': '1', 'name': 'مخيم السودة', 'rating': '٤.٥', 'features': 'مياه، كهرباء', 'image': _soudah},
    {'id': '2', 'name': 'مخيم رغدان', 'rating': '٤.٢', 'features': 'طبيعة', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/ZUydboTpXXeOHPyi.jpg'},
    {'id': '3', 'name': 'مخيم ظلماء', 'rating': '٤.٨', 'features': 'مناظر', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/vnGGqlcAzvcBPfoF.jpg'},
  ];

  static const List<Map<String, dynamic>> hikingTrails = [
    {'id': '1', 'name': 'مسار شلالات حدي', 'distance': '٣ كم', 'difficulty': 'سهل', 'image': 'https://auhm.org/wp-content/uploads/2025/06/download-2-e1751016259647.webp'},
    {'id': '2', 'name': 'مسار غابة رجال ألمع', 'distance': '٥ كم', 'difficulty': 'متوسط', 'image': _rijal},
    {'id': '3', 'name': 'مسار قمة السودة', 'distance': '٧ كم', 'difficulty': 'صعب', 'image': _soudah},
  ];

  static const List<Map<String, dynamic>> coffeePlaces = [
    {'id': '1', 'name': 'مزرعة بن الدوسري', 'discount': '١٥٪', 'type': 'مزرعة', 'image': 'https://portalcdn.spa.gov.sa/backend/original/202508/QLr7RpDdkGFigdrbWrX25Tmh6BgsvzXxdG4CFN9P.jpg'},
    {'id': '2', 'name': 'قهوة رجال ألمع', 'discount': '١٠٪', 'type': 'مقهى', 'image': 'https://tse4.mm.bing.net/th/id/OIP.FfCjS-f97Hn4ZJE9YYYjbgHaNK?rs=1&pid=ImgDetMain&o=7&rm=3'},
    {'id': '3', 'name': 'بن السودة', 'discount': '٢٠٪', 'type': 'متجر', 'image': 'https://www.alwatan.com.sa/uploads/images/2023/02/28/904819.jpeg'},
  ];

  static const List<Map<String, dynamic>> heritagePlaces = [
    {'id': '1', 'name': 'قرية رجال ألمع', 'type': 'قرية تراثية', 'image': _rijal},
    {'id': '2', 'name': 'متحف أبها', 'type': 'متاحف', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/VHkmHGIxpbiYqyeT.jpg'},
    {'id': '3', 'name': 'قصص الحرف اليدوية', 'type': 'قصص نصية', 'image': 'https://www.alwatan.com.sa/uploads/images/2024/09/18/1086072.jpg'},
  ];

  static const List<Map<String, dynamic>> localShops = [
    {'id': '1', 'name': 'أسر منتجة - عسل طبيعي', 'rating': '٤.٧', 'image': _market},
    {'id': '2', 'name': 'أكشاك موسمية - حرف يدوية', 'rating': '٤.٥', 'image': 'https://www.alwatan.com.sa/uploads/images/2024/09/18/1086072.jpg'},
    {'id': '3', 'name': 'متجر المنتجات المحلية', 'rating': '٤.٨', 'image': 'https://tse2.mm.bing.net/th/id/OIP.TowWyGuLmtl3OxyNtmMjPQAAAA?rs=1&pid=ImgDetMain&o=7&rm=3'},
  ];

  static const List<Map<String, dynamic>> seasons = [
    {'id': 'fog', 'name': 'موسم الضباب', 'iconId': 'fog', 'months': 'ديسمبر - فبراير'},
    {'id': 'summer', 'name': 'موسم الصيف', 'iconId': 'sun', 'months': 'يونيو - أغسطس'},
    {'id': 'winter', 'name': 'موسم الشتاء', 'iconId': 'snow', 'months': 'ديسمبر - فبراير'},
    {'id': 'coffee', 'name': 'موسم البن', 'iconId': 'coffee', 'months': 'سبتمبر - نوفمبر'},
    {'id': 'camping', 'name': 'موسم التخييم', 'iconId': 'camping', 'months': 'مارس - مايو'},
    {'id': 'events', 'name': 'موسم الفعاليات', 'iconId': 'events', 'months': 'طوال العام'},
  ];

  static const List<Map<String, dynamic>> accommodationTypes = [
    {'id': '1', 'name': 'فنادق', 'count': '٢٥'},
    {'id': '2', 'name': 'أكواخ', 'count': '١٥'},
    {'id': '3', 'name': 'بيوت تراثية', 'count': '١٠'},
  ];

  static const List<Map<String, dynamic>> transportOptions = [
    {'id': '1', 'name': 'تأجير سيارات'},
    {'id': '2', 'name': 'مرشدين سياحيين'},
    {'id': '3', 'name': 'مسارات جاهزة'},
  ];

  static const List<Map<String, dynamic>> restaurants = [
    {'id': '1', 'name': 'مطعم المناظر', 'type': 'مطعم فاخر', 'image': 'https://www.fatakat-a.com/wp-content/uploads/abha-flavours-1.jpg'},
    {'id': '2', 'name': 'فود ترك المحلية', 'type': 'محلي', 'image': 'https://www.fatakat-a.com/wp-content/uploads/abha-flavours-1.jpg'},
  ];

  static const List<Map<String, dynamic>> coastalPlaces = [
    {'id': '1', 'name': 'شاطئ القحمة', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/MgmeKOzxgkKsSbhI.webp'},
    {'id': '2', 'name': 'شاطئ البرك', 'image': _birk},
  ];
}
