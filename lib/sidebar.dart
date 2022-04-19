import 'package:Krishworks_Assignment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './main.dart';
import 'package:webview_flutter/webview_flutter.dart';


const Color1 = const Color(0xff002633);
const Color2 = const Color(0xff015574);

var oN = true;
var oFF = false;

void main() {
  runApp(new MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Webview Demo';
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return new MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Color1,
      )),
      title: title,
      // debugShowCheckedModeBanner: false,
      // home: Page1(),

      home: new MyAppHomePage(),
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const String flutterUrl = "https://flutter.dev/";
const String wikiUrl = "https://es.wikipedia.org";

class _MyAppState extends State<MyAppHomePage> {
  WebViewController _controller;

  openGallery() async {
    var url = await _controller.currentUrl();
    _controller.loadUrl(
      url = "https://krishworks.com/gallery/",
    );
    print(url);
  }

  openContact() async {
    var url = await _controller.currentUrl();
    _controller.loadUrl(
      url = "https://krishworks.com/contact/",
    );
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Text("Close", style: TextStyle(color: Colors.white),));
          },
        ),
        title: Text("Setting"),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () {
                          openGallery();
                          setState(() {
                            oN = true;
                            oFF = false;
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Gallery",
                              style: oN
                                  ? TextStyle(color: Colors.orange)
                                  : TextStyle(color: Color2)),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (oN) {
                                  return Color1;
                                } else {
                                  return Colors.white;
                                }
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    )))),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () {
                          openContact();
                          setState(() {
                            oN = false;
                            oFF = true;
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Contact Us",
                              style: oFF
                                  ? TextStyle(color: Colors.orange)
                                  : TextStyle(color: Color1)),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (oFF) {
                                  return Color1;
                                } else {
                                  return Colors.white;
                                }
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    )))),
                  )
                ])),
            Expanded(
              flex: 8,
              child: WebView(
                key: Key("webview"),
                initialUrl: "https://krishworks.com/gallery/",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}