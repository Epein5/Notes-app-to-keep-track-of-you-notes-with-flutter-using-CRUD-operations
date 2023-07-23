import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/description_page.dart';
import 'package:flutter_application_1/pages/notes_page.dart';

class Routename {
  static const String notepage = "notepage";
  static const String descriptionpage = "descriptionpage";
}

class Routes {
  static Route<dynamic> generateroutes(RouteSettings settings) {
    switch (settings.name) {
      case Routename.descriptionpage:
        return MaterialPageRoute(builder: (context) => DescriptionPage());
      case Routename.notepage:
        return MaterialPageRoute(builder: (context) => NotesPage());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Text("No Routes Choosen"),
          );
        });
    }
  }
}
