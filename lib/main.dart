
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kitab/views/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image to Text',
        theme: ThemeData.dark(),

          home: HomePage(),
         );
  }
}
