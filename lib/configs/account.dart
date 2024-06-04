import 'package:auth_fire/libs/account.dart';

import '../app_store.dart';
import '../system.dart';

class AccountLib extends AccountBase {
  AccountLib._();
  static AccountLib? _instance;
  static AccountLib get instance {
    _instance ??= AccountLib._();
    return _instance!;
  }

  @override
  bool isLogin() {
    return data.containsKey('id') && !empty(data['id']);
  }

  @override
  bool isAdmin() {
    return data.containsKey('isAdmin') && !empty(data['isAdmin']);
  }

  @override
  bool isOwner() {
    return data.containsKey('isOwner') && !empty(data['isOwner']);
  }

  @override
  void remove(String key) {
    data.remove(key);
    Setting('Config').put('account', data);
  }

  @override
  Future<void> save() async {
    await Setting('Config').put('account', data);
  }


  bool get logOuting => _logOuting;
  final bool _logOuting = false;

  ///hasNavigator = goToHome();
  // @override
  // Future<dynamic> login(Map response) async {
  //   await clearAllCache();
  //   await loginCallback();
  //   final data = (!empty(response['account']) && response['account'] is Map)
  //       ? response['account']
  //       : response;
  //   await assign(data);
  //   if (onLoginSuccess != null) await onLoginSuccess!(response);
  //   onFeatureLoginCallback();
  //   if (Get.isRegistered<AppLib>()) {
  //     Get.find<AppLib>().getAppInfo();
  //   }
  //   goToHome();
  // }


  ///logout({
  ///     bool noRedirect = false,
  ///     bool forceClearData == false
  ///   }
  // @override
  // Future<dynamic> logout({
  //   bool hasLoading = true
  // }) async {
  //   try {
  //     if (!logOuting) {
  //       if(hasLoading) {
  //         showLoading();
  //       }
  //       _logOuting = true;
  //       final res = await call('Member.User.logout');
  //       if ((res is Map && (res['status'] == 'SUCCESS' || res['status'] == 'expired'))
  //           || (res is String && (
  //               res.contains('Require login')
  //                   || res.contains('Http status error [302]')
  //                   || res.contains('/page/login')
  //           ))
  //           || (res == null && AppInfo.domain != AppInfo.rootAppDomain)
  //       ) {
  //         await clearData(() async {
  //           await _clearDataSuccess();
  //         }, hasLoading: hasLoading);
  //       }
  //     }
  //     Future.delayed(const Duration(seconds: 2), () {
  //       _logOuting = false;
  //     });
  //     disableLoading();
  //   } catch (e) {
  //     debugPrint('catch on account.logout: $e');
  //     disableLoading();
  //     _logOuting = false;
  //   }
  // }

  // Future<void> _clearDataSuccess()async{
  //   await goToHome();
  // }
  // @override
  // Future<void> logoutOnDevice() async {
  //   await clearData(() async {
  //     await DioHelper.clearData();
  //     if(!kIsWeb) {
  //       csrfToken = '';
  //     }
  //     await _clearDataSuccess();
  //   });
  // }

  // @override
  // Future<void> clearData(Function() onSuccess, {bool hasLoading = true}) async {
  //   try {
  //     factories.remove('appStatus');
  //     factories.remove('appFoundRouter');
  //     if(!(isWeb || GetPlatform.isDesktop)) {
  //       CookieManager cookieManager = CookieManager.instance();
  //       await cookieManager.deleteAllCookies();
  //     }
  //     if(hasLoading) {
  //       showLoading();
  //     }
  //     await Setting().delete('hasChangePassword');
  //     await deleteAllCookie();
  //     if (Setting('Config').containsKey('site')) {
  //       await Setting('Config').delete('site');
  //     }
  //     await Setting('Config').delete('account');
  //     await Setting('Config').delete('userId');
  //     data = {};
  //     await clearAllCache();
  //     AppInfo.clearData();
  //     await logoutCallback();
  //     if (onLogoutSuccess != null) await onLogoutSuccess!();
  //     await onSuccess();
  //     disableLoading();
  //   } catch (e) {
  //     debugPrint('catch on clearData: $e');
  //     _logOuting = false;
  //     disableLoading();
  //   }
  // }



  ///  assign(accountData, [putSetting = true, bool hasRefresh = true]) async {
  // @override
  // Future<Map> assign(Map response) async {
  //   await super.assign(response);
  //   if (!empty(response['siteDomain'])) {
  //     AppInfo.siteDomain = response['siteDomain'];
  //   }
  //   await Setting('Config').put('userId', account['id']);
  //   return data;
  // }

  // @override
  // Map addAll(Map newData){
  //   if (!empty(newData['siteDomain'])) {
  //     AppInfo.siteDomain = newData['siteDomain'];
  //   }
  //   if(!empty(newData['id'])){
  //     Setting('Config').put('userId', newData['id']);
  //   }
  //   return super.addAll(newData);
  // }

  @override
  String toString() {
    if (isLogin()) {
      return '-----------------Account Info------------------->'
          '\n$fullName'
          '\ncode: $code'
          '\naccountId: $id'
          '\nuserId: $userId'
          '\nbirthDate: $birthDate'
          '\nphone: $phone'
          '\nemail: $email'
          '\naddress: $address'
          '\n-----------------Account Info------------------->';
    }
    return 'Guest';
  }
}
