import 'package:asir_smart_experience/data/app_data.dart';

const String _soudah = 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/ryYymbaFReNEiGml.jpg';
const String _rijal = 'https://scth.scene7.com/is/image/scth/rejal-almaa-aseer:crop-1920x1080?defaultImage=rejal-almaa-aseer';
const String _market = 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/iaINwPGODiKWsuZj.jpg';
const String _birk = 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/izIZxZLyspbjyifB.webp';

/// بيانات مترجمة حسب اللغة
class LocalizedAppData {
  final bool isArabic;

  LocalizedAppData(this.isArabic);

  List<Map<String, dynamic>> get todayEvents => isArabic ? AppData.todayEvents : _todayEventsEn;
  List<Map<String, dynamic>> get weekendEvents => isArabic ? AppData.weekendEvents : _weekendEventsEn;
  List<Map<String, dynamic>> get weatherData => isArabic ? AppData.weatherData : _weatherDataEn;
  List<Map<String, dynamic>> get campingSites => isArabic ? AppData.campingSites : _campingSitesEn;
  List<Map<String, dynamic>> get hikingTrails => isArabic ? AppData.hikingTrails : _hikingTrailsEn;
  List<Map<String, dynamic>> get coffeePlaces => isArabic ? AppData.coffeePlaces : _coffeePlacesEn;
  List<Map<String, dynamic>> get heritagePlaces => isArabic ? AppData.heritagePlaces : _heritagePlacesEn;
  List<Map<String, dynamic>> get localShops => isArabic ? AppData.localShops : _localShopsEn;
  List<Map<String, dynamic>> get seasons => isArabic ? AppData.seasons : _seasonsEn;
  List<Map<String, dynamic>> get accommodationTypes => isArabic ? AppData.accommodationTypes : _accommodationTypesEn;
  List<Map<String, dynamic>> get transportOptions => isArabic ? AppData.transportOptions : _transportOptionsEn;
  List<Map<String, dynamic>> get restaurants => isArabic ? AppData.restaurants : _restaurantsEn;
  List<Map<String, dynamic>> get coastalPlaces => isArabic ? AppData.coastalPlaces : _coastalPlacesEn;

  static final List<Map<String, dynamic>> _todayEventsEn = [
    {'id': '1', 'title': 'Fog Festival', 'time': '9am - 6pm', 'location': 'Abha', 'image': 'https://tse4.mm.bing.net/th/id/OIP.U5b1M34S1qDwNP1-omJPuwHaE8?rs=1&pid=ImgDetMain&o=7&rm=3'},
    {'id': '2', 'title': 'Heritage Show', 'time': '4pm - 8pm', 'location': 'Rijal Almaa', 'image': 'https://www.al-madina.com/uploads/images/2022/12/16/2133869.jpg'},
    {'id': '3', 'title': 'Handicrafts Workshop', 'time': '10am - 2pm', 'location': 'Al Soudah', 'image': 'https://www.alwatan.com.sa/uploads/images/2024/09/18/1086072.jpg'},
  ];

  static final List<Map<String, dynamic>> _weekendEventsEn = [
    {'id': '1', 'title': 'Friday Market', 'day': 'Friday', 'location': 'Abha', 'image': 'https://livelovesaudi.net/wp-content/uploads/2024/08/abha_mall4_06d39c684e-1.webp'},
    {'id': '2', 'title': 'Family Theater', 'day': 'Saturday', 'location': 'Khamis Mushait', 'image': 'https://livelovesaudi.net/wp-content/uploads/2024/08/abha_mall4_06d39c684e-1.webp'},
  ];

  static final List<Map<String, dynamic>> _weatherDataEn = [
    {'day': 'Today', 'temp': '22°', 'condition': 'Sunny', 'iconId': 'sunny'},
    {'day': 'Tomorrow', 'temp': '18°', 'condition': 'Foggy', 'iconId': 'fog'},
    {'day': 'Day after', 'temp': '20°', 'condition': 'Cloudy', 'iconId': 'cloud'},
  ];

  static final List<Map<String, dynamic>> _campingSitesEn = [
    {'id': '1', 'name': 'Al Soudah Camp', 'rating': '4.5', 'features': 'Water, electricity', 'image': _soudah},
    {'id': '2', 'name': 'Raghadan Camp', 'rating': '4.2', 'features': 'Nature', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/ZUydboTpXXeOHPyi.jpg'},
    {'id': '3', 'name': 'Dhalma Camp', 'rating': '4.8', 'features': 'Views', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/vnGGqlcAzvcBPfoF.jpg'},
  ];

  static final List<Map<String, dynamic>> _hikingTrailsEn = [
    {'id': '1', 'name': 'Hadhi Waterfalls Trail', 'distance': '3 km', 'difficulty': 'Easy', 'image': 'https://auhm.org/wp-content/uploads/2025/06/download-2-e1751016259647.webp'},
    {'id': '2', 'name': 'Rijal Almaa Forest Trail', 'distance': '5 km', 'difficulty': 'Medium', 'image': _rijal},
    {'id': '3', 'name': 'Al Soudah Peak Trail', 'distance': '7 km', 'difficulty': 'Hard', 'image': _soudah},
  ];

  static final List<Map<String, dynamic>> _coffeePlacesEn = [
    {'id': '1', 'name': 'Al Dosari Farm', 'discount': '15%', 'type': 'Farm', 'image': 'https://portalcdn.spa.gov.sa/backend/original/202508/QLr7RpDdkGFigdrbWrX25Tmh6BgsvzXxdG4CFN9P.jpg'},
    {'id': '2', 'name': 'Rijal Almaa Coffee', 'discount': '10%', 'type': 'Cafe', 'image': 'https://tse4.mm.bing.net/th/id/OIP.FfCjS-f97Hn4ZJE9YYYjbgHaNK?rs=1&pid=ImgDetMain&o=7&rm=3'},
    {'id': '3', 'name': 'Al Soudah Coffee', 'discount': '20%', 'type': 'Shop', 'image': 'https://www.alwatan.com.sa/uploads/images/2023/02/28/904819.jpeg'},
  ];

  static final List<Map<String, dynamic>> _heritagePlacesEn = [
    {'id': '1', 'name': 'Rijal Almaa Village', 'type': 'Heritage village', 'image': _rijal},
    {'id': '2', 'name': 'Abha Museum', 'type': 'Museums', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/VHkmHGIxpbiYqyeT.jpg'},
    {'id': '3', 'name': 'Handicrafts Stories', 'type': 'Stories', 'image': 'https://www.alwatan.com.sa/uploads/images/2024/09/18/1086072.jpg'},
  ];

  static final List<Map<String, dynamic>> _localShopsEn = [
    {'id': '1', 'name': 'Local producers - Natural honey', 'rating': '4.7', 'image': _market},
    {'id': '2', 'name': 'Seasonal stalls - Handicrafts', 'rating': '4.5', 'image': 'https://www.alwatan.com.sa/uploads/images/2024/09/18/1086072.jpg'},
    {'id': '3', 'name': 'Local Products Store', 'rating': '4.8', 'image': 'https://tse2.mm.bing.net/th/id/OIP.TowWyGuLmtl3OxyNtmMjPQAAAA?rs=1&pid=ImgDetMain&o=7&rm=3'},
  ];

  static final List<Map<String, dynamic>> _seasonsEn = [
    {'id': 'fog', 'name': 'Fog Season', 'iconId': 'fog', 'months': 'Dec - Feb'},
    {'id': 'summer', 'name': 'Summer Season', 'iconId': 'sun', 'months': 'Jun - Aug'},
    {'id': 'winter', 'name': 'Winter Season', 'iconId': 'snow', 'months': 'Dec - Feb'},
    {'id': 'coffee', 'name': 'Coffee Season', 'iconId': 'coffee', 'months': 'Sep - Nov'},
    {'id': 'camping', 'name': 'Camping Season', 'iconId': 'camping', 'months': 'Mar - May'},
    {'id': 'events', 'name': 'Events Season', 'iconId': 'events', 'months': 'Year round'},
  ];

  static final List<Map<String, dynamic>> _accommodationTypesEn = [
    {'id': '1', 'name': 'Hotels', 'count': '25'},
    {'id': '2', 'name': 'Cabins', 'count': '15'},
    {'id': '3', 'name': 'Heritage houses', 'count': '10'},
  ];

  static final List<Map<String, dynamic>> _transportOptionsEn = [
    {'id': '1', 'name': 'Car rental'},
    {'id': '2', 'name': 'Tour guides'},
    {'id': '3', 'name': 'Ready routes'},
  ];

  static final List<Map<String, dynamic>> _restaurantsEn = [
    {'id': '1', 'name': 'Views Restaurant', 'type': 'Fine dining', 'image': 'https://www.bayut.sa/blog/wp-content/uploads/2020/01/Abha-Dam-28-01-2020-1024x640.jpg'},
    {'id': '2', 'name': 'Local Food Truck', 'type': 'Local', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/ytEnjJZDlPnrrEim.jpeg'},
  ];

  static final List<Map<String, dynamic>> _coastalPlacesEn = [
    {'id': '1', 'name': 'Al Qahma Beach', 'image': 'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/MgmeKOzxgkKsSbhI.webp'},
    {'id': '2', 'name': 'Al Birk Beach', 'image': _birk},
  ];
}
