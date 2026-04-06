import 'image_url.dart';

/// روابط الصور الأصلية (ثابتة) + getters تمرّر الويب عبر بروكسي الخادم.
class AppImages {
  static const String _hero =
      'https://scth.scene7.com/is/image/scth/rejal-almaa-aseer:crop-1920x1080?defaultImage=rejal-almaa-aseer';
  static const String _passport =
      'https://scth.scene7.com/is/image/scth/rijal-almaa-of-aseer-new:crop-1920x1080?defaultImage=rijal-almaa-of-aseer-new';
  static const String _today =
      'https://scth.scene7.com/is/image/scth/rejal-almaa-aseer:crop-1920x1080?defaultImage=rejal-almaa-aseer';
  static const String _weather =
      'https://scth.scene7.com/is/image/scth/rijal-almaa-of-aseer-new:crop-1920x1080?defaultImage=rijal-almaa-of-aseer-new';
  static const String _maps =
      'https://scth.scene7.com/is/image/scth/rejal-almaa-aseer:crop-1920x1080?defaultImage=rejal-almaa-aseer';
  static const String _camping =
      'https://discoveraseer.com/assets/attraction/rijal-almaa.webp';
  static const String _hiking =
      'https://discoveraseer.com/assets/attraction/sok-mhayl-.webp';
  static const String _coffee =
      'https://asir-coffee.org/wp-content/uploads/2024/07/3031.jpg';
  static const String _heritage =
      'https://makkahnewspaper.com/uploads/images/2022/08/24/1503473.jpg';
  static const String _local =
      'https://discoveraseer.com/assets/attraction/rijal-almaa.webp';
  static const String _seasons =
      'https://scth.scene7.com/is/image/scth/rijal-almaa-of-aseer-new:crop-1920x1080?defaultImage=rijal-almaa-of-aseer-new';
  static const String _services =
      'https://discoveraseer.com/assets/attraction/rijal-almaa.webp';
  static const String _food =
      'https://www.fatakat-a.com/wp-content/uploads/abha-flavours-1.jpg';
  static const String _shopping =
      'https://discoveraseer.com/assets/attraction/sok-mhayl-.webp';
  static const String _coastal =
      'https://scth.scene7.com/is/image/scth/rejal-almaa-aseer:crop-1920x1080?defaultImage=rejal-almaa-aseer';

  static String get hero => proxiedImageUrl(_hero);
  static String get passport => proxiedImageUrl(_passport);
  static String get today => proxiedImageUrl(_today);
  static String get weather => proxiedImageUrl(_weather);
  static String get maps => proxiedImageUrl(_maps);
  static String get camping => proxiedImageUrl(_camping);
  static String get hiking => proxiedImageUrl(_hiking);
  static String get coffee => proxiedImageUrl(_coffee);
  static String get heritage => proxiedImageUrl(_heritage);
  static String get local => proxiedImageUrl(_local);
  static String get seasons => proxiedImageUrl(_seasons);
  static String get services => proxiedImageUrl(_services);
  static String get food => proxiedImageUrl(_food);
  static String get shopping => proxiedImageUrl(_shopping);
  static String get coastal => proxiedImageUrl(_coastal);
}
