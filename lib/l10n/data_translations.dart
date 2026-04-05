/// ترجمة البيانات - أسماء المواقع، الفعاليات، الطقس
class DataTranslations {
  final bool isArabic;

  DataTranslations(this.isArabic);

  String placeName(String id) => isArabic ? _placeNamesAr[id] ?? id : _placeNamesEn[id] ?? _placeNamesAr[id] ?? id;
  String placeSubtitle(String id) => isArabic ? _placeSubtitlesAr[id] ?? '' : _placeSubtitlesEn[id] ?? _placeSubtitlesAr[id] ?? '';
  String placeDescription(String id) => isArabic ? _placeDescriptionsAr[id] ?? '' : _placeDescriptionsEn[id] ?? _placeDescriptionsAr[id] ?? '';
  String placeImportance(String id) => isArabic ? _placeImportanceAr[id] ?? '' : _placeImportanceEn[id] ?? _placeImportanceAr[id] ?? '';
  List<String> placeActivities(String id) => isArabic ? (_placeActivitiesAr[id] ?? []) : (_placeActivitiesEn[id] ?? _placeActivitiesAr[id] ?? []);
  List<String> placeTips(String id) => isArabic ? (_placeTipsAr[id] ?? []) : (_placeTipsEn[id] ?? _placeTipsAr[id] ?? []);

  String eventTitle(String id) => isArabic ? _eventTitlesAr[id] ?? id : _eventTitlesEn[id] ?? _eventTitlesAr[id] ?? id;
  String weatherDay(String key) => isArabic ? _weatherDaysAr[key] ?? key : _weatherDaysEn[key] ?? key;
  String weatherCondition(String key) => isArabic ? _weatherConditionsAr[key] ?? key : _weatherConditionsEn[key] ?? key;

  static final Map<String, String> _placeNamesAr = {
    'soudah': 'السودة', 'rijal_almaa': 'قرية رجال ألمع التراثية', 'habala': 'قرية الحبلة المعلقة',
    'fatima_museum': 'متحف فاطمة لفن القط العسيري', 'shamsan_castle': 'قلعة شمسان', 'abha_museum': 'متحف أبها الإقليمي',
    'qasr_shada': 'قصر شداء التاريخي', 'tanomah': 'تنومة', 'al_namas': 'النماص', 'jabal_thiran': 'جبل ثهران',
    'rida_reserve': 'محمية ريدة الطبيعية', 'dahna_waterfalls': 'شلالات الدهناء', 'tahlal_park': 'منتزه تهلل الطبيعي',
    'birk_beach': 'شاطئ البرك', 'kadhmbal_island': 'جزيرة جبل كدمبل', 'aseer_waterfront': 'واجهة عسير البحرية',
    'altaelya': 'المدينة العالية', 'abha_dam': 'بحيرة سد أبها', 'fog_walk': 'ممشى الضباب', 'abha_cable': 'تلفريك أبها',
    'tuesday_market': 'سوق الثلاثاء', 'art_street': 'شارع الفن وقرية المفتاحة', 'abha_old_market': 'سوق أبها الشعبي القديم',
    'asir_national_park': 'منتزه عسير الوطني', 'abu_khayal': 'حديقة أبو خيال', 'cloud_garden': 'حديقة السحاب',
    'honey_hut': 'كوخ العسل', 'khamis_mushait': 'خميس مشيط', 'aseer_festival': 'مهرجان عسير وفعالياته', 'bisha': 'محافظة بيشة',
  };

  static final Map<String, String> _placeNamesEn = {
    'soudah': 'Al Soudah', 'rijal_almaa': 'Rijal Almaa Heritage Village', 'habala': 'Habala Hanging Village',
    'fatima_museum': 'Fatima Museum - Asiri Cat Art', 'shamsan_castle': 'Shamsan Castle', 'abha_museum': 'Abha Regional Museum',
    'qasr_shada': 'Qasr Shada Historic Palace', 'tanomah': 'Tanomah', 'al_namas': 'Al Namas', 'jabal_thiran': 'Jabal Thiran',
    'rida_reserve': 'Ridah Nature Reserve', 'dahna_waterfalls': 'Dahna Waterfalls', 'tahlal_park': 'Tahlal Natural Park',
    'birk_beach': 'Al Birk Beach', 'kadhmbal_island': 'Jabal Kadhmbal Island', 'aseer_waterfront': 'Aseer Waterfront',
    'altaelya': 'Al Taelya City', 'abha_dam': 'Abha Dam Lake', 'fog_walk': 'Fog Walk', 'abha_cable': 'Abha Cable Car',
    'tuesday_market': 'Tuesday Market', 'art_street': 'Art Street & Al Muftaha Village', 'abha_old_market': 'Abha Old Market',
    'asir_national_park': 'Aseer National Park', 'abu_khayal': 'Abu Khayal Park', 'cloud_garden': 'Cloud Garden',
    'honey_hut': 'Honey Hut', 'khamis_mushait': 'Khamis Mushait', 'aseer_festival': 'Aseer Festival', 'bisha': 'Bisha Province',
  };

  static final Map<String, String> _placeSubtitlesAr = {
    'soudah': 'أعلى قمة جبلية في المملكة', 'rijal_almaa': 'موقع تراث عالمي - اليونسكو', 'habala': 'عجيبة عسير على جرف 300 متر',
    'fatima_museum': 'فن اليونسكو للتراث غير المادي', 'shamsan_castle': 'قلعة تاريخية شمال شرق أبها', 'abha_museum': 'مرجع شامل لتاريخ عسير',
    'rida_reserve': 'من أكبر المحميات في المملكة', 'dahna_waterfalls': 'أجمل الشلالات في تنومة', 'tahlal_park': 'غابات وأودية وشلالات',
    'birk_beach': 'مياه فيروزية ورمال بيضاء', 'kadhmbal_island': 'جزيرة بركانية في البحر الأحمر', 'asir_national_park': 'أول منتزه وطني في المملكة - 4550 كم²',
  };
  static final Map<String, String> _placeSubtitlesEn = {
    'soudah': 'Highest peak in the Kingdom', 'rijal_almaa': 'UNESCO World Heritage Site', 'habala': 'Aseer wonder on 300m cliff',
    'fatima_museum': 'UNESCO intangible heritage art', 'shamsan_castle': 'Historic castle northeast of Abha', 'abha_museum': 'Comprehensive Aseer history reference',
    'rida_reserve': 'One of the largest reserves in the Kingdom', 'dahna_waterfalls': 'Most beautiful waterfalls in Tanomah', 'tahlal_park': 'Forests, valleys & waterfalls',
    'birk_beach': 'Turquoise waters and white sand', 'kadhmbal_island': 'Volcanic island in the Red Sea', 'asir_national_park': 'First national park in the Kingdom - 4550 km²',
  };

  static final Map<String, String> _placeDescriptionsAr = {
    'soudah': 'تعتبر السودة أعلى قمة جبلية في المملكة العربية السعودية، حيث ترتفع لأكثر من 3000 متر عن سطح البحر. تقع على بعد حوالي 30 كيلومترًا من مدينة أبها، وتتميز بغاباتها الكثيفة من أشجار العرعر المعمرة، وأجوائها الباردة والممطرة معظم أيام السنة، والضباب الكثيف الذي يغطيها في الصباح الباكر والمساء، مما يمنحها منظرًا طبيعيًا خلابًا. يعود اسم "السودة" إلى الصخور السوداء البركانية التي تكثر في المنطقة.',
    'rijal_almaa': 'قرية رجال ألمع هي قرية تراثية فريدة تقع في محافظة رجال ألمع بمنطقة عسير، على بعد حوالي 45 كيلومترًا غرب مدينة أبها. يعود تاريخ القرية إلى أكثر من 900 عام، وكانت مركزًا تجاريًا هامًا على الطريق الذي يربط بين اليمن ومكة المكرمة والمدينة المنورة. تتميز القرية بمبانيها الحجرية الشاهقة التي تصل إلى ثمانية طوابق، والمزينة بالكوارتز الأبيض والملون.',
    'habala': 'قرية الحبلة هي إحدى عجائب منطقة عسير، وتقع على بعد حوالي 55 كيلومترًا جنوب شرق مدينة أبها. سُميت بالقرية "المعلقة" لأنها تقع على جرف صخري حاد على ارتفاع حوالي 300 متر، وكان الوصول إليها في الماضي يتم فقط عبر سلالم من الحبال. يعود تاريخ القرية إلى أكثر من 370 عامًا.',
  };
  static final Map<String, String> _placeDescriptionsEn = {
    'soudah': 'Al Soudah is the highest mountain peak in Saudi Arabia, rising over 3,000 meters above sea level. Located about 30 km from Abha, it features dense juniper forests, cool rainy weather most of the year, and thick morning and evening fog that creates stunning natural scenery. The name "Soudah" comes from the black volcanic rocks found throughout the area.',
    'rijal_almaa': 'Rijal Almaa is a unique heritage village in Rijal Almaa province, about 45 km west of Abha. The village dates back over 900 years and was an important trading center on the route linking Yemen, Mecca, and Medina. It features towering stone buildings up to eight stories high, decorated with white and colored quartz.',
    'habala': 'Habala Village is one of Aseer\'s wonders, located about 55 km southeast of Abha. It is called the "Hanging Village" because it sits on a steep cliff about 300 meters high; in the past, access was only via rope ladders. The village dates back over 370 years.',
  };

  static final Map<String, String> _placeImportanceAr = {
    'soudah': 'تكمن أهمية السودة في كونها المصيف الأول في المملكة العربية السعودية، حيث توفر تجربة سياحية فريدة تجمع بين الطبيعة الساحرة والمغامرة والتراث. تعتبر وجهة مثالية لمحبي الطبيعة والتصوير الفوتوغرافي والمشي لمسافات طويلة (الهايكنج).',
    'rijal_almaa': 'تعتبر قرية رجال ألمع من أهم المواقع التراثية في المملكة العربية السعودية، وهي مدرجة في قائمة مواقع التراث العالمي لليونسكو. تمثل القرية نموذجًا استثنائيًا للتراث المعماري والثقافي لمنطقة عسير.',
    'habala': 'تكمن أهمية الحبلة في موقعها الجغرافي الفريد وتاريخها العريق. توفر تجربة سياحية لا مثيل لها، حيث تجمع بين جمال الطبيعة الخلابة وإثارة المغامرة والتراث الإنساني.',
  };
  static final Map<String, String> _placeImportanceEn = {
    'soudah': 'Al Soudah is Saudi Arabia\'s premier summer destination, offering a unique tourism experience combining stunning nature, adventure, and heritage. It is ideal for nature lovers, photography, and hiking.',
    'rijal_almaa': 'Rijal Almaa is one of the most important heritage sites in Saudi Arabia and is listed as a UNESCO World Heritage Site. The village represents an exceptional example of Aseer\'s architectural and cultural heritage.',
    'habala': 'Habala\'s importance lies in its unique geographic location and rich history. It offers an unparalleled tourism experience combining stunning nature, adventure, and human heritage.',
  };

  static final Map<String, List<String>> _placeActivitiesAr = {
    'soudah': ['ركوب التلفريك', 'المشي والتخييم', 'التصوير الفوتوغرافي', 'زيارة القرى التراثية', 'الاستمتاع بالأجواء'],
    'rijal_almaa': ['استكشاف القرية', 'زيارة متحف رجال ألمع', 'فن القط العسيري', 'التسوق', 'المناظر الطبيعية'],
    'habala': ['ركوب التلفريك', 'استكشاف القرية', 'المناظر الطبيعية', 'التنزه في المنتزه العلوي'],
  };
  static final Map<String, List<String>> _placeActivitiesEn = {
    'soudah': ['Cable car ride', 'Hiking and camping', 'Photography', 'Visiting heritage villages', 'Enjoying the atmosphere'],
    'rijal_almaa': ['Exploring the village', 'Visiting Rijal Almaa Museum', 'Asiri cat art', 'Shopping', 'Scenic views'],
    'habala': ['Cable car ride', 'Exploring the village', 'Scenic views', 'Walking in the upper park'],
  };

  static final Map<String, List<String>> _placeTipsAr = {
    'soudah': ['أفضل وقت: يونيو - سبتمبر', 'ملابس ثقيلة وأحذية مريحة', 'تحقق من الطقس', 'حذر في الطرق الجبلية'],
    'rijal_almaa': ['طوال العام، الشتاء مفضل', 'رسوم رمزية للدخول', 'تلفريك السودة يصل للقرية', 'أحذية مريحة'],
    'habala': ['التلفريك: مايو - أكتوبر', 'رسوم للتلفريك', 'صباح أو بعد الظهر', 'حذر مع الأطفال'],
  };
  static final Map<String, List<String>> _placeTipsEn = {
    'soudah': ['Best time: June - September', 'Warm clothes and comfortable shoes', 'Check weather', 'Caution on mountain roads'],
    'rijal_almaa': ['Year round, winter preferred', 'Symbolic entrance fee', 'Al Soudah cable car reaches the village', 'Comfortable shoes'],
    'habala': ['Cable car: May - October', 'Cable car fees apply', 'Morning or afternoon', 'Caution with children'],
  };

  static final Map<String, String> _eventTitlesAr = {
    '1': 'مهرجان الضباب', '2': 'عرض تراثي', '3': 'ورشة حرف يدوية',
    'سوق الجمعة': 'سوق الجمعة', 'مسرح عائلي': 'مسرح عائلي',
  };
  static final Map<String, String> _eventTitlesEn = {
    '1': 'Fog Festival', '2': 'Heritage Show', '3': 'Handicrafts Workshop',
    'سوق الجمعة': 'Friday Market', 'مسرح عائلي': 'Family Theater',
  };

  static final Map<String, String> _weatherDaysAr = {'اليوم': 'اليوم', 'غداً': 'غداً', 'بعد غد': 'بعد غد'};
  static final Map<String, String> _weatherDaysEn = {'اليوم': 'Today', 'غداً': 'Tomorrow', 'بعد غد': 'Day after'};

  static final Map<String, String> _weatherConditionsAr = {'مشمس': 'مشمس', 'ضباب': 'ضباب', 'غائم': 'غائم'};
  static final Map<String, String> _weatherConditionsEn = {'مشمس': 'Sunny', 'ضباب': 'Foggy', 'غائم': 'Cloudy'};

  /// ترجمة نص من البيانات - إذا وُجدت ترجمة استخدمها وإلا أرجع الأصلي
  String t(String? ar, String? en) => isArabic ? (ar ?? en ?? '') : (en ?? ar ?? '');
}
