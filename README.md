# عسير — التجربة الذكية (Asir Smart Experience)

دليل مفصل للمشروع بلغة بسيطة، مع فهرس، وشرح للمصطلحات، ومقتطفات من الكود، وأسئلة قد تطرحها لجنة التقييم أو مشرف المشروع.

---

## فهرس المحتويات

(روابط ثابتة تعمل على GitHub)

1. [ما هذا المشروع؟](#section-1)
2. [ماذا يقدّم للمستخدم؟](#section-2)
3. [معجم المصطلحات التقنية](#section-3)
4. [شكل المشروع داخل المجلدات](#section-4)
5. [ما الذي تحتاجه على جهازك؟](#section-5)
6. [تشغيل المشروع على الجهاز](#section-6)
7. [مسار التطبيق من البداية للنهاية](#section-7)
8. [قاعدة البيانات: موبايل مقابل الويب](#section-8)
9. [تسجيل الدخول وحفظ الجلسة](#section-9)
10. [الخادم (Flask) وواجهة البرمجة API](#section-10)
11. [محرك التوصيات الذكية](#section-11)
12. [النشر على الإنترنت (Render)](#section-12)
13. [مقتطفات من الكود مع شرح مبسّط](#section-13)
14. [أسئلة متوقعة من اللجنة أو الدكتور](#section-14)
15. [أسئلة شائعة أخرى](#section-15)
16. [Android Studio، JDK، وأدوات سطر الأوامر](#section-16)
17. [Gradle ومشروع أندرويد في Flutter](#section-17)
18. [محاكي أندرويد (AVD) وتشغيل التطبيق عليه](#section-18)
19. [Cursor و VS Code وإضافات مفيدة](#section-19)
20. [دليل أعطال سريع (Gradle، المحاكي، التراخيص)](#section-20)

---

<a id="section-1"></a>

## 1. ما هذا المشروع؟

**عسير — التجربة الذكية** تطبيق **جوال وويب** مبني بإطار عمل **Flutter** (لغة **Dart**). الفكرة: تقديم تجربة سياحية وتفاعلية لمنطقة عسير: أدلة، فعاليات، جواز رقمي للزائر (نقاط وأختام)، حجوزات، تسجيل مزوّدي خدمات، واقتراحات «ذكية» مرتبطة بالطقس والموسم.

يوجد مع التطبيق **خادم صغير** بلغة **Python** باستخدام مكتبة **Flask** يقدّم:

- واجهات **API** (روابط يردّ عليها التطبيق بصيغة JSON).
- عند النشر: **صفحات الويب** الناتجة من `flutter build web` تُخدم من نفس الخادم حتى يعمل الموقع من رابط واحد.

---

<a id="section-2"></a>

## 2. ماذا يقدّم للمستخدم؟

| جزء تقريبي | وصف بسيط |
|------------|-----------|
| شاشة البداية (Splash) | مظهر ترحيبي ثم التحقق من قاعدة البيانات والانتقال للرئيسية أو شاشة الترحيب. |
| الرئيسية | شبكة للوصول السريع: جواز عسير، دليل المواقع، أنشطة، رحلة ذكية، مواسم، الطقس، وغيرها. |
| جواز عسير | يحتاج تسجيل دخول؛ نقاط، أختام، رحلات، حجوزات (حسب التصميم في الكود). |
| الأدلة والأقسام | شاشات لطبيعة، قهوة، تراث، تخييم، سواحل، خرائط، إلخ. |
| الطقس و«وش فيه اليوم» | يتصل بالخادم عند توفره لجلب توصيات. |
| مزوّدو الخدمات | تسجيل نشاط مع صور (حسب المنصة). |
| المشرف | شاشة مراجعة طلبات المزوّدين (للمسؤول). |

---

<a id="section-3"></a>

## 3. معجم المصطلحات التقنية

| المصطلح | شرح بسيط |
|---------|-----------|
| **Flutter** | أداة من Google لبناء تطبيق واحد يعمل على أندرويد، iOS، الويب، وأحياناً سطح المكتب. |
| **Dart** | لغة البرمجة التي يُكتب بها كود Flutter. |
| **Widget** | أي «قطعة واجهة» في Flutter (زر، نص، صفحة). الشاشة مجموعة من الـ Widgets. |
| **StatefulWidget / StatelessWidget** | شاشة تتغيّر بمرور الوقت (مثل نموذج)، أو شاشة ثابتة العرض. |
| **Navigator** | يدير الانتقال بين الشاشات (فتح شاشة جديدة، الرجوع). |
| **Provider** | مكتبة لإدارة «حالة» التطبيق (مثل اللغة العربية/الإنجليزية) وتنبيه الواجهة عند التغيير. |
| **pubspec.yaml** | ملف يعرّف اسم المشروع والحزم (المكتبات) المستخدمة. |
| **API** | عقد بين التطبيق والخادم: التطبيق يرسل طلباً (مثلاً POST)، والخادم يرد ببيانات منظمة (JSON). |
| **JSON** | صيغة نصية لترميز البيانات (قوائم ومفاتيح)، يسهل قراءتها من التطبيق والخادم. |
| **Flask** | إطار خفيف في Python لبناء مواقع وواجهات API بسرعة. |
| **Gunicorn** | خادم إنتاج في Python يشغّل تطبيق Flask على المنفذ الذي يحدده الاستضافة (مثل Render). |
| **Render** | خدمة استضافة على الإنترنت؛ المشروع يضم ملف `render.yaml` لتعريف طريقة البناء والتشغيل. |
| **SQLite** | قاعدة بيانات ملفّية على الجهاز؛ تُستخدم على أندرويد/iOS في هذا المشروع. |
| **sqflite** | مكتبة Flutter للتعامل مع SQLite على الموبايل. |
| **SharedPreferences** | تخزين بسيط لمفاتيح وقيم (مثل رقم المستخدم الحالي بعد تسجيل الدخول). |
| **CORS** | آلية في المتصفح تمنع موقعاً من قراءة موقع آخر بدون إذن؛ الخادم يرسل رؤوساً تسمح أو تمنع ذلك. |
| **SHA-256** | دالة تشفير أحادي الاتجاه؛ كلمة المرور لا تُخزن كنص صريح بل كـ «بصمة» رقمية. |
| **dart-define** | تمرير قيم للبرنامج وقت **البناء** (مثل عنوان الـ API)، تُثبَّت داخل التطبيق المُجمَّع. |
| **SPA** | تطبيق صفحة واحدة: المتصفح يحمّل مرة واحدة ثم JavaScript يغيّر المحتوى دون إعادة تحميل كاملة لكل رابط. |
| **JDK (Java Development Kit)** | مجموعة أدوات لتشغيل وبناء مشاريع Java؛ بناء تطبيقات أندرويد يعتمد على إصدار JDK متوافق (غالباً 17 مع إصدارات Flutter الحديثة). |
| **Android SDK** | حزمة أدوات من Google تحتوي منصّة أندرويد، محاكيات، وأدوات بناء؛ Flutter يستدعيها عند `flutter build apk` أو التشغيل على محاكي. |
| **Android Studio** | بيئة تطوير رسمية لأندرويد؛ تثبيتها يوفّر SDK ومدير محاكيات (AVD) وغالباً أمر `sdkmanager`. |
| **Gradle** | أداة **أتمتة بناء** لمشاريع أندرويد (وجافا/Kotlin). مشروع Flutter يضم مجلد `android/` فيه سكربتات Gradle؛ عند أول بناء قد يُحمَّل Gradle تلقائياً عبر **Gradle Wrapper** (`gradlew`). |
| **Gradle Wrapper (`gradlew`)** | ملفات داخل `android/` تشغّل إصدار Gradle المناسب للمشروع دون تثبيت Gradle يدوياً على الجهاز. |
| **AVD (Android Virtual Device)** | «هاتف افتراضي» داخل الكمبيوتر لتجربة التطبيق بدون جهاز حقيقي. |
| **sdkmanager** | أداة سطر أوامر لتحميل **منصّات Android** (مثل `platforms;android-35`) و**أدوات البناء** و**المحاكي**. |

---

<a id="section-4"></a>

## 4. شكل المشروع داخل المجلدات

```
asir_smart_experience/
├── lib/                 # كود Dart الأساسي (الشاشات، المنطق، الثيم)
│   ├── main.dart        # نقطة البداية
│   ├── core/            # إعدادات (ثيم، API، صور، انتقالات)
│   ├── data/            # مساعد قاعدة البيانات (نسختان: موبايل / ويب)
│   ├── l10n/            # النصوص العربية والإنجليزية (يدوية في المشروع)
│   ├── screens/         # الشاشات
│   ├── services/        # auth، api
│   └── widgets/         # مكوّنات قابلة لإعادة الاستخدام
├── assets/              # صور وموارد
├── web/                 # ملفات الويب (index، manifest، أيقونات)
├── android/ ، ios/ ، linux/   # منصات أخرى
├── backend/             # خادم Python
│   ├── app.py           # Flask + مسارات API + خدمة ملفات الويب
│   ├── recommendation_engine.py
│   ├── requirements.txt
│   ├── start.sh         # تشغيل على Render
│   └── web/             # نسخة بناء Flutter (يُملأ عند النشر أو يدوياً)
├── scripts/
│   └── prepare-render-flutter-web.ps1   # بناء ويب محلياً (Windows)
├── pubspec.yaml
└── render.yaml          # تعريف خدمة واحدة على Render
```

---

<a id="section-5"></a>

## 5. ما الذي تحتاجه على جهازك؟

1. **Flutter SDK** مثبتاً ومضافاً لمتغير المسار `PATH`.
2. **Dart** يأتي مع Flutter.
3. لتجربة الخادم محلياً: **Python 3** + `pip install -r backend/requirements.txt`.
4. لتشغيل **أندرويد على محاكي أو جهاز**: **Android Studio** (أو على الأقل **Android SDK** + **JDK**) كما في [القسم 16](#section-16) و [18](#section-18).

تحقق من التثبيت:

```bash
flutter doctor
python --version
```

ناتج `flutter doctor` يبيّن ما إذا كان **Android toolchain** مكتملاً (SDK، ترخيص، متصل بجهاز أو محاكي). اقرأ الأقسام 16–20 إذا ظهرت تحذيرات باللون الأصفر أو الأحمر.

---

<a id="section-6"></a>

## 6. تشغيل المشروع على الجهاز

### تشغيل التطبيق (موبايل أو Chrome)

من جذر المشروع:

```bash
flutter pub get
flutter run
```

للويب على المتصفح:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:5000
```

### تشغيل الخادم (Flask) مع الويب

في نافذة طرفية:

```bash
cd backend
pip install -r requirements.txt
python -m gunicorn --bind 0.0.0.0:5000 app:app
```

ثم ابني الويب بعنوان API يشير لنفس الجهاز:

```bash
cd ..   # إلى جذر المشروع
flutter build web --release --dart-define=API_BASE_URL=http://127.0.0.1:5000
```

ثم انسخ محتوى `build/web` إلى `backend/web` إذا أردت فتح الموقع عبر Flask على المنفذ 5000 (كما في وثائق النشر داخل المشروع).

### سكربت PowerShell (جاهز في المشروع)

```powershell
cd D:\VSCode\Projects\flutterprojects\asir_smart_experience
.\scripts\prepare-render-flutter-web.ps1 -ApiBaseUrl "http://127.0.0.1:5000"
```

ينفّذ `flutter pub get` ثم `flutter build web`؛ إذا فشل البناء يتوقف السكربت ويبلغك.

### تشغيل على محاكي أندرويد (ملخص سريع)

بعد إنشاء **AVD** وتشغيله من Android Studio (أو من سطر الأوامر)، من جذر المشروع:

```bash
flutter devices
flutter run
```

إذا ظهر أكثر من جهاز في القائمة، حدّد المحاكي صراحةً بمعرّفه من عمود **device id** في `flutter devices`، مثلاً:

```bash
flutter run -d emulator-5554
```

للاتصال بخادم Flask على جهازك من داخل المحاكي، استخدم عنوان المحاكي الافتراضي (القسم 10 يذكر `10.0.2.2` كافتراضي في `ApiConfig` لأندرويد)، أي شغّل Flask على المنفذ `5000` على الكمبيوتر واترك الإعداد الافتراضي للتطبيق أو مرّر `API_BASE_URL` إذا غيّرت المنفذ.

---

<a id="section-7"></a>

## 7. مسار التطبيق من البداية للنهاية

1. **`main()`** في `lib/main.dart`: يهيئ النظام، يضبط شريط الحالة، يشغّل `runApp` مع `MaterialApp`.
2. **`MaterialApp`** يقرأ اللغة من `LocaleProvider` (Provider)، ويحدد اتجاه النص RTL للعربية.
3. **`home`** تبدأ من `SplashScreen` التي تنتظر جاهزية قاعدة البيانات (`DatabaseHelper.instance.database`) ثم تتحقق من تسجيل الدخول وتفتح `HomeScreen` أو `WelcomeEntryScreen` حسب المنطق في الشاشة.
4. من **الرئيسية**، الضغط على بطاقة يستدعي `Navigator.push` مع شاشة مناسبة (مثلاً جواز عسير يتطلب تسجيل دخول فيتحقق الكود قبل الفتح).

مثال مبسّط لفتح شاشة من الرئيسية (فكرة التوجيه):

```44:72:d:\VSCode\Projects\flutterprojects\asir_smart_experience\lib\screens\home_screen.dart
  Widget _pageFor(String route) {
    switch (route) {
      case 'passport':
        return const AsirPassportScreen();
      case 'guide_hub':
        return const GuideHubScreen();
      // ... بقية المسارات
      default:
        return const WeatherScreen();
    }
  }

  void _open(BuildContext context, String route) {
    HapticFeedback.lightImpact();
    if (route == 'passport' && !AuthService().isLoggedIn) {
      showPassportLoginRequiredDialog(context);
      return;
    }
    Navigator.push(context, AppTransitions.slideFromLeft(_pageFor(route)));
  }
```

**الفكرة:** الدالة `_pageFor` تختار **أي Widget** يمثّل الشاشة، و`_open` تتحقق من الشروط (مثل تسجيل الدخول لجواز عسير) ثم تدفع الشاشة فوق المكدس.

---

<a id="section-8"></a>

## 8. قاعدة البيانات: موبايل مقابل الويب

المشروع يستخدم **ملفين** يختار بينهما Dart تلقائياً:

- **`database_helper_io.dart`**: على أندرويد/iOS/سطح مكتب مع دعم الملفات يستخدم **SQLite** عبر `sqflite` ويخزّن الملف في مجلد المستندات.
- **`database_helper_web.dart`**: على **المتصفح** لا يعمل SQLite بنفس الطريقة؛ التنفيذ الحالي يحفظ البيانات **في الذاكرة** (قائمة في البرنامج)، لذلك **تحديث الصفحة** قد يمسح بيانات الجلسة على الويب.

الربط يتم من ملف واحد:

```1:1:d:\VSCode\Projects\flutterprojects\asir_smart_experience\lib\data\database_helper.dart
export 'database_helper_io.dart' if (dart.library.html) 'database_helper_web.dart';
```

**سؤال متوقع:** «هل قاعدة البيانات موحّدة بين الويب والجوال؟»  
**جواب:** منطق التطبيق متشابه، لكن **التخزين الفعلي** على الويب في هذا الإصدار **ذاكرة** وليس ملف SQLite مثل الجوال.

---

<a id="section-9"></a>

## 9. تسجيل الدخول وحفظ الجلسة

`AuthService` **Singleton** (نسخة واحدة للتطبيق):

- عند **تسجيل الدخول** يقرأ المستخدم من `DatabaseHelper`، يقارن **SHA-256** لكلمة المرور مع المخزّن، ثم يحفظ `userId` والاسم والبريد في **SharedPreferences**.
- عند **التهيئة** `init()` يقرأ القيم من التخزين لاستعادة الجلسة.

```53:60:d:\VSCode\Projects\flutterprojects\asir_smart_experience\lib\services\auth_service.dart
  Future<bool> login(String email, String password) async {
    final user = await DatabaseHelper.instance.getUserByEmail(email);
    if (user == null) return false;
    final hash = _hashPassword(password);
    if (user['password_hash'] != hash) return false;

    _currentUserId = user['id'] as int;
    _currentUserName = user['name'] as String? ?? email;
```

---

<a id="section-10"></a>

## 10. الخادم (Flask) وواجهة البرمجة API

### عنوان الـ API في التطبيق

يُقرأ من **وقت البناء** عبر `String.fromEnvironment`، مع قيمة افتراضية لمحاكي أندرويد:

```7:14:d:\VSCode\Projects\flutterprojects\asir_smart_experience\lib\core\api_config.dart
class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000',
  );

  static const Duration timeout = Duration(seconds: 10);
}
```

- **`10.0.2.2`**: عنوان خاص يعني «جهاز الكمبيوتر المضيف» من داخل **محاكي أندرويد**.
- على **الويب الحقيقي** يجب تمرير `--dart-define=API_BASE_URL=...` عند `flutter build web` (كما يفعل `render.yaml` تلقائياً باستخدام `RENDER_EXTERNAL_URL`).

### أهم مسارات الخادم (من `app.py`)

| المسار | الوظيفة |
|--------|---------|
| `GET /api/health` | للتحقق أن الخادم يعمل (يستخدمه Render في الفحص). |
| `POST /api/recommend/today` | توصيات «وش فيه اليوم» حسب الطقس والتفضيلات. |
| `POST /api/recommend/weather` | توصيات مرتبطة بالطقس. |
| `POST /api/recommend/booking` | اقتراحات سكن ومواصلات نموذجية للحجز. |
| `GET /api/remote-image` | بروكسي صور من نطاقات مسموحة فقط (أمان). |
| `GET /` و `/<path>` | تقديم ملفات Flutter من `backend/web` أو `index.html` لمسارات التطبيق الداخلية. |

مثال استجابة صحّة:

```71:74:d:\VSCode\Projects\flutterprojects\asir_smart_experience\backend\app.py
@app.route('/api/health', methods=['GET'])
def health():
    """فحص حالة الخادم"""
    return jsonify({'status': 'ok', 'message': 'عسير الذكية جاهز'})
```

---

<a id="section-11"></a>

## 11. محرك التوصيات الذكية

الملف `backend/recommendation_engine.py` يعرّف الصنف **`SmartRecommendationEngine`**:

- قواميس مثل **`WEATHER_SUGGESTIONS`** تربط وصف الطقس بكلمات اقتراح (قهوة، تراث، …).
- **`EXPERIENCE_TAGS`** يعطي «وسوماً» لكل فعالية.
- الدالة **`_score_experience`** تحسب درجة مطابقة بين 0 و 100 من الطقس والموسم والتفضيلات.
- **`recommend_today`** تبني قائمة فعاليات وترتّبها حسب الدرجة.

هذا **نظام قواعد ودرجات** داخل الخادم وليس نموذج تعلّم عميق خارجي؛ يمكن شرح ذلك للجنة: «ذكاء اصطناعي مبسّط قائم على قواعد ودرجات».

---

<a id="section-12"></a>

## 12. النشر على الإنترنت (Render)

الملف **`render.yaml`** يعرّف **خدمة ويب واحدة** بلغة Python:

1. تثبيت Flutter وتشغيل `flutter build web` مع `API_BASE_URL` يساوي **`RENDER_EXTERNAL_URL`** (رابط الخدمة على Render).
2. نسخ `build/web` إلى `backend/web`.
3. تثبيت حزم Python وتشغيل `bash backend/start.sh` (الذي يشغّل Gunicorn على `PORT`).

```4:29:d:\VSCode\Projects\flutterprojects\asir_smart_experience\render.yaml
services:
  - type: web
    name: asir-smart-experience
    runtime: python
    region: frankfurt
    plan: free
    buildCommand: |
      set -e
      export FLUTTER_ROOT="${FLUTTER_ROOT:-$HOME/flutter-sdk}"
      ...
      API_URL="${RENDER_EXTERNAL_URL:-http://127.0.0.1:5000}"
      flutter build web --release --base-href / --pwa-strategy=none --dart-define=API_BASE_URL="${API_URL}"
      rm -rf backend/web
      mkdir -p backend/web
      cp -R build/web/. backend/web/
      python -m pip install --upgrade pip
      python -m pip install -r backend/requirements.txt
    startCommand: bash backend/start.sh
    healthCheckPath: /api/health
```

**ملاحظة للمبتدئ:** Render يضع المتغير **`PORT`**؛ التطبيق يجب أن يستمع على هذا المنفذ، و`start.sh` يمرّره لـ Gunicorn.

---

<a id="section-13"></a>

## 13. مقتطفات من الكود مع شرح مبسّط

### أ) نقطة دخول التطبيق

```9:18:d:\VSCode\Projects\flutterprojects\asir_smart_experience\lib\main.dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: AppColors.darkBlue,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AsirSmartExperienceApp());
}
```

- **`WidgetsFlutterBinding.ensureInitialized()`**: يجهّز محرك الرسم قبل استخدام إضافات النظام.
- **`SystemChrome.setSystemUIOverlayStyle`**: لون شريط الحالة والتنقل.
- **`runApp`**: يضع جذر واجهة Flutter.

### ب) طلب HTTP من التطبيق (فكرة)

خدمة `ApiService` تستخدم `http.get` / `http.post` على `ApiConfig.baseUrl + path` مع مهلة زمنية `timeout`. إذا فشل الاتصال، يمكن للشاشات أن تعرض حالة «الخادم غير متاح» حسب التصميم.

---

<a id="section-14"></a>

## 14. أسئلة متوقعة من اللجنة أو الدكتور

**س: ما الهدف من المشروع؟**  
**ج:** دعم التجربة السياحية في عسير عبر تطبيق يجمع أدلة، جوازاً تفاعلياً، حجوزات، وتوصيات مرتبطة بالطقس، مع بوابة لمزوّدي الخدمات.

**س: لماذا Flutter وليس تطبيق أصلي لكل منصة؟**  
**ج:** كود واحد يخدم أكثر من منصة (موبايل وويب) مع تقليل التكرار.

**س: أين يُخزَّن المستخدم وكلمة المرور؟**  
**ج:** على الموبايل في **SQLite**؛ كلمة المرور **مشفّرة** بـ SHA-256 وليست نصاً صافياً. على الويب التخزين الحالي في الذاكرة للنسخة المبسّطة.

**س: ما علاقة Python بالمشروع؟**  
**ج:** خادم Flask يقدّم API للتوصيات وبروكسي الصور، ويقدّم ملفات الويب عند الاستضافة على رابط واحد.

**س: ما معنى «ذكاء اصطناعي» هنا؟**  
**ج:** محرك قواعد ودرجات يختار ويرتّب الفعاليات حسب الطقس والموسم والتفضيلات؛ يمكن توسيعه لاحقاً بنماذج أخرى.

**س: ما أهم تحدٍ في الأمان؟**  
**ج:** التحقق من المدخلات، عدم تخزين كلمات مرور صريحة، وتقييد بروكسي الصور بنطاقات معروفة في `_ALLOWED_IMAGE_HOSTS`.

**س: كيف تختبرون أن الخادم يعمل؟**  
**ج:** استدعاء `GET /api/health` أو فتح الواجهة بعد `flutter build web` ونسخ الملفات إلى `backend/web`.

**س: ماذا عن CORS؟**  
**ج:** عند جعل الواجهة والـ API على **نفس النطاق** (كما في إعداد Render الحالي) تقل المشاكل؛ وُجد أيضاً `CORS(app, origins=['*'])` للتطوير والمرونة.

---

<a id="section-15"></a>

## 15. أسئلة شائعة أخرى

**س: البناء على الويب يفشل بخطأ في حزمة؟**  
**ج:** نفّذ `flutter pub get` ثم `flutter clean` ثم أعد البناء.

**س: الصور لا تظهر على الويب؟**  
**ج:** تحقق من أن عنوان الـ API صحيح وأن مسار `/api/remote-image` مسموح للنطاق المطلوب.

**س: أين أغيّر الألوان والخط؟**  
**ج:** غالباً في `lib/core/app_theme.dart` (ألوان `AppColors` وثيم `AppTheme`).

**س: أين النصوص العربية والإنجليزية؟**  
**ج:** في `lib/l10n/app_localizations.dart` والامتداد `app_localizations_ext.dart`.

---

<a id="section-16"></a>

## 16. Android Studio، JDK، وأدوات سطر الأوامر

### لماذا Android Studio مفيد حتى لو تبرمج من Cursor؟

- يثبّت **Android SDK** في مسار واضح (غالباً تحت مجلد المستخدم).
- يوفّر **مدير المحاكيات (Device Manager)** لإنشاء وتشغيل **AVD**.
- يسهّل قبول **تراخيص SDK** من واجهة رسومية.

### تثبيت مختصر (ويندوز)

1. حمّل **Android Studio** من الموقع الرسمي لـ Google.
2. أثناء المعالج اختر تثبيت **Android SDK** و **Android Virtual Device** إن وُجدت الخيارات.
3. بعد الفتح: **More Actions → SDK Manager**:
   - تبويب **SDK Platforms**: فعّل إصدار Android يطابق **`compileSdk`** في مشروعك (غالباً يكفي أحدث منصّة مستقرة، مثل 34 أو 35 حسب إصدار Flutter).
   - تبويب **SDK Tools**: تأكد من **Android SDK Build-Tools** و **Android SDK Command-line Tools** و **Android Emulator**.

### JDK

Flutter الحديث يتوقع غالباً **JDK 17**. يمكن أن يثبّت Android Studio **JBR** (نسخة JetBrains من JDK) ويستخدمها Gradle. إذا طلب منك `flutter doctor` تثبيت JDK، اتبع الرابط الذي يظهر في الرسالة أو ثبّت JDK 17 من موزّع موثوق وحدّد متغير البيئة **`JAVA_HOME`** ليشير لمجلد JDK.

### أدوات سطر الأوامر (`sdkmanager`)

مسار الأدوات يختلف حسب الجهاز؛ مثال شكل المسار على ويندوز:

`%LOCALAPPDATA%\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat`

أمثلة أوامر مفيدة (من **PowerShell** أو **cmd** بعد تعديل المسار لمسارك الفعلي):

```bat
sdkmanager --list
sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
```

ثم قبول التراخيص (انظر [القسم 20](#section-20)):

```bash
flutter doctor --android-licenses
```

---

<a id="section-17"></a>

## 17. Gradle ومشروع أندرويد في Flutter

### ما هو Gradle هنا؟

**Gradle** ليس «لغة التطبيق»؛ هو **نظام بناء** يقرأ ملفات مثل `android/settings.gradle.kts` و `android/app/build.gradle.kts` ويحمّل الإضافات (مثل Gradle Plugin الخاص بـ Flutter) ثم يبني **APK** أو **App Bundle** عند الطلب.

### هل أحتاج تنزيل Gradle يدوياً؟

عادة **لا**. مجلد `android/` في مشروع Flutter يحتوي على **Gradle Wrapper**:

- على ويندوز: `android\gradlew.bat`
- على لينكس/ماك: `android/gradlew`

عند أول `flutter run` أو `flutter build apk`، قد يُحمَّل **توزيع Gradle** (ملف zip) إلى مجلد كاش على جهازك؛ يحتاج اتصال إنترنت أول مرة.

### تشغيل Gradle يدوياً للتشخيص (اختياري)

من جذر المشروع:

```bash
cd android
.\gradlew.bat tasks
```

(على لينكس/ماك: `chmod +x gradlew` ثم `./gradlew tasks`.)

إذا فشل الأمر، اقرأ آخر أسطر الخطأ: غالباً **SDK غير مكتمل**، أو **JAVA_HOME**، أو **منصّة Android غير منزّلة**.

### أين «تنزيل Gradle» عملياً؟

- **الطريقة الموصى بها:** ترك Flutter/Android Studio يديران الأمر عبر الـ Wrapper.
- **تنزيل يدوي:** يمكن من موقع Gradle الرسمي، لكنه غير ضروري للمبتدئ طالما `flutter doctor` سليم والـ Wrapper يعمل.

---

<a id="section-18"></a>

## 18. محاكي أندرويد (AVD) وتشغيل التطبيق عليه

### إنشاء محاكي (AVD) من Android Studio

1. افتح **Android Studio** → **More Actions → Virtual Device Manager** (أو من القائمة **Tools**).
2. **Create Device** → اختر جهازاً (مثل Pixel 6).
3. اختر **صورة نظام (System Image)**: يُفضّل إصدار يطابق أو يزيد عن `minSdk` في المشروع؛ حمّل الصورة إذا طُلب منك.
4. أنهِ المعالج ثم اضغط **Play** لتشغيل المحاكي.

### تشغيل المحاكي من الطرفية (اختياري)

إذا كان `emulator` في المسار (ضمن `Android\Sdk\emulator`):

```bash
emulator -avd اسم_المحاكي
```

### تشغيل مشروع عسير على المحاكي

1. شغّل المحاكي وانتظر حتى يكتمل الإقلاع.
2. من جذر المشروع:

```bash
flutter pub get
flutter devices
flutter run
```

إذا لم يختر Flutter المحاكي تلقائياً:

```bash
flutter run -d emulator-5554
```

(استبدل المعرف بما يظهر عندك في `flutter devices`.)

### أداء المحاكي على ويندوز

فعّل **تسريع الأجهزة (HAXM / Windows Hypervisor Platform / WHPX)** إن كان `flutter doctor` يشير لذلك؛ المحاكي يصبح أسرع وأقل تقطيعاً.

---

<a id="section-19"></a>

## 19. Cursor و VS Code وإضافات مفيدة

### الإضافات المقترحة

| الإضافة | الفائدة |
|---------|---------|
| **Flutter** (Dart-Code) | تشغيل، تصحيح، Hot Reload، تكامل مع `flutter doctor`. |
| **Dart** | يأتي عادة مع حزمة Flutter. |

### فتح المشروع

- **File → Open Folder** واختر مجلد `asir_smart_experience` (الذي يحتوي `pubspec.yaml`).

### تشغيل وتصحيح

- من شريط الحالة: اختر **جهازاً** (Chrome أو المحاكي أو جهاز USB).
- **Run → Start Debugging** أو اختصار **F5** بعد إنشاء `launch.json` (يمكن لـ Flutter توليد إعدادات عند أول تشغيل).

### طرفية داخل المحرر

- نفّذ `flutter pub get` و `flutter run` من الطرفية المتكاملة؛ نفس الأوامر في القسم 6 و 18.

---

<a id="section-20"></a>

## 20. دليل أعطال سريع (Gradle، المحاكي، التراخيص)

| العرض أو الرسالة | ماذا تفعل؟ |
|-------------------|-----------|
| `Android licenses not accepted` | نفّذ: `flutter doctor --android-licenses` واقبل بالكتابة `y`. |
| `Unable to locate Android SDK` | ثبّت Android Studio أو عرّف **`ANDROID_HOME`** (أو `ANDROID_SDK_ROOT`) ليشير لمجلد الـ SDK (مثل `%LOCALAPPDATA%\Android\Sdk`). |
| `Gradle task assembleDebug failed` | شغّل `flutter doctor -v`؛ راجع JDK وSDK؛ جرّب `flutter clean` ثم `flutter pub get` ثم أعد التشغيل. |
| المحاكي لا يظهر في `flutter devices` | تأكد أنه يعمل وليس «مجمّداً»؛ جرّب `adb kill-server` ثم `adb start-server`. |
| بطء شديد في المحاكي | راجع تفعيل التسريع الافتراضي (WHPX) وزِد ذاكرة RAM للـ AVD من إعدادات الجهاز في AVD Manager. |
| تعارض منفذ مع Flask | غيّر منفذ Flask أو مرّر `API_BASE_URL` بمنفذ آخر عند `flutter run`. |

---

## ختام

هذا الملف يشرح **الفكرة العامة، المصطلحات، التشغيل، التدفق، والنشر**. للتفاصيل البرمجية لكل شاشة، راجع الملفات تحت `lib/screens/` وعلق داخل الكود حيث يساعد ذلك فريقك أو المشرف.

أضيفت أقسام لاحقة (16–20) تخص **Android Studio وJDK وsdkmanager**، و**Gradle والـ Wrapper**، و**المحاكي الافتراضي (AVD)**، و**Cursor/VS Code**، و**دليل أعطال سريع**؛ راجعها عند أول إعداد للبيئة أو عند ظهور أخطاء بناء أندرويد.

إذا رغبت لاحقاً بإضافة **رخصة** أو **سياسة خصوصية** أو **إرشادات مساهمة**، يمكن توسيع هذا المستند بنفس أسلوب الفهرس.
