import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/appeks_inter.dart';
import 'package:mydailynote/colors%20and%20styles/colors.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:mydailynote/loader_t.dart';



import 'package:url_launcher/link.dart';

class OpenAppAdAppeks extends StatefulWidget {
  const OpenAppAdAppeks({super.key});

  @override
  State<OpenAppAdAppeks> createState() => _OpenAppAdAppeksState();
}

class _OpenAppAdAppeksState extends State<OpenAppAdAppeks> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: controller.appeksOpenApp[0].toggleBackgroundImage
                  ? CachedNetworkImage(
                      imageUrl: controller.appeksOpenApp[0].interBackgroundUrl,
                      placeholder: (context, url) => const LoaderT(),
                    )
                  : Container(
                      color:
                          controller.appeksOpenApp[0].backgroundColor.toColor(),
                    )),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: black.withOpacity(.5), blurRadius: 10),
                      ]),
                  height: 25,
                  width: MediaQuery.sizeOf(context).width * .25,
                  child: const Text(
                    'Continue App',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      controller
                                  .
                                  // ignore: unnecessary_null_comparison
                                  appeksOpenApp[0]
                                  .avatarImage !=
                              null
                          ? Container(
                              height: MediaQuery.sizeOf(context).width * .2,
                              width: MediaQuery.sizeOf(context).width * .2,
                              margin: const EdgeInsets.all(10),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      controller.appeksOpenApp[0].avatarImage,
                                  placeholder: (context, url) =>
                                      const LoaderT()),
                            )
                          : const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.appeksOpenApp[0].openAppTitle ?? '',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.appeksOpenApp[0].openAppTitle ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  controller.appeksOpenApp[0].discriptionImage != null
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).width * .8,
                          width: MediaQuery.sizeOf(context).width,
                          child: CachedNetworkImage(
                              imageUrl: controller
                                      .appeksOpenApp[0].discriptionImage ??
                                  '',
                              placeholder: (context, url) => const LoaderT()),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.appeksOpenApp[0].titleCaption ?? '',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.appeksOpenApp[0].interCaption ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller.appeksOpenApp[0].btnText != '' &&
                  controller.appeksOpenApp[0].actionButton != ''
              ? Positioned(
                  bottom: 20,
                  left: MediaQuery.sizeOf(context).width * .3,
                  right: MediaQuery.sizeOf(context).width * .3,
                  child: Link(
                    target: LinkTarget.self,
                    uri: Uri.parse(
                        controller.appeksOpenApp[0].actionButton == ''
                            ? ''
                            : controller.appeksOpenApp[0].actionButton),
                    builder: (context, followLink) => MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: followLink,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              MediaQuery.sizeOf(context).width * .4,
                              MediaQuery.sizeOf(context).width * .1),
                          maximumSize: Size(
                              MediaQuery.sizeOf(context).width * .4,
                              MediaQuery.sizeOf(context).width * .1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: darkred,
                        ),
                        child: Text(
                            controller.myAdDataModel!.appeksOpenAppList[0]
                                        .btnText ==
                                    ''
                                ? ''
                                : controller.myAdDataModel!.appeksOpenAppList[0]
                                    .btnText,
                            style: const TextStyle(
                              fontSize: 22.0,
                              color: white,
                              fontFamily: "vazir",
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
