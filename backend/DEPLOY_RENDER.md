# نشر واحد على Render: Flask + Flutter Web

## ماذا يحدث؟

- **خدمة Web واحدة** تشغّل Gunicorn + Flask.
- Flask يخدم **الـ API** تحت `/api/...` وملفات **Flutter Web** من المجلد `backend/web/` (نسخة من `build/web`).

## 1) بناء الويب وربطه بعنوان Render

من جذر مشروع Flutter (`asir_smart_experience/`):

```bash
flutter build web --release --dart-define=API_BASE_URL=https://اسم-الخدمة.onrender.com
```

- استبدل `اسم-الخدمة` بالاسم الذي ستختاره في Render (يظهر في الرابط `https://اسم-الخدمة.onrender.com`).
- **بدون** `/` في نهاية الرابط.
- إذا غيّرت الاسم لاحقاً، أعد البناء بنفس الأمر وانسخ `build/web` مرة أخرى.

## 2) نسخ الملفات إلى الـ backend

انسخ **كل محتويات** `build/web/` إلى `backend/web/` (بحيث يوجد `backend/web/index.html` و`backend/web/main.dart.js` ومجلد `assets` وغيره).

## 3) رفع المستودع إلى GitHub

تأكد أن مجلد `backend/web` مرفوع ويحتوي ملفات البناء (أو استخدم فرع/CI لاحقاً).

## 4) إعداد Render (Web Service)

| الحقل | القيمة |
|--------|--------|
| **Root Directory** | `backend` (مهم جداً — بدونها لن يُثبَّت `requirements.txt` الصحيح ولن يُوجد `app.py`) |
| **Runtime** | Python 3 |
| **Build Command** | `python -m pip install --upgrade pip && python -m pip install -r requirements.txt` (إن تعطّل، اتركه فارغاً أو `echo "ok"` — سكربت التشغيل يثبت الحزم) |
| **Start Command** | `bash start.sh` (الملف `backend/start.sh` في المستودع) |

**بديل سطر واحد** إذا ما تبي سكربت:

`python -m pip install --upgrade pip && python -m pip install -r requirements.txt && python -m gunicorn --bind 0.0.0.0:$PORT app:app`

- Render يضبط **`PORT`**؛ gunicorn يربط على `0.0.0.0` حتى يكتشف Render المنفذ (تجنّب **Port scan timeout**).
- **`No module named gunicorn`**: غالباً خطوة Build لم تُثبت الحزم في الـ venv. الحل أعلاه يعيد التثبيت **عند كل تشغيل** ثم يشغّل gunicorn.
- تأكد رفع **`backend/start.sh`** و**`backend/requirements.txt`** على GitHub.
- بديل جذر المستودع بدون Root Directory: **Build** = `python -m pip install -r backend/requirements.txt` — **Start** = `cd backend && bash start.sh`.

## 5) اختبار محلي (اختياري)

```bash
cd backend
pip install -r requirements.txt
# بعد نسخ web كما فوق
python -m gunicorn --bind 0.0.0.0:5000 app:app
```

ثم افتح `http://127.0.0.1:5000` — يجب أن تظهر الواجهة، و`/api/health` يعمل.

لبناء ويب للاختبار المحلي مع نفس السيرفر:

```bash
flutter build web --release --dart-define=API_BASE_URL=http://localhost:5000
```

## 6) ملاحظات

- **تحديث الواجهة:** كل ما تغيّر في Flutter، أعد `flutter build web` وانسخ إلى `backend/web` ثم `git push`.
- **CORS:** الطلبات من نفس النطاق لا تحتاج إعداداً خاصاً؛ `Flask-CORS` يبقى مفيداً إذا استدعيت الـ API من مكان آخر لاحقاً.
