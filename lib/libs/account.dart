import 'package:flutter/cupertino.dart';

abstract class AccountBase{

  Map get data => _data;

  set data(Map data){
    _data = {...data};
  }

  void setTemporaryData(Map data){
    _data = {...data};
  }

  Map _data = {};
  dynamic operator [](String name) {
    if (_data.containsKey(name)) {
      return _data[name];
    }
    return '';
  }

  String get id => isLogin()?(_data['accountId']??''):'';
  String get fullName => isLogin()?(_data['fullName']??''):'';
  String get userId => isLogin()?(_data['userId']??_data['uid']).toString():'';
  String get phone => isLogin()?(_data['phone']??''):'';
  String get email => isLogin()?(_data['email']??''):'';
  String get address => isLogin()?(_data['address']??''):'';
  String get birthDate => isLogin()?(_data['birthDate']??''):'';
  String get code => isLogin()?(_data['code']??''):'';
  String get image => isLogin()?(_data['image']??''):'';
  String get passport => isLogin()?(_data['passport']??''):'';

  void operator []=(String name, value) {
    _data[name] = value;
    save();
  }

  Future<Map> assign(Map newData)async{
    data = newData;
    await save();
    return data;
  }
  Map addAll(Map newData){
    try{
      data.addAll(newData);
      return data;
    }catch(e){
      debugPrint(e.toString());
      return data;
    }
  }
  @protected
  Future<void> save()async{}

  @protected
  Future<void> clearData(Function() onSuccess)async{}

  Future<void> tokenExpired()async{}

  bool isLogin() => false;
  bool isOwner() => false;
  bool isAdmin() => false;

  dynamic remove(String key){
    return _data.remove(key);
  }

  Function(Map data)? onLoginSuccess;
  Function()? onLogoutSuccess;

  Future<dynamic> logoutOnDevice() async {}

  Future<dynamic> login(Map response) async {}

  Future<dynamic> logout() async {}

  @protected
  Future<void> loginCallback()async{
    if(_loginSuccessFunctions != null && _loginSuccessFunctions!.isNotEmpty){
      await Future.wait(_loginSuccessFunctions!.values.map((e) => e()).toList());
    }
  }

  @protected
  Future<void> logoutCallback()async{
    if(_logoutSuccessFunctions != null && _logoutSuccessFunctions!.isNotEmpty){
      await Future.wait(_logoutSuccessFunctions!.values.map((e) => e()).toList());
    }
  }
  void setLoginSuccessFunc(String key, Future<void> Function() callback){
    _loginSuccessFunctions ??= {};
    _loginSuccessFunctions!.addAll({
      key: callback
    });
  }
  void setLogoutSuccessFunc(String key, Future<void> Function() callback){
    _logoutSuccessFunctions ??= {};
    _logoutSuccessFunctions!.addAll({
      key: callback
    });
  }
  ///factories['loginLinkCallBack']
  VoidCallback? featureLoginCallback;
  @protected
  Future<void> onFeatureLoginCallback()async{
    await Future.delayed(const Duration(seconds: 1),(){
      if(featureLoginCallback != null){
        featureLoginCallback!();
        featureLoginCallback = null;
      }
    });
  }

  Map<String, Future<void> Function()>? _loginSuccessFunctions;
  Map<String, Future<void> Function()>? _logoutSuccessFunctions;
  Map getData(){
    return data;
  }
}