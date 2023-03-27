import 'package:docscanner/roughf-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Future main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoughfScreen(),
    );
  }
}
///storage/emulated/0/Android/data/com.docscanner.docscanner/files/filename.pdf