import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vbjqjodcoaveggloagnv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZianFqb2Rjb2F2ZWdnbG9hZ252Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyMDYzODksImV4cCI6MjA2Njc4MjM4OX0.0we5cDip7KsBV6z0nBOkUbdiP22C0zMTEunYhy1dPjc',
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
