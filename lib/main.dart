import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo/utility/widget/calendar.dart';

import 'home/home.dart';
import 'model/todoModels.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  Hive.openBox("Todo");

  Hive.registerAdapter(TodoAdapter());

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ReadData()),
        ],
        builder: (context, w) {
          return const MyApp();
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: FutureBuilder(
        future: Hive.openBox("Todo"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
