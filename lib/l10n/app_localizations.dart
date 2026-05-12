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
  String get passportSub =>
      isArabic ? 'أختام، نقاط، مكافآت، تجارب' : 'Stamps, points, rewards & experiences';
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
  String get fieldRequired =>
      isArabic ? 'هذا الحقل مطلوب' : 'This field is required';
  String get phoneOptional =>
      isArabic ? 'رقم الجوال (اختياري)' : 'Phone (optional)';
  String get phoneRequired => isArabic ? 'رقم الجوال' : 'Phone number';
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
  String get continueAsGuestButton =>
      isArabic ? 'تصفح كزائر' : 'Continue as guest';
  String get guestModeNote => isArabic
      ? 'كزائر يمكنك التصفح فقط — لا جواز ولا أختام ولا حفظ.'
      : 'As a guest you can only browse — no passport, stamps or saving.';

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
  String get visitRegistered =>
      isArabic ? 'تم تسجيل الزيارة' : 'Visit registered';
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
  String get photoAddFailed =>
      isArabic ? 'فشل رفع الصورة' : 'Failed to add photo';

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
  String get bookingSuccess =>
      isArabic ? 'تم الحجز بنجاح!' : 'Booking successful!';
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

  // دخول وزائر (وثيقة المنصة)
  String get authUnifiedSubtitle => isArabic
      ? 'سجّل الدخول أو أنشئ حساباً للوصول الكامل لتجربة عسير الذكية'
      : 'Sign in or create an account for the full Aseer Smart Experience';

  String get authEntrySubtitle => isArabic
      ? 'اختر طريقة الدخول المناسبة لك'
      : 'Choose how you want to enter';
  String get welcomeEntryChoicesHint => isArabic
      ? 'الدخول كزائر: تصفح وطقس ودليل وأنشطة ومواسم ورحلة ذكية — دون جواز أو حفظ أو تعليقات.'
      : 'Guest: browse, weather, guide, activities, seasons & smart trip — no passport, saves or comments.';
  String get continueAsGuest => isArabic ? 'الدخول كزائر' : 'Continue as guest';
  String get guestPermissionsHint => isArabic
      ? 'تصفح، طقس، دليل، أنشطة، مواسم، رحلة ذكية — دون جواز أو حفظ'
      : 'Browse, weather, guide, activities, seasons, smart trip — no passport or saves';
  String get loginForFullFeatures => isArabic
      ? 'تفعيل جواز عسير والحفظ والتعليقات'
      : 'Unlock passport, saves & comments';
  String get registerBenefitsShort => isArabic
      ? 'حساب كامل: جواز، أختام، نقاط، مكافآت'
      : 'Full account: passport, stamps, points, rewards';
  String get passportLoginTitle =>
      isArabic ? 'تسجيل مطلوب' : 'Sign in required';
  String get passportLoginMessage => isArabic
      ? 'للاستفادة من جواز عسير وجمع الأختام والمكافآت، يرجى تسجيل الدخول أو إنشاء حساب.'
      : 'To use Aseer Passport, collect stamps and rewards, please sign in or create an account.';
  String get guestActionBlocked => isArabic
      ? 'هذه الميزة متاحة للمستخدمين المسجلين فقط.'
      : 'This feature is only available for signed-in users.';
  String get cityOptional => isArabic ? 'المدينة (اختياري)' : 'City (optional)';

  // الصفحة الرئيسية — المقترح
  String get heroWelcome =>
      isArabic ? 'مرحبًا بك في عسير ✨' : 'Welcome to Aseer ✨';
  String get heroSubtitle => isArabic
      ? 'اكتشف التجربة الذكية حسب جوّك اليوم'
      : 'Discover the smart experience for today’s mood';
  String get currentWeather => isArabic ? 'الطقس الآن' : 'Current weather';
  String get mainSectionsTitle => isArabic ? 'القائمة الرئيسية' : 'Main menu';
  String get verifiedPlacesTitle =>
      isArabic ? 'محتوى موثّق (مصادر رسمية)' : 'Verified content (official sources)';
  String get guideInAsir => isArabic ? 'دليلك في عسير' : 'Your guide in Aseer';
  String get guideInAsirSub => isArabic
      ? 'مطاعم، كافيهات، فعاليات، سكن، تسوق وأكثر'
      : 'Restaurants, cafés, events, stay, shopping & more';
  String get activitiesAdventures =>
      isArabic ? 'الأنشطة والمغامرات' : 'Activities & adventures';
  String get activitiesAdventuresSub =>
      isArabic ? 'حجز، صعوبة، فلاتر' : 'Book, difficulty, filters';
  String get smartTrip => isArabic ? 'رحلتك الذكية' : 'Your smart trip';
  String get smartTripSub =>
      isArabic ? 'خطة حسب الطقس والاهتمامات' : 'Plan by weather & interests';
  String get moodTodaySection =>
      isArabic ? 'وش ودّك تسوي اليوم؟' : 'What do you feel like today?';
  String get moodWalk => isArabic ? 'أتمشّى' : 'A walk';
  String get moodAdventure => isArabic ? 'مغامرة' : 'Adventure';
  String get moodSea => isArabic ? 'بحر' : 'Sea';
  String get moodCoffee => isArabic ? 'قهوة' : 'Coffee';
  String get moodEvents => isArabic ? 'فعاليات' : 'Events';
  String get activityFamily => isArabic ? 'عائلي' : 'Family';
  String get moodRelax => isArabic ? 'استرخاء' : 'Relax';
  String get registerYourActivity =>
      isArabic ? 'سجّل نشاطك معنا' : 'Register your activity';
  String get registerYourActivitySub => isArabic
      ? 'انضم كمقدّم نشاط أو منشأة'
      : 'Join as an activity or venue provider';
  String get filterByType => isArabic ? 'النوع' : 'Type';
  String get filterByDifficulty => isArabic ? 'الصعوبة' : 'Difficulty';
  String get filterByLocation => isArabic ? 'الموقع' : 'Location';
  String get filterByWeather => isArabic ? 'الطقس' : 'Weather';
  String get bookNow => isArabic ? 'احجز الآن' : 'Book now';
  String get difficultyBeginner => isArabic ? 'مبتدئ' : 'Beginner';
  String get difficultyIntermediate => isArabic ? 'متوسط' : 'Intermediate';
  String get difficultyAdvanced => isArabic ? 'محترف' : 'Advanced';
  String get durationLabel => isArabic ? 'المدة' : 'Duration';
  String get priceOptional => isArabic ? 'السعر (اختياري)' : 'Price (optional)';
  String get passportLinkedOnly => isArabic
      ? 'الأنشطة المعتمدة فقط ترتبط بأختام جواز عسير'
      : 'Only approved listings link to passport stamps';

  // مقدّم النشاط
  String get providerFlowTitle =>
      isArabic ? 'تسجيل منشأة / نشاط' : 'Venue / activity signup';
  String get providerBasicSection =>
      isArabic ? 'البيانات الأساسية' : 'Basic details';
  String get establishmentName =>
      isArabic ? 'اسم المنشأة / النشاط' : 'Business or activity name';
  String get activityTypeField => isArabic ? 'نوع النشاط' : 'Activity type';
  String get contactPerson => isArabic ? 'اسم المسؤول' : 'Contact name';
  String get shortDescription => isArabic ? 'وصف مختصر' : 'Short description';
  String get categoryPick => isArabic ? 'التصنيف' : 'Category';
  String get mapOrWebsite =>
      isArabic ? 'الموقع على الخريطة / رابط' : 'Map or website link';
  String get workingHours => isArabic ? 'ساعات العمل' : 'Opening hours';
  String get avgPrice => isArabic ? 'السعر أو المتوسط' : 'Price or average';
  String get bookingOrPhone =>
      isArabic ? 'رابط الحجز أو التواصل' : 'Booking link or phone';
  String get socialAccounts => isArabic ? 'حسابات التواصل' : 'Social media';
  String get nextSubscription =>
      isArabic ? 'متابعة للاشتراك' : 'Continue to subscription';
  String get subscriptionPackages =>
      isArabic ? 'باقات الاشتراك' : 'Subscription packages';
  String get packageBasic => isArabic ? 'الباقة الأساسية' : 'Basic';
  String get packageBasicFeatures => isArabic
      ? '• ظهور في الدليل\n• صفحة تعريفية\n• صورة واحدة أو أكثر'
      : '• Listed in the guide\n• Profile page\n• One or more photos';
  String get packageFeatured => isArabic ? 'الباقة المميزة' : 'Featured';
  String get packageFeaturedFeatures => isArabic
      ? '• ظهور أعلى\n• ربط مع «جوّك اليوم»\n• ربط مع «رحلتك الذكية»\n• إبراز في الاقتراحات'
      : '• Higher placement\n• Linked to “Your weather” & smart trip\n• Highlighted in suggestions';
  String get packagePro => isArabic ? 'الباقة الاحترافية' : 'Professional';
  String get packageProFeatures => isArabic
      ? '• ظهور مميز\n• ترويج في المواسم\n• أولوية في البحث\n• دعم حملات'
      : '• Premium placement\n• Season promotion\n• Search priority\n• Campaign support';
  String get paymentMethod => isArabic ? 'وسيلة الدفع' : 'Payment method';
  String get confirmSubscription =>
      isArabic ? 'تأكيد الاشتراك' : 'Confirm subscription';
  String get paySimulated =>
      isArabic ? 'دفع تجريبي (محلي)' : 'Simulated payment (local)';
  String get providerDashboardTitle =>
      isArabic ? 'لوحة مقدّم النشاط' : 'Provider dashboard';
  String get editListing => isArabic ? 'تعديل البيانات' : 'Edit listing';
  String get publishStatus => isArabic ? 'حالة النشر' : 'Publish status';
  String get statusPendingReview => isArabic ? 'قيد المراجعة' : 'Under review';
  String get statusAccepted => isArabic ? 'مقبول' : 'Accepted';
  String get statusRejected => isArabic ? 'مرفوض' : 'Rejected';
  String get statusNeedsEdit => isArabic ? 'يحتاج تعديل' : 'Needs changes';
  String get renewPackage => isArabic ? 'تجديد الباقة' : 'Renew package';
  String get adminReviewTitle =>
      isArabic ? 'مراجعة الأنشطة (إداري)' : 'Activity review (admin)';
  String get adminReviewHint =>
      isArabic ? 'للمسؤولين المصرّح لهم فقط' : 'Authorized administrators only';
  String get noPendingProviders =>
      isArabic ? 'لا طلبات معلّقة' : 'No pending requests';

  // لوحة مقدّم النشاط — العروض والخصومات
  String get offersAndDiscounts =>
      isArabic ? 'العروض والخصومات' : 'Offers & discounts';
  String get addOffer => isArabic ? 'إضافة عرض / خصم' : 'Add offer / discount';
  String get noOffersYet =>
      isArabic ? 'لا توجد عروض بعد' : 'No offers yet';
  String get offerHint => isArabic
      ? 'مثال: خصم ١٥٪ لحاملي جواز عسير'
      : 'e.g. 15% off for Aseer Passport holders';
  String get subscriptionInfo =>
      isArabic ? 'بيانات الاشتراك' : 'Subscription details';
  String get subscriptionUntil =>
      isArabic ? 'مدة الاشتراك حتى' : 'Subscribed until';
  String get noActiveSubscription =>
      isArabic ? 'لا يوجد اشتراك نشط' : 'No active subscription';
  String get linkedToPassport =>
      isArabic ? 'مربوط بجواز عسير' : 'Linked to Aseer Passport';
  String get notLinkedToPassport => isArabic
      ? 'يُربط بالجواز فور اعتماد النشاط'
      : 'Linked to passport once approved';
  String get providerEmailNotMatched => isArabic
      ? 'لم يتم العثور على نشاط بهذا البريد. سجّل نشاطك أولاً.'
      : 'No activity found for this email. Register your activity first.';
  String get providerAccountRequiredTitle =>
      isArabic ? 'تسجيل الدخول مطلوب' : 'Sign in required';
  String get providerAccountRequiredMessage => isArabic
      ? 'لتسجيل نشاطك أو منشأتك ومتابعة الاشتراك والدفع، يرجى تسجيل الدخول أو إنشاء حساب بنفس البريد الذي ستستخدمه في الطلب.'
      : 'To register your activity or venue and complete subscription, please sign in or create an account using the same email as in your application.';
  String get providerEmailLockedHint => isArabic
      ? 'يُستخدم بريد حسابك المسجّل ولا يمكن تغييره هنا.'
      : 'Your signed-in email is used and cannot be changed here.';
  String get activityPhotosSection =>
      isArabic ? 'صور النشاط (اختياري)' : 'Activity photos (optional)';
  String get activityPhotosHint => isArabic
      ? 'أضف صوراً توضّح المنشأة أو التجربة (يُفضّل من التطبيق على الجهاز).'
      : 'Add photos of your venue or experience (best from the mobile app).';
  String get activityPhotosAdd => isArabic ? 'إضافة صورة' : 'Add photo';
  String get activityPhotosCount => isArabic
      ? 'عدد الصور المرفوعة'
      : 'Uploaded photos';
}
