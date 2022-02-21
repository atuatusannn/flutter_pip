import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _betterPlayerKey = GlobalKey();
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(aspectRatio: 16 / 9, fit: BoxFit.contain);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8",
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);

    var ispipOk = _betterPlayerController.isPictureInPictureSupported();
    ispipOk.then((result) {
      print(result);
    });

    super.initState();
  }

  Future<void> OpenPip() async {
    print("000000000000");
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8"
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    await _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    print("000000000000");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            // BetterPlayer.network(
            //   "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8"
            // ),
            SizedBox(
              width: 300,
              child: BetterPlayer(
                controller: _betterPlayerController,
                key: _betterPlayerKey,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Timer.periodic(
                    await Duration(seconds: 1),(time)async{
                      print(await _betterPlayerController.isPictureInPictureSupported());
                    }
                  );
                  // await OpenPip();

                    // _betterPlayerController
                    //     .enablePictureInPicture(_betterPlayerKey)
                    //     ?.then((value) {
                    //   print("xxxxxxx");
                    // }).catchError((e) {
                    //   print(e);
                    // });
                  
                  await _betterPlayerController
                      .enablePictureInPicture(_betterPlayerKey);
                },
                child: Text("pip")),
            ElevatedButton(
              child: Text("Disable PiP"),
              onPressed: () async {
                print("%%%%%%%%%%%%%%");
                await _betterPlayerController.disablePictureInPicture();
                Timer.periodic(Duration(seconds: 1), (time) {
                  print(_betterPlayerController.isFullScreen);
                });
              },
            ),
          ],
        ));
  }

  List<BetterPlayerDataSource> createDataSet() {
    var dataSourceList = [
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      ),
      // BetterPlayerDataSource(BetterPlayerDataSourceType.network,
      //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
      // BetterPlayerDataSource(BetterPlayerDataSourceType.network,
      //     "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8"),
    ];

    return dataSourceList;
  }
}
