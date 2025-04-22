import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class WebViewPage extends StatefulWidget {
  final String url;
  
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              errorMessage = null;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) async {
               Uri uri = Uri.parse(request.url);
            print('request: $uri');

            if (request.url.startsWith('intent://')) {
              _handleIntentUrl(request.url);
              return NavigationDecision.prevent;
            }

            if (request.url.contains('/save-payment-vnpay')) {
              Uri uri = Uri.parse(request.url);
              print('URL::: $uri');
              String? transactionStatus = uri.queryParameters['vnp_TransactionStatus'];
              String? transactionId = uri.queryParameters['vnp_BankTranNo'];
              Map<String, String> transactionData = {
                'transactionId': transactionId ?? 'unknown',
                'transactionStatus': transactionStatus ?? 'unknown',
              };

              if (transactionData != null) {
                Navigator.pop(context, transactionData);
              } else {
                Navigator.pop(context, 'unknown');
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
              errorMessage = 'Error: ${error.description}';
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _handleIntentUrl(String url) async {
    String updatedUrl = url.replaceAll('intent://', 'f5smartaccount://');
    final storeUrl = 'https://play.google.com/store/apps/details?id=vnpay.smartacccount';
    try {
      if(await canLaunchUrl(Uri.parse(updatedUrl))){
        await launchUrl(Uri.parse(updatedUrl));
        Navigator.pop(context);
      }else{
        await launchUrl(Uri.parse(storeUrl));
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error: $e'); 
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (errorMessage == null) 
            WebViewWidget(controller: controller),
          if (isLoading && errorMessage == null) 
           const Center(
              child: CircularProgressIndicator(),
            ),
            if (errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
        
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 80,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Oops! Có lỗi xảy ra",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: primaryTextStyle()
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text("Quay lại",style: secondaryTextStyle(), ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          ],
          
        ),
      ),
    );
  }
}
