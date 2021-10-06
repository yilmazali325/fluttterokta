import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_login_example/screens/home/main.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewWebView extends StatelessWidget {
  final location;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  NewWebView({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("MyApp"),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(location)),
          onWebViewCreated: (InAppWebViewController controller) {},
          onLoadStop: (controller, url) async {
            if (url.toString().contains("localhost")) {
              String location;
              url.queryParameters.forEach((k, v) {
                if (k == 'code') {
                  location = v;
                }
              });
              Navigator.pushReplacement(
                  scaffoldKey.currentContext,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            location: location,
                          )));
            }
          },
        ),
      ),
    );
  }
}
