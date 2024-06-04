import 'package:auth_fire/import.dart';

FirebaseOptions configFirebase = FirebaseOptions(
  apiKey: dotenv.env['API_KEY'] ?? '',
  projectId: dotenv.env['PROJECT_ID'] ?? '',
  appId: dotenv.env['APP_ID'] ?? '',
  messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ?? '',
  storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
);

