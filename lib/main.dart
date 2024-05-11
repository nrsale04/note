import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mydailynote/adSystem/models/app_open_ad_manager.dart';
import 'package:mydailynote/awesome_notif.dart';
import 'package:mydailynote/colors%20and%20styles/colors.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:mydailynote/get/getx_controller.dart';
import 'package:mydailynote/language/constant.dart';
import 'package:mydailynote/language/localizationString.dart';
import 'package:mydailynote/language/utils.dart';
import 'package:mydailynote/pages/my_notes.dart';
import 'package:mydailynote/pages/mine.dart';
import 'package:mydailynote/pages/note_page.dart';
import 'package:mydailynote/pages/calendar.dart';
import 'package:mydailynote/pages/gallery.dart';
import 'package:mydailynote/sp.dart';
import 'package:mydailynote/widget/speech.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(MyController());
  MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  List<String> testDeviceIds = ["FBFF1EC9329991BAF2487B871420AC61"];
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  NotificationService.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApptState();
}

final MyController _languageController = Get.put(MyController());
@override
void initState() {
  MiscUtil().getLocale().then((value) {
    switch (value) {
      case Environment.en:
        _languageController.locale.value = const Locale('en', 'US');

        Get.updateLocale(_languageController.locale.value);
        break;
      case Environment.fa:
        _languageController.locale.value = const Locale('fa', 'IR');

        Get.updateLocale(_languageController.locale.value);
        break;

      case Environment.sv:
        _languageController.locale.value = const Locale('sv', 'SV');

        Get.updateLocale(_languageController.locale.value);
        break;

      case Environment.fr:
        _languageController.locale.value = const Locale('fr', 'FR');

        Get.updateLocale(_languageController.locale.value);
        break;
      case Environment.gr:
        _languageController.locale.value = const Locale('gr', 'GR');

        Get.updateLocale(_languageController.locale.value);
        break;
      case Environment.sp:
        _languageController.locale.value = const Locale('sp', 'SP');

        Get.updateLocale(_languageController.locale.value);
        break;
    }
  });
}

class _MyApptState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(white))),
          useMaterial3: true,
        ),
        translations: TranslationService(),
        locale: const Locale('English'),
        debugShowCheckedModeBanner: false,
        home: const Splash());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/home-page';
  @override
  Homepage createState() => Homepage();
}

class Homepage extends State<HomePage> with WidgetsBindingObserver {
  int currentIndex = 0;
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;
  bool checkDialogForce = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Get.put(MyController());
    controller.createRewardAd();
    // forceUpdate().then((value) => ifForceUpdateIsOn());
  }

  void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future<void> ifForceUpdateIsOn() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? storedValue = prefs.getString('versionApp');
  //   bool? noForceUpdate = prefs.getBool('noForceUpdate');
  //   String? actionLink = prefs.getString('actionLink');
  //   if (storedValue != null && storedValue != packageInfo.version) {
  //     if (noForceUpdate != null &&
  //         !noForceUpdate &&
  //         checkDialogForce == false &&
  //         actionLink != null) {
  //       // ignore: use_build_context_synchronously
  //       showDialog(
  //           context: context,
  //           barrierDismissible:
  //               false, // Prevent dialog dismissal by tapping outside

  //           builder: (BuildContext context) {
  //             // این دیالوگ نشون میده که فورث اپدیت قبلا فعال شده و توی لوکال استوریج ذخیره شده و کاربر بعد بستن نرم افزارو و باز کردن مجدد این دیالوگ رو میبینه که نمیتونه ببندتش و بع عبارتی اپ لاک شده تکستها و در صورت نیاز ویدجت دیالوگ اورا وارد بشه
  //             return AlertDialog(
  //                 title: Center(child: Text('Update now'.tr)),
  //                 content: Text(
  //                   'Now you can update the app to the latest version'.tr,
  //                 ), // Now you can new update this app to the latest version.

  //                 actions: [
  //                   Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         SizedBox(
  //                           child: Center(
  //                             child: ElevatedButton(
  //                               onPressed: () async {
  //                                 if (controller.checkConnect) {
  //                                   switch (Platform.operatingSystem) {
  //                                     case 'android':
  //                                       launchURL(actionLink);
  //                                       break;
  //                                     default:
  //                                       launchURL(actionLink);
  //                                       break;
  //                                   }
  //                                 } else {
  //                                   Fluttertoast.showToast(
  //                                       msg: 'Check your connection'.tr,
  //                                       toastLength: Toast.LENGTH_SHORT,
  //                                       gravity: ToastGravity.BOTTOM,
  //                                       timeInSecForIosWeb: 1,
  //                                       backgroundColor: const Color.fromARGB(
  //                                           255, 78, 77, 77));
  //                                 }
  //                                 // SystemNavigator.pop();
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                 backgroundColor: darkred,
  //                                 shadowColor: black,
  //                                 shape: RoundedRectangleBorder(
  //                                     borderRadius:
  //                                         BorderRadius.circular(55.6)),
  //                               ),
  //                               child: Text(
  //                                 'Update'.tr,
  //                                 style: const TextStyle(color: black),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ]),
  //                 ]);
  //           });
  //       setState(() {
  //         checkDialogForce = true;
  //       });
  //     }
  //   }
  // }

  // Future<void> forceUpdate() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   if (controller.myAdDataModel != null &&
  //       controller.myAdDataModel!.updateSystem.activeUpdate) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     saveNewVersionApp(
  //         controller.myAdDataModel!.updateSystem.versionApp, true);
  //     await prefs.setString(
  //         'actionLink', controller.myAdDataModel!.updateSystem.actions);
  //     if (controller.checkConnect) {
  //       if (controller.myAdDataModel!.updateSystem.forceToggleNormalUpdate &&
  //           controller.myAdDataModel!.updateSystem.versionApp !=
  //               packageInfo.version &&
  //           checkDialogForce == false) {
  //         saveNewVersionApp(
  //             controller.myAdDataModel!.updateSystem.versionApp, false);

  //         // ignore: use_build_context_synchronously

  //         // ignore: use_build_context_synchronously
  //         showDialog(
  //             context: context,
  //             barrierDismissible:
  //                 false, // Prevent dialog dismissal by tapping outside

  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                   backgroundColor: white,
  //                   title: Center(
  //                     child: Text(
  //                       controller.myAdDataModel!.updateSystem.title,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   content: Text(
  //                     controller.myAdDataModel!.updateSystem.caption,
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   // Now you can new update this app to the latest version.
  //                   actions: [
  //                     Center(
  //                       child: TextButton(
  //                           onPressed: () async {
  //                             // SystemNavigator.pop();
  //                             switch (Platform.operatingSystem) {
  //                               case 'android':
  //                                 launchURL(controller
  //                                     .myAdDataModel!.updateSystem.actions);
  //                                 break;
  //                               default:
  //                                 launchURL(controller
  //                                     .myAdDataModel!.updateSystem.actions);
  //                                 break;
  //                             }
  //                           },
  //                           child: Text(
  //                             controller.myAdDataModel!.updateSystem.textBtn,
  //                             style: TextStyle(color: black),
  //                             textAlign: TextAlign.center,
  //                           )),
  //                     ),
  //                   ]);
  //             });
  //         setState(() {
  //           checkDialogForce = true;
  //         });
  //       } else {
  //         //ekhtiyari update
  //         if (controller.myAdDataModel!.updateSystem.versionApp !=
  //                 packageInfo.version &&
  //             checkDialogForce == false) {
  //           // این دیالوگ مربوط به اپیدت اختیاری هست و کاربر میتونه دیلوگ رو دیسمیس کنه تایتل و کانتنت رو از دیتابیس میگیره و در صورت نیاز کاستوم دیالوگ استفاده بشه
  //           // ignore: use_build_context_synchronously
  //           showDialog(
  //               context: context,
  //               builder: (BuildContext context) {
  //                 return AlertDialog(
  //                   backgroundColor: white,
  //                   title: Center(
  //                       child: Text(
  //                     'Update'.tr,
  //                     textAlign: TextAlign.center,
  //                   )),
  //                   content: Text(
  //                     'Now you can update the app to the latest version'.tr,
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   actions: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         TextButton(
  //                             onPressed: () async {
  //                               if (controller.checkConnect) {
  //                                 switch (Platform.operatingSystem) {
  //                                   case 'android':
  //                                     launchURL(controller
  //                                         .myAdDataModel!.updateSystem.actions);
  //                                     break;
  //                                   default:
  //                                     launchURL(controller
  //                                         .myAdDataModel!.updateSystem.actions);
  //                                     break;
  //                                 }
  //                               } else {
  //                                 Fluttertoast.showToast(
  //                                     msg: 'Check your connection'.tr,
  //                                     toastLength: Toast.LENGTH_SHORT,
  //                                     gravity: ToastGravity.BOTTOM,
  //                                     timeInSecForIosWeb: 1,
  //                                     backgroundColor: const Color.fromARGB(
  //                                         255, 78, 77, 77));
  //                               }

  //                               Navigator.pop(context);
  //                             },
  //                             child: Text(
  //                               'Update now'.tr,
  //                             )),
  //                         TextButton(
  //                             onPressed: () async {
  //                               Navigator.pop(context);
  //                             },
  //                             child: Text(
  //                               'Mabye later'.tr,
  //                               textAlign: TextAlign.center,
  //                             )),
  //                       ],
  //                     )
  //                   ],
  //                 );
  //               });
  //           setState(() {
  //             checkDialogForce = true;
  //           });
  //         }
  //       }
  //     }
  //   }
  // }

  void saveNewVersionApp(String value, bool noForceUpdate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('versionApp', value);
    await prefs.setBool('noForceUpdate', noForceUpdate);
  }

  final _pages = [
    const MyNote(),
    const Calendar(),
    const Gallery(),
    const Mine()
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: white,
          extendBody: true,
          body: _pages[currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
            child: Container(
              height: size.width * .16,
              width: size.width * .85,
              decoration: BoxDecoration(
                  border: Border.all(color: grey.withOpacity(0.3)),
                  color: white,
                  borderRadius: BorderRadius.circular(10)),
              child: _buildFloatingButton(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotePage(),
                  ));
            },
            child: const Icon(Icons.note_add_outlined),
          )),
    );
  }

  Widget _buildFloatingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavigationButton(
            const Icon(Icons.note, color: darkred), 0, 'MyNote'.tr),
        _buildNavigationButton(
            const Icon(Icons.calendar_today, color: darkred), 1, 'Calendar'.tr),
        _buildNavigationButton(
            const Icon(Icons.browse_gallery, color: darkred), 2, 'Gallery'.tr),
        _buildNavigationButton(
            const Icon(Icons.person, color: darkred), 3, 'Mine'.tr),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildNavigationButton(Icon SvgPicture, int index, String text) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: TextButton(
        onPressed: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: SvgPicture,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: TextStyle(
                  color: currentIndex == index ? darkred : grey,
                  fontFamily: "Vazirmatn-Regular"),
            )
          ],
        ),
      ),
    );
  }
}
