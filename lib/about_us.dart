import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);


  @override
  _AboutScreenState createState() => _AboutScreenState();
}


class _AboutScreenState extends State<AboutScreen> {

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();
  late String fileHtmlContents;

  late WebViewController webViewController;
  String htmlFilePath = 'assets/about-us.html';
  loadLocalHTML() async {
     fileHtmlContents = await rootBundle.loadString(htmlFilePath);
     webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
         mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        key: _scaffoldKey,
        appBar: CupertinoNavigationBar(
          leading: FittedBox(
            child: CupertinoNavigationBarBackButton(
              previousPageTitle: "Back",
              color: MyApp.primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          border: Border.all(color: Colors.white),
          middle: const Text(
            "About Us",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 17
                    ,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(100, 243, 243, 243),
          brightness: Brightness.light,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WebView(
              key: _key,
              gestureRecognizers: gestureRecognizers,
              initialUrl: '',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController tmp) {
                webViewController = tmp;
                loadLocalHTML();
              },
            )),
        // floatingActionButton: _bookmarkButton(),
      ),
    );
  }
}