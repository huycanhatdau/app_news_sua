import 'dart:math';

import 'package:auth_fire/import.dart';
import 'package:auth_fire/utils/storage_local.dart';
import 'package:bot_toast/bot_toast.dart';

import 'app_store.dart';

SizedBox w(double w) => SizedBox(width: w);
SizedBox h(double h) => SizedBox(height: h);

bool isLogin = false;

final FirebaseAuth firebaseInstance = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

FirebaseFirestore fireStoreInit = FirebaseFirestore.instance;

// NavigatorLib appNavigator = NavigatorLib.instance;
var storageLocal = HiveConfig.instance;

// check empty
bool empty([dynamic data, bool acceptZero = false]) {
  if (data != null) {
    if ((data is Map || data is List) && (data.length == 0
        || (data is List && data.length == 1 && empty(data.first, acceptZero)))) {
      return true;
    }
    if ((data is Map || data is Iterable) && data.isEmpty) {
      return true;
    }
    if (data is bool) {
      return !data;
    }
    if ((data is String || data is num) && (data == '0' || data == 0)) {
      if (acceptZero) {
        return false;
      }else{
        return true;
      }
    }
    if (data.toString().trim().isNotEmpty) {
      return false;
    }
  }
  return true;
}

bool isset([dynamic data]) {
  if (data != null) return true;
  return false;
}

void printR(var data) {
  if (data is Map) {
    data.forEach((key, value) {
      debugPrint('(${value.runtimeType})$key: $value');
    });
  }else if (data is List) {
    for (var value in data) {
      debugPrint('(${value.runtimeType}): $value');
    }
  } else {
    debugPrint(data);
  }
}

double parseDouble(dynamic data, [double defaultValue = 0]){
  if(data is num && (data.isNaN || data.isInfinite)){
    return 0.0;
  }
  if(data is int){
    return (data * 1.0);
  }
  if(data is double) return data;
  if(data is String && data != ''){
    try{
      return double.parse(data);
    }catch(e){
      return defaultValue;
    }
  }
  return defaultValue;
}
int parseInt(dynamic data){
  if(data is num && (data.isNaN || data.isInfinite)){
    return 0;
  }
  if(data is int){
    return data;
  }
  if(data is double){
    return data.ceil();
  }
  if(data is String && RegExp(r'^\d+$').hasMatch(data)){
    try{
      return int.parse(data);
    }catch(e){
      return 0;
    }
  }
  return 0;
}

num round(var data, [int places = 1]) {
  if((data is num && data != double.infinity) || (data is String && RegExp(r'^\d+$').hasMatch(data))){
    double mod = parseDouble(pow(10.0, places));
    final double res = ((parseDouble(data) * mod).round().toDouble() / mod);
    if(res == res.ceil()){
      return res.ceil();
    }
    return res;
  }
  return parseDouble(data);
}

Map<T, dynamic> toMap<T>(dynamic other){
  if(other is Map<T, dynamic>){
    if(other.containsKey('_id')) {
      other.remove('_id');
    }
    return other;
  }

  if(other is List || other is Map) {
    final mapOther = (other is Map)?other:(other as List).asMap();
    if (mapOther.containsKey('_id')) {
      mapOther.remove('_id');
    }
    if(T.toString() == 'String'){
      return mapOther.map<T, dynamic>((key, value) => MapEntry<T, dynamic>('${key??''}' as T, value));
    }
    if(T.toString() == 'int'){
      return mapOther.map<T, dynamic>((key, value) => MapEntry<T, dynamic>(parseInt(key) as T, value));
    }
    if(T.toString() == 'double'){
      return mapOther.map<T, dynamic>((key, value) => MapEntry<T, dynamic>(parseDouble(key) as T, value));
    }
  }
  return <T, dynamic>{};
}

List toList(dynamic data){
  if(data is List){
    return data;
  }else if(data is Map){
    return data.entries.map((e){

      if(e.value is Map){
        try{
          if(e.value is Map<String, dynamic> || e.value is Map<dynamic, dynamic>){
            e.value.addAll(<String, dynamic>{
              'listKey': e.key
            });
          }
          return e.value;
        }catch(error){
          return e.value;
        }

      }else{
        return e.value;
      }
    }).toList();
  }else{
    return [];
  }
}

T? checkType<T>(dynamic value){
  if(value is T)return value;
  return null;
}

List makeTreeItems(List? items, int? length){
  if(length == null || length <= 1 || items == null){
    return items??[];
  }
  int l = length;
  if(items.length < length){
    l = items.length;
  }
  List items0 = [];
  for(int index = 0; index < (items.length/length).ceil(); index++){
    int max = (index * l) + l;
    if(max > items.length){
      max = items.length;
    }
    final subItems = items.sublist(index * l, max);
    List.generate(subItems.length, (i){
      if(subItems.elementAt(i) is Map){
        subItems.elementAt(i).addAll({
          'itemIndex': ((index * l) + i).toString()
        });
      }
    });
    items0.add(subItems);
  }
  return items0;
}

void showMessage(
    message, {
      String? type,
      bool slow = true,
      int? timeShow,
    }) {
  try {
    final type0 = (type != null) ? type.toUpperCase() : '';
    Color color;
    switch (type0.toUpperCase()) {
      case 'SUCCESS':
        color = const Color(0xff32D583);
        break;
      case 'FAIL':
        color = const Color(0xffF04438);
        break;
      case 'ERROR':
        color = const Color(0xffF04438);
        break;
      case 'WARNING':
        color = Colors.deepOrange;
        break;
      default:
        color = const Color(0xff53B1FD);
    }
    if (message != null && message.toString() != 'null') {
      late int showTime;
      if (timeShow != null) {
        showTime = timeShow;
      } else {
        if (message.length < 25) {
          showTime = 2;
        } else if (message.length < 50) {
          showTime = 3;
        } else if (message.length < 150) {
          showTime = 4;
        } else {
          showTime = 5;
        }
      }
      BotToast.showNotification(
          backgroundColor: color,
          duration: Duration(seconds: showTime),
          title: (_) {
            return Text(
              message.toString(),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          }
      );
    }
  }catch(_){}
}

int time() {
  final int now =
  (((DateTime.now()).millisecondsSinceEpoch) / 1000).ceil();
  if(Setting().containsKey('differenceTime')){
    return now + (Setting().get('differenceTime') as int);
  }
  return now;
}

// bool isOfficeFile(){
//   return endsWith('.doc') || endsWith('.docx')
//       || endsWith('.xls') || endsWith('.xlsx')
//       || endsWith('.ppt') || endsWith('.pptx');
// }
// bool isPDFFile(){
//   return endsWith('.pdf');
// }