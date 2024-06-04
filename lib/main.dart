import 'package:auth_fire/config_firebase.dart';
import 'package:auth_fire/import.dart';
import 'package:auth_fire/routes.dart';
import 'package:auth_fire/themdata.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    var directory = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(directory.path);
    await dotenv.load(fileName: 'lib/.env');
    await Firebase.initializeApp(options: configFirebase);
  } catch (e) {
    if (kDebugMode) {
      print('Failed to initialize: $e');
    }
  }

  // initFactories
  factoriesInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo all Type Login',
      theme: AppTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: '/initStart',
      getPages: routes,
    );
  }
}
