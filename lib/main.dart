import 'package:devinity_recruitment_task/core/infrastructure/injection/injection.dart';
import 'package:devinity_recruitment_task/presentation/home/home_page.dart';
import 'package:devinity_recruitment_task/presentation/plant_form/plant_form_page.dart';
import 'package:flutter/material.dart';

const _envKey = "ENV";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(const String.fromEnvironment(_envKey));

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/plant-form': (context) => const PlantFormPage(),
      },
    );
  }
}
