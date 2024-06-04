// import 'dart:developer';
// import 'dart:io';
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:flutter/foundation.dart';
// import 'package:vhv_basic/import.dart' hide Response, FormData;
// import 'package:dio/io.dart';
// export 'package:dio/dio.dart' show Response;
// // ignore: non_constant_identifier_names
// var DioHelper = _DioHelper.instance;
// class _DioHelper extends DioHelperBase{
//   _DioHelper._();
//   static _DioHelper? _instance;
//   static _DioHelper get instance {
//     _instance ??= _DioHelper._();
//     return _instance!;
//   }
//   PersistCookieJar? cookieJar;
//
//   Future<List<Cookie>> getCookie()async{
//     if(isCookieSupport){
//       return await getCookieJar((cookieJar)async{
//         return await cookieJar.loadForRequest(Uri.parse('${AppInfo.domain}/'));
//       });
//     }
//     return <Cookie>[];
//   }
//   Future<void> deleteAllCookie()async{
//     if(cookieJar != null) {
//       await cookieJar!.deleteAll();
//     }
//   }
//   Future<void> deleteAppCookie()async{
//     if(cookieJar != null) {
//       await cookieJar!.delete(Uri.parse('${AppInfo.domain}/'));
//     }
//   }
//
//   Future<dynamic> getCookieJar(Function(PersistCookieJar cookieJar) created)async{
//     if(isCookieSupport){
//       cookieJar ??= PersistCookieJar(
//           ignoreExpires: true,
//           storage: FileStorage(getPathCookieManager())
//       );
//       return await created(cookieJar!);
//     }
//   }
//   String? getPathCookieManager(){
//     if(appDocumentDirectory != null) {
//       return '${appDocumentDirectory!.path}/.cookies/';
//     }
//     return null;
//   }
//
//   @override
//   Future<void> setCookie(String key, String value)async{
//     getCookieJar((_){
//       setCookies([Cookie(key, value)]);
//     });
//   }
//   @override
//   Future<void> setCookies(List<Cookie> cookies)async{
//     if(dio != null && cookieJar != null) {
//       if (cookies.isNotEmpty) {
//         cookies.removeWhere((element) => element.name != 'AUTH_BEARER_default');
//         await cookieJar!.saveFromResponse(Uri.parse(AppInfo.domain), cookies);
//       }
//       if (dio!.interceptors.isNotEmpty) {
//         dio!.interceptors.removeWhere((element) => element is CookieManager);
//       }
//       dio!.interceptors.add(CookieManager(cookieJar!));
//     }
//   }
//   @override
//   Future<void> manageCookie()async{
//     await getCookieJar((cookieJar)async{
//       final List<Cookie> cookies = await getCookies();
//       if(!empty(factories['forceCookies']) && factories['forceCookies'] is Map<String, String>){
//         (factories['forceCookies'] as Map<String, String>).forEach((key, value) {
//           cookies.add(Cookie(key, value));
//         });
//       }
//       await setCookies(cookies);
//     });
//   }
//
//
//   Future<void> getCsrfToken() async{
//     if(!isWeb) {
//       List<Cookie> results = await getCookie();
//       for (var element in results) {
//         if (element.name == 'AUTH_BEARER_default') {
//           List d = element.value.split('.');
//           if(d.length > 1) {
//             String data = jsonDecode(utf8.decode(base64
//                 .decode(base64.normalize(d[1]))))['data'];
//             if (data.isNotEmpty) {
//               data.split(';').forEach((element) {
//                 if (element.split('|')[0] == 'csrfToken') {
//                   csrfToken = element.substring(element.indexOf('"'));
//                   csrfToken = csrfToken.substring(1, csrfToken.length - 1);
//                 }
//               });
//             }
//           }
//         }
//         if (element.name == 'be') {
//           debugPrint('Server: ${element.value}');
//         }
//       }
//     }
//   }
//
//   Future<void> clearCacheAll() async {
//     if(isCacheSupport && manager != null) {
//       try {
//         await manager!.clearAll();
//       }catch(e){
//         log(e.toString());
//       }
//     }
//   }
//   Future<void> clearCache(String url,{Map<String, dynamic>? params})async{
//     if(isCacheSupport && manager != null) {
//       final url0 = '${AppInfo.domain}/api/${url.replaceAll('.', '/')}';
//       var params0 = <String, dynamic>{};
//       params0.addAll(params ?? {});
//       if (params0['site'] == null || params0['site'] == '') {
//         params0['site'] = AppInfo.id;
//       }
//       params0['securityToken'] = csrfToken;
//       await manager!.deleteByPrimaryKeyAndSubKey(url0, requestMethod: 'POST',
//           subKey: (params != null) ? json.encode(params0) : null);
//     }
//   }
//   Future<void> clearCachePrimary(String service)async{
//     if(isCacheSupport && manager != null) {
//       final url = '${AppInfo.domain}/api/${service.replaceAll('.', '/')}';
//       await manager!.deleteByPrimaryKey(url, requestMethod: 'POST');
//     }
//   }
//
//   String convertDataToUrl(Map map, [String? field]) {
//     String url = '';
//     map.forEach((k, value) {
//       String key = '$k';
//       if(field != null){
//         key = '$field[$key]';
//       }
//       if(value is Map){
//         url += convertDataToUrl(value, key);
//       }else if(value is List){
//         url += _convertListToUrl(value, key);
//       }else if(value is String || value is num){
//         url += '&$key=$value';
//       }
//     });
//     return ((field == null && url.startsWith('&'))?'?${url.substring(1)}':url);
//
//   }
//   String _convertListToUrl(List data, String key){
//     String url = '';
//     data.asMap().forEach((index, value){
//       if(value is String || value is num){
//         url += '&$key[$index]=$value';
//       }else if(value is List){
//         url += _convertListToUrl(value, '$key[$index]');
//       }else if(value is Map){
//         url += convertDataToUrl(value, '$key[$index]');
//       }
//     });
//     return url;
//   }
//   @override
//   HttpClient? onHttpClientAdapterCreate() {
//     if(dio != null) {
//       if(factories['onHttpClientAdapterCreate'] is HttpClient? Function(Dio dio)){
//         return factories['onHttpClientAdapterCreate'](dio!);
//       }else {
//         if (dio!.httpClientAdapter is IOHttpClientAdapter) {
//           (dio!.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
//               () {
//             final client = HttpClient()
//               ..idleTimeout = const Duration(seconds: 3);
//             client.badCertificateCallback =
//                 (X509Certificate cert, String host, int port) => true;
//             return client;
//           };
//         }
//       }
//     }
//     return null;
//   }
// }
// // ignore: non_constant_identifier_names
// var BasicAppConnect = _BasicAppConnect.instance;
// class _BasicAppConnect extends AppConnect{
//   _BasicAppConnect._();
//   static _BasicAppConnect? _instance;
//   static _BasicAppConnect get instance {
//     _instance ??= _BasicAppConnect._();
//     return _instance!;
//   }
//   @override
//   Future<Dio> get getDio => DioHelper.getDio();
//
//   Future<void> resetDio()async{
//     await DioHelper.clearData();
//   }
//
//   @override
//   Map<String, dynamic>? getDefaultHeader(Map<String, dynamic>? customHeader) {
//     customHeader ??= <String, dynamic>{};
//     customHeader.addAll(<String, dynamic>{
//       if(!customHeader.containsKey(HttpHeaders.contentTypeHeader))HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
//       if(!kIsWeb)...<String, dynamic>{
//         if(!customHeader.containsKey(HttpHeaders.acceptHeader))HttpHeaders.acceptHeader: 'application/json',
//       },
//       if(kIsWeb)...<String, dynamic>{
//         if(!customHeader.containsKey(HttpHeaders.accessControlAllowOriginHeader))HttpHeaders.accessControlAllowOriginHeader: '*',
//         if(!customHeader.containsKey(HttpHeaders.acceptHeader))HttpHeaders.acceptHeader: '*/*',
//         if(!customHeader.containsKey(HttpHeaders.accessControlExposeHeadersHeader))HttpHeaders.accessControlExposeHeadersHeader: '*',
//         if(!customHeader.containsKey(HttpHeaders.accessControlAllowCredentialsHeader))HttpHeaders.accessControlAllowCredentialsHeader: true,
//         if(!customHeader.containsKey(HttpHeaders.accessControlAllowHeadersHeader))HttpHeaders.accessControlAllowHeadersHeader: '*',
//         if(!customHeader.containsKey(HttpHeaders.accessControlAllowMethodsHeader))HttpHeaders.accessControlAllowMethodsHeader: 'GET, POST, OPTIONS'
//       }
//     });
//     return super.getDefaultHeader(customHeader);
//   }
//
//   @override
//   Future<void> beforeRequest(url, data) {
//     DioHelper.getCsrfToken();
//     return super.beforeRequest(url, data);
//   }
//
//
//   @override
//   Future<void> afterResulted(AppConnectResponse response)async {
//     if(response.params is Map) {
//       log('----------------------- Start ${response.url} (${toRound((response.endTime.millisecondsSinceEpoch - response.startTime.millisecondsSinceEpoch)/1000, 2)}s'
//           ' at ${date(response.startTime, 'HH:mm:ss')}, ${response.startTime.millisecond}ms'
//           ') ----------------------------');
//       log('VHV.api start: ${response.url}${DioHelper.convertDataToUrl(response.params)}');
//       log('VHV.api data: (${response.params})');
//       log('VHV.api end: ${response.response.data}');
//       log('----------------------- End ${response.url} ----------------------------');
//     }
//     // if(response.url.contains('LMS/Examination/Supervisor/Candidate/verify')){
//     //   String content = 'VHV.api start: ${response.url}${DioHelper.convertDataToUrl(response.params)}';
//     //   content += '\n${'VHV.api data: (${response.params})'}';
//     //   content += '\n${'VHV.api end: ${response.response.data}'}';
//     //   final a = await getExternalStorageDirectory();
//     //   File('${a?.path}/log.txt').createSync();
//     //   File('${a?.path}/log.txt').writeAsStringSync(content);
//     // }
//     return super.afterResulted(response);
//   }
//
//   @override
//   Future<void> onCatch(AppConnectError error)async{
//     final url = error.url;
//     final e = error.error;
//     debugPrint('catch: $e');
//     // if(e is SocketException){
//     //   return;
//     // }
//     if(e is DioException){
//       debugPrint('url on catch: $url');
//       if(e.response != null) {
//         debugPrint('realUri: ${e.response!.realUri.toString()}');
//         debugPrint('data: ${e.response!.data}');
//         debugPrint('statusCode: ${e.response!.statusCode}');
//         debugPrint('statusMessage: ${e.response!.statusMessage}');
//         debugPrint('extra: ${e.response!.extra}');
//         debugPrint('headers: ${e.response!.headers}');
//         debugPrint('location: ${e.response!.headers['location']}');
//         debugPrint('requestOptions.data: ${e.requestOptions.data}');
//         debugPrint('requestOptions.data: ${e.requestOptions.queryParameters}');
//       }
//       debugPrint('message: ${e.message}');
//     }
//     if(url.contains('api/Member/User/logout') && e.toString().contains('302')){
//       _logout();
//       return;
//     }else if(e is DioException){
//       if((e.response?.headers['location']).toString().contains('/page/login') ||
//           (e.response?.headers['location']).toString().contains('/?page=login')){
//         _logout();
//         return;
//       }else{
//         FlutterError.reportError(FlutterErrorDetails(
//           exception: json.encode({
//             'error': e.toString(),
//             'message': e.message,
//             'url': error.url,
//             'startTime': error.startTime.toString(),
//             if(e.response != null)'responseStatusCode': e.response!.statusCode,
//             if(e.response != null)'responseStatusMessage': e.response!.statusMessage,
//             if(e.response != null && e.response!.headers['location'] != null)'location': e.response!.headers['location'],
//             'params': (error.params is FormData)?error.params.toString():error.params
//           }),
//           stack: e.stackTrace,
//           library: 'BasicAppConnect',
//           context: ErrorDescription(error.url),
//         ));
//       }
//     }else if(e.toString().contains('Access denied! Privilege error: member -> Require login')
//         || e.toString().contains('Require login')
//         || (e.toString().startsWith('Redirect to:') && e.toString().contains('page=login'))
//         || (e.toString().startsWith('<script>location=') && e.toString().contains('/page/login'))
//     ){
//       _logout();
//       return;
//     }else{
//       FlutterError.reportError(FlutterErrorDetails(
//         exception: json.encode({
//           'error': e.toString(),
//           'url': error.url,
//           'startTime': error.startTime.toString(),
//           'params': (error.params is FormData)?error.params.toString():error.params
//         }),
//         library: 'BasicAppConnect',
//         context: ErrorDescription(error.url),
//       ));
//     }
//     return super.onCatch(error);
//   }
//
//
//   @override
//   Map<String, dynamic> getDefaultQuery(Map? params){
//     Map<String, dynamic> params0 = {};
//     if(params != null) {
//       params0.addAll(Map<String, dynamic>.from(params));
//     }
//     final bool hasSite = !empty(params0['usingAppSiteId']);
//     if ((params0['site'] == null || params0['site'] == '') && !empty(AppInfo.id)) {
//       if(hasSite){
//         params0['site'] = AppInfo.id;
//       }else{
//         if(!empty(params0['rootSiteId'])){
//           params0['site'] = params0['rootSiteId'].toString();
//         }else  if(!empty(factories['rootSiteId'])){
//           params0['site'] = factories['rootSiteId'].toString();
//         }
//       }
//     }
//     params0.remove('usingAppSiteId');
//     if(!empty(factories['deviceInfo'])){
//       params0.addAll(factories['deviceInfo']);
//     }
//     if(!empty(factories['groupId'])){
//       params0['groupId'] = factories['groupId'];
//     }
//     if(!empty(factories['appVersion'])){
//       params0['appVersion'] = factories['appVersion'];
//     }
//     if(!empty(factories['setClientLanguage']) && !params0.containsKey('setClientLanguage')){
//       params0['setClientLanguage'] = factories['setClientLanguage'];
//     }
//     params0['OS'] = getPlatformOS();
//
//     if(params0.containsKey('callbackFunction')){
//       params0.remove('callbackFunction');
//     }
//     params0['securityToken'] = csrfToken;
//     return params0;
//   }
//
//
//   @override
//   Future<dynamic> handlingResponseSuccess(AppConnectResponse response) async{
//     final res = response.response.data;
//     final res0 = (res is String)?res.trim():res;
//     if (res0 != null && res0 != '') {
//       if (res0 is String && RegExp(r'^\w+$').hasMatch(res0)) {
//         return res0;
//       }
//       try {
//         if(response.url == AppInfo.domain){
//           return res;
//         }
//         if(res0 is String) {
//           if(response.response.realUri.toString().contains('${AppInfo.domain}/page/login')){
//             return await _logout();
//           }
//           if((res0.contains('Require login') || res.contains('${AppInfo.domain}/page/login'))
//               || (res0.startsWith('<script>location="') && res.contains('/page/login'))){
//             return await _logout();
//           }else{
//             try{
//               final data = jsonDecode(res0);
//               if (data is Map && data['status'] == 'expired') {
//                 appFound(data);
//               }
//               if (data is Map && data['status'] == 'FAIL' && data['message'] == 'Require login') {
//                 return await _logout();
//               }
//               if(data == null){
//                 return res0;
//               }
//               return data;
//             }catch(e){
//               return res0;
//             }
//           }
//         }
//         if(res0 is Map){
//           if ( res0['status'] == 'expired') {
//             appFound(res0);
//           }
//           if (res0['status'] == 'FAIL' && res0['message'] == 'Require login') {
//             return await _logout();
//           }
//         }
//         return res0;
//       } catch (e) {
//         return e.toString();
//       }
//     }
//   }
//   Future<String?> _logout()async{
//     if(account.isLogin()) {
//       await account.logoutOnDevice();
//       if (factories['forceLogoutMessage'] != null) {
//         factories['forceLogoutMessage']();
//       }
//       return 'Require login';
//     }
//     return null;
//   }
//
//
// }