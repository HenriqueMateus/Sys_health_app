import 'package:flutter/material.dart';
import 'package:sys_health_app/screens/Home.dart';
import 'package:sys_health_app/screens/registerAlas/index.dart';
import 'package:sys_health_app/screens/registerMedicos/index.dart';
import 'package:sys_health_app/screens/registerPacientes/index.dart';
import 'AppRoutes.dart';

void main() {
  runApp(HomeSL());
}
Map<String, WidgetBuilder> routes = {
  AppRoutes.FORMPACIENTE: (context) => RegisterPacientes(),
  AppRoutes.FORMMEDICO: (context) => RegisterMedicos(),
  AppRoutes.FORMALA: (context) => RegisterAlas()
};
class HomeSL extends StatelessWidget {
  const HomeSL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        routes: routes,
    );
  }
}
