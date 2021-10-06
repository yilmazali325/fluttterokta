import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_example/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc_login_example/screens/home/main.dart';
import 'package:flutter_bloc_login_example/screens/login/loged2.dart';
import 'package:flutter_bloc_login_example/screens/login/main.dart';
import 'package:flutter_bloc_login_example/shared/locator.dart';

import 'bloc/auth/auth_event.dart';

void main() {
  Locator.setup();
  runApp(Application());
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // case '/loged2':
      //   return MaterialPageRoute(
      //       builder: (_) => Loged2(
      //             location: args,
      //           ));
      case '/':
        return MaterialPageRoute(builder: (_) => Application());
      case '/webview':
        return MaterialPageRoute(builder: (_) => Application());
      case '/loged2':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => Loged2(
              location: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('ERROR'),
      ),
    );
  });
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocAuth>(create: (BuildContext context) => BlocAuth()),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        title: 'Bloc Login Demo',
        home: LoginScreen(),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocAuth>(context).add(ForceLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
