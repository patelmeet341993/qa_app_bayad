import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController urlController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  String getSiteUrl() {
    return "${urlController.text.trim()}?params=${tokenController.text.trim()}";
  }

  @override
  void initState() {
    super.initState();
   urlController.text="https://opp-qa.d1sw0dxh95ooqp.amplifyapp.com/";
  //  urlController.text="http://localhost:8080/";

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Url Screen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              getUrlTextField(),
              const SizedBox(height: 10),
              getTokenTextField(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final ChromeSafariBrowser browser = ChromeSafariBrowser();
                  browser.open(
                    url: WebUri(getSiteUrl()),
                    settings: ChromeSafariBrowserSettings(
                      showTitle: false,
                      enableUrlBarHiding: true,
                      navigationBarColor: Colors.black,
                      barCollapsingEnabled: true,
                      keepAliveEnabled: true,
                      startAnimations: [AndroidResource.anim(name: "slide_in_left", defPackage: "android"), AndroidResource.anim(name: "slide_out_right", defPackage: "android")],
                      exitAnimations: [
                        AndroidResource.anim(name: "abc_slide_in_top", defPackage: "com.pichillilorenzo.flutter_inappwebviewexample"),
                        AndroidResource.anim(name: "abc_slide_out_top", defPackage: "com.pichillilorenzo.flutter_inappwebviewexample")
                      ],
                      dismissButtonStyle: DismissButtonStyle.CLOSE,
                      presentationStyle: ModalPresentationStyle.OVER_FULL_SCREEN,
                    ),
                  );
                },
                child: const Text("Launch In Browser"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => WebviewScreen(url: getSiteUrl())));
                },
                child: const Text("Launch In Webview"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUrlTextField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: urlController,
            decoration: getDecoration(hint: "Enter Url"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            urlController.clear();
          },
          child: const Text("Clear"),
        ),
      ],
    );
  }

  Widget getTokenTextField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: tokenController,
            decoration: getDecoration(hint: "Enter Token"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            tokenController.clear();
          },
          child: const Text("Clear"),
        ),
      ],
    );
  }

  InputDecoration getDecoration({required String hint}) {
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: const BorderSide(),
      borderRadius: BorderRadius.circular(5),
    );

    return InputDecoration(
      hintText: hint,
      border: border,
      focusedBorder: border,
      enabledBorder: border,
    );
  }
}

class WebviewScreen extends StatefulWidget {
  final String url;

  const WebviewScreen({Key? key, required this.url,}) : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  void initState() {
    super.initState();
    InAppWebViewController.setWebContentsDebuggingEnabled(true);
    // InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
            shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
              //   var url = shouldOverrideUrlLoadingRequest.request.url;
              //   var uri = Uri.parse(url.toString());
              //
              //   if (!(uri.toString()).contains('https://opp-qa.d1sw0dxh95ooqp.amplifyapp.com/')) {
              //
              //   } else {
              //
              //   return NavigationActionPolicy.CANCEL;
              //   }
              // },
              return NavigationActionPolicy.ALLOW;
            },
          initialSettings: InAppWebViewSettings(

          ),
          initialUrlRequest: URLRequest(
            // url: WebUri(widget.url),
            url: WebUri(widget.url),
          ),
        ),
      ),
    );
  }
}