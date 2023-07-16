import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:amazon_clone_nodejs/provider/user_provider.dart';
import 'package:amazon_clone_nodejs/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/screens/auth_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      title: 'Amazone Clone',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}
