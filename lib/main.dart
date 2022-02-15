import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  bool isShow = false;

  NetworkImage networkImage = NetworkImage( "http://www5d.biglobe.ne.jp/~satis/flutter_test.jpg" );
  AssetImage assetImage = AssetImage( "assets/test.jpg" );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 下の2行をコメントアウトすると、「表示」ボタンを押してからの表示が少し遅れる
    precacheImage(networkImage, context, onError: (_,__) {});
    precacheImage(assetImage, context);
  }

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0
      ),
      body: isShow ? Column( children: [
        Row( children: [
          Image( image: networkImage, width: contentHeight * 0.5, height: contentHeight * 0.5, fit: BoxFit.fill,
              errorBuilder: ( BuildContext context, Object exception, StackTrace? stackTrace ){
                return const Icon( Icons.error, color: Colors.grey );
              }
          ),
        ] ),
        Row( children: [
          Image( image: assetImage, width: contentHeight * 0.5, height: contentHeight * 0.5, fit: BoxFit.fill ),
        ] ),
      ] ) : SizedBox(
          width: contentWidth,
          height: contentWidth / 8,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isShow = true;
                });
              },
              child: Text(
                "表示",
                style: TextStyle( fontSize: contentWidth / 16 ),
              )
          )
      ),
    );
  }
}
