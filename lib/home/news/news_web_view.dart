import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/widget/main_loading_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String url;
   NewsWebView({super.key, required this.url});

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    controller = WebViewController()
       ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios),color: AppColors.blackColor,),


       backgroundColor: AppColors.whiteColor,
        title: Text('News'),),

      body: Stack(
        children: [
          WebViewWidget (controller: controller),
          if(isLoading) MainLoadingWidget()
        ],
      ),
    );
  }
}
