import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/presenter/WebPresenter.dart';
import 'package:webview_flutter/webview_flutter.dart' as web;
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends WebPresenter {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: web.WebView(
            initialUrl: 'https://www.sfi.co.id/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              // _controller.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>[
            ].toSet(),
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          ),
        ),
      ),
    );
  }
}
