import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routename.notepage,
      onGenerateRoute: Routes.generateroutes,
    );
  }
}
