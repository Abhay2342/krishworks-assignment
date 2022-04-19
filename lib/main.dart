import 'package:Krishworks_Assignment/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

const Color1 = const Color(0xff002633);
const Color2 = const Color(0xff015574);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: AppBar(
              backgroundColor: Color1,
            ),
          ),
          body: SizedBox(
            width: double.infinity,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Color1,
                            borderRadius: BorderRadius.circular(0)
                        ),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            SizedBox(
                              child: IconButton(onPressed: () {
                                {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Stack(
                                            overflow: Overflow.visible,
                                            children: <Widget>[
                                              Positioned(
                                                right: -40.0,
                                                top: -40.0,
                                                child: InkResponse(
                                                  onTap: () {
                                                    Text("Developer Passcode");
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Text("Developer Passcode"),
                                                    ),
                                                    OtpTextField(
                                                      autoFocus: true,
                                                      numberOfFields: 6,
                                                        showFieldAsBox: true,
                                                        fieldWidth: 60,
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      borderWidth: 1,
                                                      cursorColor: Colors.blue,
                                                      onSubmit: (pin) {
                                                        int pass;
                                                        DateTime now = new DateTime.now();
                                                        pass = now.year * now.month * now.day;
                                                        if (pin == pass.toString()) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => MyApp2()),
                                                          );
                                                        }
                                                        print("Completed: " + pin);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(20.0))),
                                        );
                                      });
                                };
                              }, icon: Icon(Icons.settings), color: Colors.white,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(8.0),
                                    height: 50,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Color2,
                                        borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child:  SizedBox(
                                      child: TabBar(
                                        indicator: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:  BorderRadius.circular(10.0)
                                        ) ,
                                        labelColor: Color1,
                                        unselectedLabelColor: Colors.white,
                                        tabs: const  [
                                          Tab(text: 'Home',),
                                          Tab(text: 'About Us',),
                                          Tab(text: 'Updates',),
                                        ],
                                      ),
                                    )
                                ),

                              ],
                            ),
                            SizedBox(
                              child: Text(""),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                            children:  [
                              Center(child: WebView(
                                key: Key("webview"),
                                initialUrl: "https://krishworks.com/",
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated: (WebViewController webViewController) {
                                  _controller = webViewController;
                                },
                              ),),
                              Center(child: WebView(
                                key: Key("webview"),
                                initialUrl: "https://krishworks.com/about/",
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated: (WebViewController webViewController) {
                                  _controller = webViewController;
                                },
                              ),),
                              Center(child: WebView(
                                key: Key("webview"),
                                initialUrl: "https://krishworks.com/updates/",
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated: (WebViewController webViewController) {
                                  _controller = webViewController;
                                },
                              ),),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
          )
      ),
    );
  }
}