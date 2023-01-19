import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailView extends StatefulWidget {
  final String event_url,
      title,
      location,
      start_time_display,
      end_time_display,
      full_address;

  const DetailView(
      {this.event_url,
      this.title,
      this.location,
      this.end_time_display,
      this.full_address,
      this.start_time_display});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text("All", style: TextStyle(color: Colors.white)),
          Text(
            "Events.in",
            style: TextStyle(color: Colors.white),
          )
        ]),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.save,
                  color: Colors.black,
                )),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.event_url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
