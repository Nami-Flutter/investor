import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../../core/utils/showToast.dart';
import '../../widgets/custom_app_bar2.dart';
import '../home/investment_success_screen.dart';
import '../home_layout/home_layout_screen.dart';


class PayWebViewScreen extends StatefulWidget {
  const PayWebViewScreen({Key? key, required this.id}) : super(key: key);
final int id;
  @override
  State<PayWebViewScreen> createState() => _PayWebViewScreenState();
}

class _PayWebViewScreenState extends State<PayWebViewScreen> {
  String filedUrl ='https://investor.ascit.sa/payment-failed';
  String successUrl ='https://investor.ascit.sa/payment-success';
  WebViewController? _webViewController;
  String _currentUrl = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayoutScreen()), (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar2(
          color: Colors.white,
          title: "اكمل بيانات الدفع".tr(),
          onBackPress: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayoutScreen()), (route) => false);
          },
        ),
        body: WebView(
          initialUrl: "https://investor.ascit.sa/payment/${widget.id}",
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (String url) {
            setState(() {
              _currentUrl = url;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _currentUrl = url;
              if (_currentUrl == successUrl){
                Timer(const Duration(seconds: 2), () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const InvestmentSuccess(),), (route) => false);
                });
              }else if(_currentUrl == filedUrl){
                ToastUtils.showToast("فشل عملية الدفع".tr());
                Timer(const Duration(seconds: 2), () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeLayoutScreen()), (route) => false);
                });
              }
            });
          },
          onWebViewCreated: (WebViewController webViewController) {
            // Map<String, String> headers = {"Authorization": "Bearer ${Provider.of<AuthViewModel>(context, listen: false).saveUserData.getUserToken()}"};
            // webViewController.loadUrl('', headers: headers);
            _webViewController = webViewController;
          },
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text('Current URL: $_currentUrl'),
        //   ),
        // ),
      ),
    );
  }
}