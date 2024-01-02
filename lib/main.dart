import 'dart:developer' as developer;

import 'package:contacts_buddy/style.dart';
import 'package:contacts_buddy/utils/navigation_service.dart';
import 'package:contacts_buddy/viewmodels/add_update_contacts_viewmodel.dart';
import 'package:contacts_buddy/viewmodels/contacts_viewmodel.dart';
import 'package:contacts_buddy/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) => ContactsViewModel()),
      ),
      ChangeNotifierProvider(
        create: ((context) => AddUpdateContactsViewModel()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    databaseConfig();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blueLvl1,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeView(),
      builder: EasyLoading.init(),
    );
  }

  databaseConfig() async {
    final databasePath = '${await getDatabasesPath()}contacts.db';
    developer.log('(databaseConfig) Database path: $databasePath');
    developer.log('--------------------------');
  }
}
