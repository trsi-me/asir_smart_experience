/// ترجمة التطبيق الكاملة - عربي / إنجليزي
class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale);

  bool get isArabic => locale.startsWith('ar');

  // عام
  String get appName => isArabic ? 'عسير' : 'Aseer';
  String get appSubtitle => isArabic ? 'التجربة الذكية' : 'Smart Experience';
  String get explore => isArabic ? 'استكشف' : 'Explore';
  String get back => isArabic ? 'رجوع' : 'Back';
  String get cancel => isArabic ? 'إلغاء' : 'Cancel';
  String get save => isArabic ? 'حفظ' : 'Save';
  String get add => isArabic ? 'إضافة' : 'Add';
  String get loading => isArabic ? 'جاري التحميل...' : 'Loading...';

  // الصفحة الرئيسية
  String get passport => isArabic ? 'جواز عسير' : 'Aseer Passport';
  String get passportSub => isArabic ? 'أختام ومكافآت' : 'Stamps & rewards';
  String get placesGuide => isArabic ? 'دليل المواقع' : 'Places Guide';
  String get placesGuideSub =>
      isArabic ? 'كل المواقع السياحية' : 'All tourist sites';
  String get today => isArabic ? 'وش فيه اليوم؟' : "What's on today?";
  String get todaySub => isArabic ? 'فعاليات الآن' : 'Events now';
  String get weather => isArabic ? 'جوّك اليوم' : "Your day's weather";
  String get weatherSub => isArabic ? 'الطقس والتوصيات' : 'Weather & tips';
  String get maps => isArabic ? 'خرائط المواقع' : 'Maps';
  String get mapsSub => isArabic ? 'عسير على الخريطة' : 'Aseer on map';
  String get camping => isArabic ? 'نخيم؟' : 'Camping?';
  String get campingSub => isArabic ? 'مواقع التخييم' : 'Camp sites';
  String get hiking => isArabic ? 'نطلع نتمشى' : 'Hiking';
  String get hikingSub => isArabic ? 'مسارات وطبيعة' : 'Trails & nature';
  String get coffee => isArabic ? 'قهوتنا غير' : 'Our Coffee';
  String get coffeeSub => isArabic ? 'قهوة جنوبية' : 'Southern coffee';
  String get heritage => isArabic ? 'من زمان' : 'Heritage';
  String get heritageSub => isArabic ? 'تراث عسير' : 'Aseer heritage';
  String get local => isArabic ? 'من أهلها' : 'From locals';
  String get localSub => isArabic ? 'أسر منتجة' : 'Local producers';
  String get seasons => isArabic ? 'مواسم عسير' : 'Aseer seasons';
  String get seasonsSub => isArabic ? 'طوال العام' : 'Year round';
  String get services => isArabic ? 'الخدمات السياحية' : 'Tourism services';
  String get servicesSub => isArabic ? 'سكن ومواصلات' : 'Accommodation';
  String get food => isArabic ? 'التجارب الغذائية' : 'Food experiences';
  String get foodSub => isArabic ? 'مطاعم وتذوق' : 'Restaurants';
  String get shopping => isArabic ? 'التسوق والترفيه' : 'Shopping & fun';
  String get shoppingSub => isArabic ? 'أسواق ومولات' : 'Markets';
  String get coastal => isArabic ? 'الساحل' : 'Coast';
  String get coastalSub => isArabic ? 'القحمة والبرك' : 'Beaches';
  String get account => isArabic ? 'الحساب' : 'Account';
  String get logout => isArabic ? 'تسجيل الخروج' : 'Log out';
  String get guest => isArabic ? 'زائر' : 'Guest';

  // تسجيل الدخول والتسجيل
  String get login => isArabic ? 'تسجيل الدخول' : 'Login';
  String get loginButton => isArabic ? 'دخول' : 'Sign in';
  String get email => isArabic ? 'البريد الإلكتروني' : 'Email';
  String get password => isArabic ? 'كلمة المرور' : 'Password';
  String get enterEmail => isArabic ? 'أدخل البريد' : 'Enter email';
  String get enterPassword => isArabic ? 'أدخل كلمة المرور' : 'Enter password';
  String get createAccount => isArabic ? 'إنشاء حساب جديد' : 'Create account';
  String get registerTitle => isArabic ? 'إنشاء حساب' : 'Register';
  String get newAccount => isArabic ? 'حساب جديد' : 'New account';
  String get fullName => isArabic ? 'الاسم الكامل' : 'Full name';
  String get enterName => isArabic ? 'أدخل الاسم' : 'Enter name';
  String get phoneOptional =>
      isArabic ? 'رقم الجوال (اختياري)' : 'Phone (optional)';
  String get passwordMin => isArabic
      ? 'كلمة المرور (٦ أحرف على الأقل)'
      : 'Password (min 6 characters)';
  String get confirmPassword =>
      isArabic ? 'تأكيد كلمة المرور' : 'Confirm password';
  String get passwordMismatch =>
      isArabic ? 'غير متطابقة' : 'Passwords do not match';
  String get minChars =>
      isArabic ? '٦ أحرف على الأقل' : 'At least 6 characters';
  String get registerButton => isArabic ? 'إنشاء الحساب' : 'Create account';
  String get loginError => isArabic
      ? 'البريد أو كلمة المرور غير صحيحة'
      : 'Invalid email or password';
  String get errorOccurred => isArabic ? 'حدث خطأ' : 'An error occurred';
  String get demoCredentials => isArabic
      ? 'تجربة: guest@asir.sa / 123456'
      : 'Demo: guest@asir.sa / 123456';

  // تفاصيل الموقع
  String get descriptionHistory =>
      isArabic ? 'وصف وتاريخ' : 'Description & history';
  String get whyImportant => isArabic ? 'لماذا هو مهم' : 'Why it matters';
  String get activities => isArabic ? 'الأنشطة السياحية' : 'Activities';
  String get tips => isArabic ? 'نصائح' : 'Tips';
  String get openInMaps => isArabic ? 'فتح في الخريطة' : 'Open in Maps';
  String get bookExperience => isArabic ? 'احجز التجربة' : 'Book experience';
  String get visitorComments =>
      isArabic ? 'تعليقات الزوار' : 'Visitor comments';
  String get addPhoto => isArabic ? 'أضف صورة' : 'Add photo';
  String get addComment => isArabic ? 'أضف تعليق' : 'Add comment';
  String get writeComment =>
      isArabic ? 'اكتب تعليقك...' : 'Write your comment...';
  String get visitorPhotos => isArabic ? 'صور الزوار' : 'Visitor photos';
  String get stampAdded =>
      isArabic ? 'تم ختم الجواز! +10 نقاط' : 'Passport stamped! +10 points';
  String get visitRecordedSuccess => isArabic
      ? 'تم تسجيل الزيارة بنجاح! أكمل ٣ زيارات للحصول على الشهادة'
      : 'Visit recorded! Complete 3 visits to earn the certificate';
  String get registerVisit => isArabic ? 'تسجيل الزيارة' : 'Register visit';
  String get visitRegistered => isArabic ? 'تم تسجيل الزيارة' : 'Visit registered';
  String get withdrawVisit => isArabic ? 'سحب الزيارة' : 'Withdraw visit';
  String get withdrawVisitConfirm => isArabic
      ? 'سحب هذه الزيارة سيحذف الختم ويُسحب استحقاق الشهادة إن قلّت الزيارات عن ٣'
      : 'Withdrawing will remove this stamp and may revoke your certificate if visits drop below 3';
  String get photoUploadNote => isArabic
      ? 'يمكن ربط التطبيق بمكتبة الصور لاحقاً'
      : 'Photo library integration coming soon';
  String get pickFromGallery => isArabic ? 'من المعرض' : 'Gallery';
  String get takePhoto => isArabic ? 'التقط صورة' : 'Camera';
  String get photoAdded => isArabic ? 'تمت إضافة الصورة' : 'Photo added';
  String get photoAddFailed => isArabic ? 'فشل رفع الصورة' : 'Failed to add photo';

  // القهوة
  String get southernCoffee => isArabic ? 'قهوة جنوبية' : 'Southern coffee';
  String get coffeeInfo => isArabic
      ? 'تجربة تذوق القهوة الجنوبية، منتجات محلية، خصومات جواز عسير'
      : 'Southern coffee tasting, local products, Aseer Passport discounts';
  String get discount => isArabic ? 'خصم' : 'discount';

  // جواز عسير
  String get points => isArabic ? 'نقطة' : 'points';
  String get stamps => isArabic ? 'أختام' : 'Stamps';
  String get badges => isArabic ? 'أوسمة' : 'Badges';
  String get overview => isArabic ? 'نظرة عامة' : 'Overview';
  String get challenges => isArabic ? 'تحديات' : 'Challenges';
  String get trips => isArabic ? 'رحلات' : 'Trips';
  String get certificate => isArabic ? 'شهادة' : 'Certificate';
  String get seasonalStamps => isArabic ? 'أختام موسمية' : 'Seasonal stamps';
  String get rewardsDiscounts =>
      isArabic ? 'مكافآت وخصومات' : 'Rewards & discounts';
  String get addStampDemo => isArabic ? 'إضافة ختم تجريبي' : 'Add demo stamp';
  String get noStampsYet => isArabic ? 'لا توجد أختام بعد' : 'No stamps yet';
  String get addStamp => isArabic ? 'إضافة ختم' : 'Add stamp';
  String get addTrip => isArabic ? 'إضافة رحلة' : 'Add trip';
  String get noTrips => isArabic ? 'لا توجد رحلات مسجلة' : 'No trips recorded';
  String get destination => isArabic ? 'الوجهة' : 'Destination';
  String get date => isArabic ? 'التاريخ' : 'Date';
  String get digitalCertificate =>
      isArabic ? 'شهادة سياحية رقمية' : 'Digital tourism certificate';
  String get certificatePending =>
      isArabic ? 'شهادة قيد الإكمال' : 'Certificate in progress';
  String get certificateComplete => isArabic
      ? 'مبروك! أكملت متطلبات الشهادة'
      : 'Congratulations! You completed the certificate requirements';
  String get certificateHint => isArabic
      ? 'أكمل ٣ زيارات على الأقل للحصول على الشهادة'
      : 'Complete at least 3 visits to earn the certificate';
  String get inProgress => isArabic ? 'قيد التقدم' : 'In progress';
  String get offer => isArabic ? 'عرض' : 'Offer';
  String get demo => isArabic ? 'تجريبي' : 'Demo';

  // الحجز
  String get booking => isArabic ? 'حجز' : 'Booking';
  String get bookingHint => isArabic
      ? 'خيارات السكن والمواصلات المقترحة لك تلقائياً'
      : 'Accommodation and transport options suggested for you';
  String get confirmBooking => isArabic ? 'تأكيد الحجز' : 'Confirm booking';
  String get bookingSuccess => isArabic ? 'تم الحجز بنجاح!' : 'Booking successful!';
  String get myBookings => isArabic ? 'حجوزاتي' : 'My bookings';
  String get noBookings => isArabic ? 'لا توجد حجوزات' : 'No bookings yet';
  String get suggestedAccommodation =>
      isArabic ? 'السكن المقترح' : 'Suggested accommodation';
  String get transport => isArabic ? 'المواصلات' : 'Transport';
  String get carRental => isArabic ? 'تأجير سيارات' : 'Car rental';
  String get tourGuides => isArabic ? 'مرشدين سياحيين' : 'Tour guides';
  String get readyRoutes => isArabic ? 'مسارات جاهزة' : 'Ready routes';
  String get optionsCount => isArabic ? 'خيار' : 'options';

  // الطقس
  String get fogRainAlerts =>
      isArabic ? 'تنبيهات الضباب والمطر' : 'Fog & rain alerts';
  String get upcomingForecast =>
      isArabic ? 'توقعات الأيام القادمة' : 'Upcoming forecast';
  String get weatherSuggestions =>
      isArabic ? 'اقتراحات حسب الطقس' : 'Weather-based suggestions';
  String get smart => isArabic ? 'ذكي' : 'Smart';
  String get todaySuggestions =>
      isArabic ? 'اقتراحات اليوم' : "Today's suggestions";

  // دليل المواقع
  String get placesGuideIntro => isArabic
      ? 'دليل المواقع السياحية في عسير'
      : 'Tourist sites guide in Aseer';
  String get placesGuideTitle => isArabic ? 'دليل عسير' : 'Aseer Guide';

  // فئات المواقع
  String get catHeritage => isArabic ? 'التراث والثقافة' : 'Heritage & culture';
  String get catNature =>
      isArabic ? 'الطبيعة والمغامرات' : 'Nature & adventures';
  String get catCoastal => isArabic ? 'السواحل والشواطئ' : 'Beaches & coast';
  String get catEntertainment =>
      isArabic ? 'الترفيه والمعالم' : 'Entertainment & landmarks';
  String get catShopping => isArabic ? 'الأسواق والفنون' : 'Markets & arts';
  String get catParks => isArabic ? 'المنتزهات والحدائق' : 'Parks & gardens';
  String get catCulture => isArabic ? 'الثقافة والفعاليات' : 'Culture & events';
  String get catCoffee => isArabic ? 'قهوة جنوبية' : 'Southern coffee';

  // فعاليات
  String get todayEvents => isArabic ? 'فعاليات اليوم' : "Today's events";
  String get personalizedRecommendations =>
      isArabic ? 'توصيات مخصّصة' : 'Personalized recommendations';
  String get discoverWhatAwaits =>
      isArabic ? 'اكتشف ما ينتظرك' : 'Discover what awaits you';

  // خرائط
  String get mapsAndLocations =>
      isArabic ? 'الخرائط والمواقع' : 'Maps & locations';
  String get aseerOnMap => isArabic ? 'مواقع عسير على الخريطة' : 'Aseer on map';
  String get tapToOpenGoogleMaps =>
      isArabic ? 'اضغط لفتح في خرائط جوجل' : 'Tap to open in Google Maps';
  String get locAbha => isArabic ? 'أبها' : 'Abha';
  String get locSoudah => isArabic ? 'السودة' : 'Al Soudah';
  String get locRijal => isArabic ? 'رجال ألمع' : 'Rijal Almaa';
  String get locBirk => isArabic ? 'البرك' : 'Al Birk';
  String get locQahma => isArabic ? 'القحمة' : 'Al Qahma';
  String get locKhamis => isArabic ? 'خميس مشيط' : 'Khamis Mushait';
  String get descAseerCapital => isArabic ? 'عاصمة عسير' : 'Aseer capital';
  String get descHighestPeak => isArabic ? 'أعلى قمة' : 'Highest peak';
  String get descHeritageVillage =>
      isArabic ? 'قرية تراثية' : 'Heritage village';
  String get descAseerCoast => isArabic ? 'ساحل عسير' : 'Aseer coast';
  String get descBeach => isArabic ? 'شاطئ' : 'Beach';
  String get descMainCity => isArabic ? 'مدينة رئيسية' : 'Main city';

  // تخييم
  String get campingInAseer =>
      isArabic ? 'التخييم في عسير' : 'Camping in Aseer';
  String get safetyAlerts => isArabic ? 'تنبيهات أمان' : 'Safety alerts';
  String get safetyTip1 =>
      isArabic ? 'تحقق من الطقس قبل التخييم' : 'Check weather before camping';
  String get safetyTip2 =>
      isArabic ? 'تجنب المناطق المعرضة للسيول' : 'Avoid flood-prone areas';
  String get safetyTip3 =>
      isArabic ? 'احتفظ بوسائل الإسعافات الأولية' : 'Keep first aid supplies';

  // مشي
  String get aseerNature => isArabic ? 'طبيعة عسير' : 'Aseer nature';
  String get trailsAndNatureAseer =>
      isArabic ? 'مسارات وطبيعة عسير' : 'Trails & nature in Aseer';
  String get waterfallsAndForests => isArabic
      ? 'شلالات وغابات ونقاط تصوير'
      : 'Waterfalls, forests & photo spots';
  String get waterfallShrayan => isArabic
      ? 'شلالات حدي - وادي شريان'
      : 'Hadhi waterfalls - Shrayan valley';
  String get forestSoudah =>
      isArabic ? 'غابات السودة ورغدان' : 'Al Soudah & Raghadan forests';
  String get photoSoudah => isArabic
      ? 'نقاط تصوير: قمة السودة، منحدرات أبها'
      : 'Photo spots: Al Soudah peak, Abha slopes';

  // تراث
  String get heritageAseer => isArabic ? 'تراث عسير' : 'Aseer heritage';
  String get heritageStampNote => isArabic
      ? 'ختم "عشت التراث" متوفر عند زيارة المواقع التراثية'
      : '"Heritage lived" stamp available when visiting heritage sites';

  // تسوق وترفيه
  String get marketsAndEntertainment =>
      isArabic ? 'أسواق وترفيه' : 'Markets & entertainment';

  // ساحل
  String get aseerCoasts => isArabic ? 'سواحل عسير' : 'Aseer coasts';
  String get coastalNote => isArabic
      ? 'دمج سياحة الجبل والبحر في تجربة واحدة - شواطئ، سباحة، غوص، رحلات بحرية'
      : 'Mountain & sea tourism in one - beaches, swimming, diving, boat trips';

  // من أهلها
  String get supportLocalEconomy =>
      isArabic ? 'دعم الاقتصاد المحلي' : 'Support local economy';

  // مواسم
  String get seasonsExperiences => isArabic
      ? 'تجارب • فعاليات • عروض • أختام • سكن مقترح'
      : 'Experiences • Events • Offers • Stamps • Suggested accommodation';

  // خدمات
  String get accommodation => isArabic ? 'السكن' : 'Accommodation';
  String get transportCarRental => isArabic ? 'تأجير سيارات' : 'Car rental';
  String get transportGuides => isArabic ? 'مرشدين سياحيين' : 'Tour guides';
  String get transportRoutes => isArabic ? 'مسارات جاهزة' : 'Ready routes';
  String get smartFeature => isArabic ? 'ميزة ذكية' : 'Smart feature';
  String get smartFeatureDesc => isArabic
      ? 'عند حجز تجربة → تظهر خيارات السكن والمواصلات تلقائياً'
      : 'When booking → accommodation & transport options appear automatically';

  // غذاء
  String get restaurantsSection => isArabic ? 'المطاعم' : 'Restaurants';
  String get foodTrucksAndBooking => isArabic
      ? 'فود ترك وحجز وتوصيات'
      : 'Food trucks, booking & recommendations';
  String get foodTypes => isArabic
      ? 'مطاعم محلية، فاخرة، عائلية، مطلة'
      : 'Local, fine dining, family, scenic';
  String get foodTrucksDirect =>
      isArabic ? 'فود ترك وحجز مباشر' : 'Food trucks & direct booking';
  String get localRecommendations =>
      isArabic ? 'توصيات السكان المحليين' : 'Local recommendations';

  // جواز - موسمية
  String get stampFog => isArabic ? 'الضباب' : 'Fog';
  String get stampCoffee => isArabic ? 'البن' : 'Coffee';
  String get stampSummer => isArabic ? 'الصيف' : 'Summer';
  String get stampWinter => isArabic ? 'الشتاء' : 'Winter';

  // جواز - مكافآت
  String get reward1 =>
      isArabic ? 'خصم ١٠٪ في قهوة رجال ألمع' : '10% off at Rijal Almaa Coffee';
  String get reward2 =>
      isArabic ? 'خصم ١٥٪ في مزرعة البن' : '15% off at coffee farm';
  String get reward3 =>
      isArabic ? 'خصومات تجريبية - للعرض فقط' : 'Demo discounts - display only';

  // جواز - تحديات
  String get challenge1 =>
      isArabic ? 'زر ٣ مواقع تراثية' : 'Visit 3 heritage sites';
  String get challenge2 =>
      isArabic ? 'تذوق القهوة الجنوبية' : 'Taste southern coffee';
  String get challenge3 => isArabic ? 'مخيم ليلة واحدة' : 'Camp one night';

  // جواز - أماكن الختم
  String get placeFogSeason => isArabic ? 'موسم الضباب' : 'Fog Season';
  String get placeCoffeeFarm => isArabic ? 'مزرعة البن' : 'Coffee Farm';
  String get placeRijalVillage =>
      isArabic ? 'قرية رجال ألمع' : 'Rijal Almaa Village';
  String get catFog => isArabic ? 'ضباب' : 'Fog';
  String get catCoffeeBean => isArabic ? 'بن' : 'Coffee';
  String get catHeritageShort => isArabic ? 'تراث' : 'Heritage';

  // قيد الانتظار
  String get pendingApprovalTitle =>
      isArabic ? 'طلبك قيد المراجعة' : 'Your request is under review';
  String get pendingApprovalMenu =>
      isArabic ? 'قيد الانتظار' : 'Pending approval';
  String get pendingApprovalSubtitle => isArabic
      ? 'يتم الآن مراجعة طلبك من قبل الإدارة.\nسيتم إشعارك فور الموافقة.'
      : 'Your request is being reviewed by the administration.\nYou will be notified upon approval.';
  String get refreshStatus => isArabic ? 'تحديث الحالة' : 'Refresh status';
}
