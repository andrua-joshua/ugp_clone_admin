import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ugp_clone_admin/models/lost_and_found.dart';
import 'package:ugp_clone_admin/models/missing_person.dart';
import 'package:ugp_clone_admin/models/report.dart';
import 'package:ugp_clone_admin/routes/add_lost_and_found/add_lost_and_found.dart';
import 'package:ugp_clone_admin/routes/add_missing_person/add_missing_person.dart';
import 'package:ugp_clone_admin/routes/add_station/add_station.dart';
import 'package:ugp_clone_admin/routes/emergency_screen/emergency_screen.dart';
import 'package:ugp_clone_admin/routes/google_maps_screen/google_maps_screen.dart';
import 'package:ugp_clone_admin/routes/home_screen/home_screen.dart';
import 'package:ugp_clone_admin/routes/login_screen/login_screen.dart';
import 'package:ugp_clone_admin/routes/lost_and_found_screen/lost_and_found_screen.dart';
import 'package:ugp_clone_admin/routes/missing_persons_screen/missing_persons_screen.dart';
import 'package:ugp_clone_admin/routes/reports_screen/reports_screen.dart';
import 'package:ugp_clone_admin/routes/stations_screen/stations_screen.dart';
import 'package:ugp_clone_admin/routes/unit_lost_and_found_item_screen/unit_lost_and_found_item_screen.dart';
import 'package:ugp_clone_admin/routes/unit_missing_person_screen/unit_missing_person_screen.dart';
import 'package:ugp_clone_admin/routes/unit_report_screen/unit_report_screen.dart';

class RouteGenerator{

  static const String loginScreen = "/";
  static const String signUpScreen = "/signupScreen";
  static const String homeScreen = "/homeScreen";
  static const String lostAndFoundScreen = "/lostAndFoundScreen";
  static const String missingPersonsScreen = "/missingPersonsScreen";
  static const String searchStationsScreen = "/searchStationsScreen";
  static const String unitMissingPersonScreen = "/unitMissingPersonScreen";
  static const String unitLostAndFoundItemScreen = "/unitLostAndFoundItemScreen";

  static const String reportCrimeScreen = "/reportCrimeScreen";

  static const String emergencyScreen = "/emergencyScreen";


  static const String addStationScreen = "/addStationScreen";
  static const String addlostAndFoundScreen = "/addlostAndFoundScreen";
  static const String addMissingPersonScreen = "/addMissingPersonScreen";
  static const String googleMapsScreen = "/googleMapsScreen";
  static const String reportDetailsScreen = "/reportDetailsScreen";
  

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case homeScreen:
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),);

      case googleMapsScreen:
          final maker = settings.arguments as Marker;
          return MaterialPageRoute(
            builder: (_) => GoogleMapsScreen(stationMarker:  maker,),);

      case reportDetailsScreen:
          final report = settings.arguments as Report;
          return MaterialPageRoute(
            builder: (_) => UnitReportScreen(report:  report,),);

      case addStationScreen:
          return MaterialPageRoute(
            builder: (_) => const AddStation(),);

      case addlostAndFoundScreen:
          return MaterialPageRoute(
            builder: (_) => const AddLostAndFound(),);

      case addMissingPersonScreen:
          return MaterialPageRoute(
            builder: (_) => const AddMissingPerson(),);

      case loginScreen:
          return MaterialPageRoute(
            builder: (_) => const LoginScreen(),);

      case reportCrimeScreen:
          return MaterialPageRoute(
            builder: (_) => const ReportsScreen(),);

      case lostAndFoundScreen:
          return MaterialPageRoute(
            builder: (_) => const LostAndFoundScreen(),);

      case unitLostAndFoundItemScreen:
        final item = settings!.arguments as LostAndFound;
          return MaterialPageRoute(
            builder: (_) =>  UnitLostAndFoundScreen(item: item,));

      case missingPersonsScreen:
          return MaterialPageRoute(
            builder: (_) => const MissingPersonsScreen());

      case unitMissingPersonScreen:
          final person = settings!.arguments as MissingPerson;
          return MaterialPageRoute(
            builder: (_) => UnitMissingPersonScreen(person: person,));

      case searchStationsScreen:
          return MaterialPageRoute(
            builder: (_) => const SearchStationsScreen());

          

      case emergencyScreen:
          return MaterialPageRoute(
            builder: (_) => const EmergencyScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_)=> const HomeScreen());
    }
  }

}