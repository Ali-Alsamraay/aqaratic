import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  WebViewScreenState createState() => WebViewScreenState();

  String urlLink;

  WebViewScreen({required this.urlLink});
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            WebView(
              initialUrl: widget.urlLink,
            ),
            Positioned(
                top: 20.0,
                right: 20.0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
