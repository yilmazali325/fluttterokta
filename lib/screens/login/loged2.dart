// import 'dart:async';

// import 'package:flutter/material.dart';

// class Loged2 extends StatefulWidget {
//   final location;
//   // This widget is the root of your application.
//   Loged2({Key key, this.location}) : super(key: key);

//   @override
//   State<Loged2> createState() => _Loged2State();
// }

// class _Loged2State extends State<Loged2> {

//   StreamSubscription _onDestroy;
//   StreamSubscription<String> _onUrlChanged;

//   String token;

//   @override
//   void dispose() {
//     // Every listener should be canceled, the same should be done with this stream.
//     _onDestroy.cancel();
//     _onUrlChanged.cancel();
//     _onStateChanged.cancel();
//     flutterWebviewPlugin.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     flutterWebviewPlugin.close();
//     //flutterWebviewPlugin.close();

//     // Add a listener to on destroy WebView, so you can make came actions.
//     _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
//       print("destroy");
//     });

//     _onStateChanged =
//         flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
//       print("onStateChanged: ${state.type} ${state.url}");
//     });

//     // Add a listener to on url changed
//     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (mounted) {
//         setState(() {
//           print("URL changed: $url");
//           if (url.contains("localhost")) {
//             RegExp regExp = new RegExp("#code=(.*)");
//             this.token = regExp.firstMatch(url)?.group(1);
//             print("token $token");
//             //Navigator.pop(context);

//             //saveToken(token);
//             // Navigator.of(context)
//             //     .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
//             Navigator.pushNamed(context, '/');
//             // flutterWebviewPlugin.close();
//             // flutterWebviewPlugin.close();
//             // flutterWebviewPlugin.close();
//             // flutterWebviewPlugin.close();
//             // Navigator.pushReplacement(
//             //     context, SlideDownRoute(page: LoginScreen()));
//           }
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String loginUrl = widget.location;

//     return new WebviewScaffold(
//         url: loginUrl,
//         appBar: new AppBar(
//           title: new Text("Login to someservise..."),
//         ));
//     // return MaterialApp(
//     //     title: 'Title Your App',
//     //     theme: ThemeData(
//     //       primarySwatch: Colors.blue,
//     //     ),
//     //     home: Scaffold(
//     //         body: Container(
//     // child: WebView(
//     //   initialUrl: widget.location,
//     //   javascriptMode: JavascriptMode.unrestricted,
//     //   onWebViewCreated: (WebViewController webViewController) async {
//     //     _controller.complete(webViewController);
//     //     var currenturl = await webViewController.currentUrl();
//     //     print(currenturl);
//     //   },
//     // ),
//     //         child: WebView(
//     //   onPageFinished: (url) async {
//     //     if (url.toLowerCase().contains("localhost")) {
//     //       final SharedPreferences prefs =
//     //           await SharedPreferences.getInstance();
//     //       prefs.setString('lasturl', url);
//     //       print(url);
//     //       Navigator.pop(context);
//     //       Navigator.push(
//     //           context, SlideDownRoute(page: HomeScreen(location: url)));
//     //     }
//     //   },
//     //   javascriptMode: JavascriptMode.unrestricted,
//     //   initialUrl: widget.location,
//     // )
//     // child: WebviewScaffold(
//     //   url: widget.location,
//     //   withJavascript: true,
//     //   withZoom: false,
//     //   hidden: true,
//     //   appBar: AppBar(
//     //     title: Text("Flutter"),
//     //     elevation: 1,
//     //     actions: <Widget>[
//     //       InkWell(
//     //         child: Icon(Icons.refresh),
//     //         onTap: () {
//     //           flutterWebviewPlugin.hide();
//     //           // flutterWebviewPlugin.reloadUrl("any link");
//     //         },
//     //       ),
//     //     ],
//     //   ),
//     // ),
//     // )));
//   }
// }
