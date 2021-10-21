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
//           initialData: InAppWebViewInitialData(data: """
// <!DOCTYPE html>
// <html lang="en">
//     <head>
//         <meta charset="UTF-8">
//         <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
//     </head>
//     <body>
//         <h1>JavaScript Handlers</h1>
//         <script>
//             window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
//                 window.flutter_inappwebview.callHandler('handlerFoo')
//                   .then(function(result) {
//                     // print to the console the data coming
//                     // from the Flutter side.
//                     console.log(JSON.stringify(result));
//                     document.getElementById('okta-signin-username').value = '" +
//                           "test" +
//                           "'; })();
//                     window.flutter_inappwebview
//                       .callHandler('handlerFooWithArgs', 1, true, ['bar', 5], {foo: 'baz'}, result);
//                 });
//             });
//         </script>
//     </body>
// </html>
//                       """),
          initialUrlRequest: URLRequest(url: Uri.parse(location)),
          onWebViewCreated: (InAppWebViewController controller) {
            controller.addJavaScriptHandler(
                handlerName: 'handlerFoo',
                callback: (args) {
                  // return data to the JavaScript side!
                  return {'bar': 'bar_value', 'baz': 'baz_value'};
                });
            controller.addJavaScriptHandler(
                handlerName: 'handlerFooWithArgs',
                callback: (args) {
                  print(args);
                  // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                });
          },
          onLoadStop: (controller, url) {
            if (url.toString().contains("dev-68546164")) {
              controller.evaluateJavascript(
                  source: "javascript:(function() { " +
                      " document.getElementById('okta-signin-username').value = '" +
                      "iron-man@example.com" +
                      "';" +
                      " document.getElementById('okta-signin-password').value = '" +
                      "marvel_2021" +
                      "';" +
                      //" document.getElementById('okta-signin-submit').onclick = function (){}" +
                      // " document.getElementById('okta-signin-username').readOnly='true'" +
                      "})();");
              controller.evaluateJavascript(
                  source:
                      "javascript:(function() {document.getElementById('okta-signin-submit').click();'" +
                          "'})()");
            }

            if (url.toString().contains("localhost")) {
              controller.evaluateJavascript(
                  source: "javascript:(function() { " +
                      " document.getElementById('okta-signin-username').value = '" +
                      "emailAdress" +
                      "';" +
                      " document.getElementById('okta-signin-username').readOnly='true'" +
                      "})();");
              // controller.addJavaScriptHandler(
              //     handlerName: 'myHandlerName',
              //     callback: (args) {
              //       // print arguments coming from the JavaScript side!
              //       print(args);
              //       // return data to the JavaScript side!
              //       return {'bar': 'bar_value', 'baz': 'baz_value'};
              //     });
              // String result3 = await controller.evaluateJavascript(
              //     source:
              //         "document.getElementById('okta-signin-username').value = '" +
              //             "test" +
              //             "'; })()");
              // controller.addJavaScriptHandler(
              //     handlerName: 'handlerFoo',
              //     callback: (args) {
              //       // return data to the JavaScript side!
              //       return {'bar': 'bar_value', 'baz': 'baz_value'};
              //     });
              // controller.addJavaScriptHandler(
              //     handlerName: 'handlerFooWithArgs',
              //     callback: (args) {
              //       print(args);
              //       // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
              //     });
              // await controller.evaluateJavascript(
              //     source:
              //         "javascript:(function() { document.getElementById('okta-signin-username').value = '" +
              //             "testusername" +
              //             "'; })()");
              // await controller.evaluateJavascript(
              //     source:
              //         "document.getElementById('okta-signin-password').value = '" +
              //             "testpassword" +
              //             "'; })()");
              // print(result3);
              //controller.loadUrl("javascript:(function() { document.getElementById('email_field').value = '" + email + "'; })()");

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
