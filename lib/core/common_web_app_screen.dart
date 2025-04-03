import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomWebViewScreen extends StatefulWidget {
  final String url;

  const CustomWebViewScreen({required this.url, super.key});

  @override
  State<CustomWebViewScreen> createState() => _CustomWebViewScreenState();
}

class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
  bool _isLoading = true;
  // final ValueNotifier<bool> isError = ValueNotifier<bool>(false);

  Future<void> _downloadPdf() async {
    if (await _requestPermission(Permission.storage)) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final String filePath =
            '${directory.path}/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}_challan.pdf';
        File file = File(filePath);
        if (file.existsSync()) {
          file.deleteSync();
        }
        await _downloadFile(widget.url, filePath);
      } else {
        _showError("Unable to find storage directory");
      }
    } else {
      _showError("Storage permission denied");
    }
  }

  Future<void> _downloadFile(String url, String savePath) async {
    try {
      final dio = Dio();
      final response = await dio.download(url, savePath);
      if (response.statusCode == 200) {
        OpenFile.open(savePath);
      } else {
        _showError("Download failed with status: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Download failed: $e");
    }
  }

  void _showError(String message) {
    EasyLoading.showToast(message,
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("widget.urlOne ${widget.url}");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Challan',
                style: TextStyle(color: Colors.white),
              ),
              InkWell(
                onTap: () async {
                  if (widget.url.isNotEmpty) {
                    _downloadPdf();
                  } else {
                    EasyLoading.showInfo('No data found');
                    return;
                  }
                },
                child: const Icon(
                  Icons.download,
                  color: Colors.white,
                ),
              )
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: widget.url.isEmpty
            ? const Center(
                child: Text(
                  'No data found',
                  style: TextStyle(color: Colors.black),
                ),
              )
            : Stack(
                children: <Widget>[
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: WebUri.uri(Uri.parse(
                            'https://docs.google.com/gview?embedded=true&url=${widget.url}'))),
                    onLoadStart:
                        (InAppWebViewController controller, WebUri? url) {
                      setState(() {
                        _isLoading = true;
                        // print("Loading started: $url");
                      });
                    },
                    onLoadStop:
                        (InAppWebViewController controller, WebUri? url) async {
                      setState(() {
                        _isLoading = false;
                        // print("Loading stopped: $url");
                      });
                      // Scroll to the bottom once the page is loaded
                      // controller.evaluateJavascript(
                      //     source:
                      //         "window.scrollTo(0, document.body.scrollHeight);");

                      // Scroll to the bottom once the page is loaded
                      await controller.evaluateJavascript(
                          source:
                              "window.scrollTo(0, document.body.scrollHeight);");
                    },
                    onReceivedError: (InAppWebViewController controller,
                        WebResourceRequest url, WebResourceError code) {
                      setState(() {
                        _isLoading = false;
                        // print("onReceivedError stopped: $url");
                      });
                    },
                    onZoomScaleChanged: (InAppWebViewController controller,
                        double oldScale, double newScale) {
                      // print("onZoomScaleChanged: $newScale");
                    },
                    initialSettings: InAppWebViewSettings(
                      displayZoomControls: true,
                      alwaysBounceHorizontal: true,
                      alwaysBounceVertical: true,
                      automaticallyAdjustsScrollIndicatorInsets: true,
                      clearCache: true,
                      useShouldOverrideUrlLoading: true,
                      javaScriptEnabled:
                          false, //? DONT MAKE TRUE DUE TO CHALLAN NOT VIEWING
                      mixedContentMode:
                          MixedContentMode.MIXED_CONTENT_NEVER_ALLOW,
                    ),
                    onReceivedServerTrustAuthRequest:
                        (InAppWebViewController controller,
                            URLAuthenticationChallenge challenge) async {
                      // Allow self-signed certificates
                      return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED,
                      );
                    },
                  ),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                          color: primaryColor, backgroundColor: Colors.orange),
                    ),
                ],
              ));
  }
}
