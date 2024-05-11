import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mydailynote/colors%20and%20styles/colors.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BannerAppeks extends StatefulWidget {
  const BannerAppeks({
    super.key,
  });

  @override
  State<BannerAppeks> createState() => _BannerAppeksState();
}

class _BannerAppeksState extends State<BannerAppeks> {
  @override
  void initState() {
    super.initState();
  }

  void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return controller.myAdDataModel != null
        ? GestureDetector(
            onTap: () {
              launchURL(controller
                  .myAdDataModel!.appeksNativeList[0].nativeActionUrl);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: black.withOpacity(.2), blurRadius: 10),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(children: [
                        const SizedBox(width: 5),
                        controller.myAdDataModel!.appeksNativeList[0]
                                    .nativeAvatarUrl !=
                                ''
                            ? Container(
                                height: 54,
                                width: 54,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(controller
                                            .myAdDataModel!
                                            .appeksNativeList[0]
                                            .nativeAvatarUrl))),
                              )
                            : const SizedBox(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.myAdDataModel!.appeksNativeList[0]
                                          .nativeTitle ??
                                      '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  controller.myAdDataModel!.appeksNativeList[0]
                                          .nativeCaption ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      height: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 10,
                                      color: black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        controller.myAdDataModel!.appeksNativeList[0]
                                    .nativeTextBtn !=
                                ''
                            ? ElevatedButton(
                                onPressed: () {
                                  switch (Platform.operatingSystem) {
                                    case 'android':
                                      launchURL(controller.myAdDataModel!
                                          .appeksNativeList[0].nativeActionUrl);

                                      break;
                                    //for ios must be fixed

                                    default:
                                      launchURL(controller.myAdDataModel!
                                          .appeksNativeList[0].nativeActionUrl);
                                      break;
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(60, 25),
                                    maximumSize: const Size(60, 25),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: darkred,
                                    padding: const EdgeInsets.all(0)),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    controller.myAdDataModel!
                                        .appeksNativeList[0].nativeTextBtn,
                                    style: const TextStyle(
                                        fontSize: 12, color: white),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 5),
                      ]),
                    ),
                  )),
            ),
          )
        : Container();
  }
}
