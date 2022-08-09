import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPortal extends StatefulWidget {
  const WebPortal({Key? key}) : super(key: key);


  @override
  State<WebPortal> createState() => _WebPortalState();
}


class _WebPortalState extends State<WebPortal> {
  late InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: InAppWebView(
                      initialUrlRequest: URLRequest(
                      url: Uri.parse("https://webcamtoy.com/")
                    ),
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          mediaPlaybackRequiresUserGesture: false,
                        ),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                        return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                      }
                  ),
                ),
              ),
            ]))
      
      );
  }
}
