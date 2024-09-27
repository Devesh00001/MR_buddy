import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/features/mr_detail_visualization/provider/data_disualization_provider.dart';
import 'package:mr_buddy/features/welcome/screen/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'features/clients/provider/client_provider.dart';
import 'features/dashboard/provider/dashboard_provider.dart';
import 'features/drugs/provider/drugs_provider.dart';
import 'features/home/provider/home_provider.dart';
import 'features/mr/provider/mr_detail_provider.dart';
import 'features/visit_detail/provider/visitdetail_provider.dart';
import 'features/weekly plan/provider/weekly_plan_provider.dart';
import 'features/welcome/provider/welcome_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => WelcomeProvider()),
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ChangeNotifierProvider(create: (_) => WeeklyProviderPlan()),
    ChangeNotifierProvider(create: (_) => VisitDetailProvider()),
    ChangeNotifierProvider(create: (_) => ClinetProvider()),
    ChangeNotifierProvider(create: (_) => DrugsProvider()),
    ChangeNotifierProvider(create: (_) => MRDetailProvider()),
    ChangeNotifierProvider(create: (_) => DataVisualizationProvider())
  ],
   child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SpaceGrotesk'),
      home: const WelcomeScreen(),
    );
  }
}
