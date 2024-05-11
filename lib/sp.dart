import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydailynote/adSystem/models/app_open_ad_manager.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/openApp.dart';
import 'package:mydailynote/colors%20and%20styles/colors.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:mydailynote/main.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool checkConnect = false;
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    asyncFunctions().whenComplete(() {
      _checkFirstRun();
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  Future<void> asyncFunctions() async {
    controller.checkConection();
    try {
      controller.myAdDataModel = await controller.fetchModels();

      // ignore: empty_catches
    } catch (e) {
      print('rrrrrrr${e.toString()}');
    }
  }

  void _checkFirstRun() async {

    appOpenAdManager.loadAd();
    Future.delayed(const Duration(milliseconds: 400)).then((value) {

      if (controller.myAdDataModel != null) {
        if (controller.myAdDataModel!.showAdmob == true &&
            controller.myAdDataModel!.openAppList[0].showOpenApp == true) {
          appOpenAdManager.showAdIfAvailable();
        } else if (controller.myAdDataModel!.showAdAppeks == true &&
            controller.myAdDataModel!.appeksInterList[0].showAppeksInter ==
                true) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OpenAppAdAppeks()));
        }
      }
    });
    route();
  }

 void route() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Splash',
                style: TextStyle(
                  fontSize: 40,
                  color: black,
                  shadows: [
                    Shadow(
                      color: black,
                      blurRadius: 1.0,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
              const Text(
                'Ad system',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w300, color: black),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 10,
                width: 200,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(5),
                      color: red,
                      value: _animation.value,
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
