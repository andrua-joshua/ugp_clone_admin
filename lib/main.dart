import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/routes.dart';
import 'package:ugp_clone_admin/routes/add_lost_and_found/add_lost_and_found.dart';
import 'package:ugp_clone_admin/routes/add_missing_person/add_missing_person.dart';
import 'package:ugp_clone_admin/routes/login_screen/login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ChangesProvider>(
      create: (_)=> ChangesProvider(),
      builder: (context, child) => const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ugp_clone Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.loginScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: const  AddMissingPerson(),
    );
  }
}
