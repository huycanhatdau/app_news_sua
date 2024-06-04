// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as material;
// import 'package:vhv_basic/global.dart';
// import 'package:vhv_basic/helper.dart';
// import 'package:vhv_basic/widgets/BottomSheetMenu.dart';
//
// import 'app_info.dart';
// export 'package:vhv_basic/widgets/BottomSheetMenu.dart';
// typedef ShowDialogFunction = Function({
// String? title,
// TextStyle? titleStyle,
// Widget? content,
// String? middleText,
// Widget? cancel,
// List<Widget>? actions,
// VoidCallback? onCancel,
// VoidCallback? onCustom,
// VoidCallback? onConfirm,
// Color? confirmTextColor,
// Color? confirmColor,
// Color? backgroundColor,
// String? textConfirm,
// String? textCancel,
// String? textCustom,
// bool barrierDismissible,
// double radius,
// double elevation,
// WillPopCallback? onWillPop,
// EdgeInsets? insetPadding,
// EdgeInsets? contentPadding,
// bool showCloseButton,
// DialogSize dialogSize
//
// });
// class NavigatorLib extends AppNavigator{
//   NavigatorLib._();
//   static NavigatorLib? _instance;
//   static NavigatorLib get instance {
//     _instance ??= NavigatorLib._();
//     return _instance!;
//   }
//   bool isHomeLink(String? link){
//     if(link != null) {
//       return [AppInfo.domain, '${AppInfo.domain}/', '${AppInfo.domain}/home',
//         '${AppInfo.domain}/page/start', '${AppInfo.domain}/page/home',
//         '/page/start', 'page/start',
//         '/page/home', 'page/home',
//         '/'
//       ].contains(link.toLowerCase());
//     }
//     return false;
//   }
//   Future<dynamic> goToMenu(Map params, {Future<bool> Function(Map params)? extraProcess})async {
//
//     if (params['link'] == AppInfo.domain || params['link'] == '${AppInfo.domain}/'
//         || params['link'].toString().toLowerCase() == '${AppInfo.domain}/page/home') {
//       goToHome();
//       return;
//     }
//     if (params['link'] is String) {
//       final link = Uri.parse(params['link']);
//       if (empty(params['title']) && link.queryParameters.containsKey('title')) {
//         params['title'] = link.queryParameters['title'];
//       }
//       if (params['link'].startsWith('/page/') ||
//           params['link'].startsWith('page/')
//           || params['link'].startsWith('/pageCode/') ||
//           params['link'].startsWith('pageCode/')) {
//         params['link'] = '${AppInfo.domain}${params['link'].startsWith('/')
//             ? ''
//             : '/'}${params['link']}';
//       }
//     }
//     if(extraProcess != null){
//       final res = await extraProcess(params);
//       if(!res){
//         return false;
//       }
//     }
//     if (!empty(params['requiredLogin']) && !account.isLogin()) {
//       checkLoginFunction(() => goToMenu(params));
//       return true;
//     }
//     if(!appNavigator.isHome){
//       goToHome();
//     }
//     await Future.delayed(const Duration(milliseconds: 500));
//     final res = await linkToRouter(params['link'], generateRoute: generateRoute, notRouter: true);
//     if(res != false && res != '/' && res != '/Start'){
//       await linkToRouter(params['link'], generateRoute: generateRoute);
//     }
//   }
//   Future<bool> checkLinkOnRouter(Map params)async{
//     if(empty(params['link'])){
//       return false;
//     }
//     final res = await linkToRouter(params['link'], generateRoute: generateRoute, notRouter: true);
//     return !(res == false);
//   }
//
//   // @override
//   // Future<dynamic> showFullDialog({
//   //   bool barrierDismissible = true,
//   //   required Widget child,
//   //   WillPopCallback? onWillPop,
//   // })async{
//   //   return await showFullModal(
//   //       barrierDismissible: barrierDismissible,
//   //       child: child,
//   //       onWillPop: onWillPop
//   //   );
//   // }
//
//   @override
//   void setAnalyticsScreen(String router){
//     debugPrint('AppNavigator to $router');
//     if(factories['analyticsCurrentScreen'] is Function(String)){
//       factories['analyticsCurrentScreen'](_fixScreenName(router));
//     }
//   }
//
//   String _fixScreenName(String screen){
//     if(screen.startsWith('Closure: () => ')){
//       return screen.substring(15);
//     }else if(screen == '/'){
//       return 'StartPage';
//     }else if(screen.startsWith('/')){
//       return '${screen.replaceAll('/', '')}Page';
//     }
//     return screen;
//   }
//
//   Future<dynamic> showCustomDialog({
//     required Widget child,
//     bool barrierDismissible = true,
//   })async{
//     return await material.showDialog<void>(
//         context: currentContext,
//         barrierDismissible: barrierDismissible, // user must tap button!
//         builder: (BuildContext context) {
//           return child;
//         }
//     );
//   }
//
//
//   @override
//   ShowDialogFunction showDialog = ({
//     String? title,
//     TextStyle? titleStyle,
//     Widget? content,
//     String? middleText,
//     Widget? cancel,
//     List<Widget>? actions,
//     VoidCallback? onCancel,
//     VoidCallback? onCustom,
//     VoidCallback? onConfirm,
//     Color? confirmTextColor,
//     Color? confirmColor,
//     Color? backgroundColor,
//     String? textConfirm,
//     String? textCancel,
//     String? textCustom,
//     bool barrierDismissible = true,
//     double radius = 10.0,
//     double elevation = 10.0,
//     WillPopCallback? onWillPop,
//     EdgeInsets? insetPadding,
//     EdgeInsets? contentPadding,
//     bool showCloseButton = false,
//     DialogSize dialogSize = DialogSize.auto
//   })async{
//     try {
//       return await showModal(
//           title: title,
//           titleStyle: titleStyle,
//           content: content,
//           elevation: elevation,
//           middleText: middleText,
//           cancel: cancel,
//           actions: actions,
//           onCancel: onCancel,
//           onCustom: onCustom,
//           onConfirm: onConfirm,
//           confirmColor: confirmColor,
//           confirmTextColor: confirmTextColor,
//           backgroundColor: backgroundColor,
//           textConfirm: textConfirm,
//           textCancel: textCancel,
//           textCustom: textCustom,
//           barrierDismissible: barrierDismissible,
//           radius: radius,
//           onWillPop: onWillPop,
//           insetPadding: insetPadding,
//           contentPadding: contentPadding,
//           showCloseButton: showCloseButton,
//           dialogSize: dialogSize
//       );
//     }catch(_){
//       return null;
//     }
//   };
//
//   @override
//   BottomSheetFunction get bottomSheet => ({
//     final Widget? child,
//     final Widget? bottom,
//     final dynamic title,
//     final Widget? actionRight,
//     final Widget? actionLeft,
//     final BottomSheetType? type,
//     final Color? backgroundColor,
//     final EdgeInsets? padding,
//     final BorderRadiusGeometry? borderRadius,
//     bool isDismissible = true,
//     bool ignoreSafeArea = false,
//     bool isScrollControlled = true,
//     bool persistent = true,
//     bool enableDrag = true,
//     WillPopCallback? onWillPop,
//   })async{
//     return await lib.bottomSheet(WillPopScope(
//         onWillPop: onWillPop,
//         child: BottomSheetMenu(
//           bottom: bottom,
//           title: title,
//           actionRight: actionRight,
//           actionLeft: actionLeft,
//           backgroundColor: backgroundColor,
//           padding: padding,
//           type: type,
//           borderRadius: borderRadius,
//           child: child,
//         )
//     ), isScrollControlled: isScrollControlled,
//         ignoreSafeArea: ignoreSafeArea, isDismissible: isDismissible,
//         persistent: persistent, enableDrag: enableDrag);
//   };
//   @override
//   bool get isBottomSheetOpen => lib.isBottomSheetOpen??false;
//   @override
//   bool get isDialogOpen => lib.isDialogOpen??false;
//
//   BuildContext get context => Get.context!;
//   @override
//   dynamic showSnackBar({
//     required String? message,
//     Duration? duration
//   })async{
//     return lib.showSnackbar(GetSnackBar(
//       message: message,
//       margin: const EdgeInsets.all(10),
//       duration: duration??const Duration(seconds: 5),
//       borderRadius: 5,
//       boxShadows: const [
//         BoxShadow(blurRadius: 10, color: Colors.black45)
//       ],
//     ));
//   }
// }