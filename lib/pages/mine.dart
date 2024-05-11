import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:numberpicker/numberpicker.dart';

class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _Page1State();
}

class _Page1State extends State<Mine> {
  // bool isSelected = true;
  // bool isNotificationActive = false;
  // int? dropdownValueDisease;
  // int? selectHour;
  // int? selectMin;
  void scheduleNotification(
    int hour,
    int minute,
  ) {
    final schedule =
        NotificationCalendar(hour: hour, minute: minute, repeats: true);
    final notification = NotificationContent(
        id: 1,
        channelKey: 'scheduled_channel',
        body: "Hey,it's time to workout!",
        color: Colors.grey);
    AwesomeNotifications().createNotification(
      content: notification,
      schedule: schedule,
    );
    print('sali 54 $schedule');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Text(
                'Mine',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Container(
                height: size.width * .3,
                width: size.width * .9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2), blurRadius: 20),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NumberPicker(
                            minValue: 0,
                            maxValue: 23,
                            value: controller.hour.value,
                            zeroPad: true,
                            infiniteLoop: true,
                            itemWidth: 20,
                            itemHeight: 20,
                            onChanged: (set) {
                              setState(() {
                                controller.hour.value = set;
                                // _saveDataHour(controller.hour.value);
                                // GlobalVar.hour = GlobalVar.hour;
                              });
                            },
                            textStyle: const TextStyle(
                                fontSize: 15, color: Color(0xFF8F8E8E)),
                            selectedTextStyle: const TextStyle(
                                fontSize: 15, color: Colors.black),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Color(0xFF8F8E8E)),
                                    bottom:
                                        BorderSide(color: Color(0xFF8F8E8E)))),
                          ),
                          const Text(':'),
                          NumberPicker(
                            minValue: 0,
                            maxValue: 59,
                            value: controller.minute.value,
                            zeroPad: true,
                            infiniteLoop: true,
                            itemWidth: 20,
                            itemHeight: 20,
                            onChanged: (set) {
                              setState(() {
                                controller.minute.value = set;

                                // _saveDataMin(controller.minute.value);
                                // GlobalVar.minute = setMin;
                              });
                            },
                            textStyle: const TextStyle(
                                fontSize: 15, color: Color(0xFF8F8E8E)),
                            selectedTextStyle: const TextStyle(
                                fontSize: 15, color: Colors.black),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: Color(0xFF8F8E8E)),
                                    bottom:
                                        BorderSide(color: Color(0xFF8F8E8E)))),
                          ),
                          const Text(
                            '',
                            // '${controller.reminders[index].hour}:${controller.reminders[index].minute.toString().padLeft(2, '0')}',
                            style:
                                // controller.reminders[index].repeat == true
                                //     ? const TextStyle(
                                //         fontSize: 30,
                                //         fontFamily: "VazirBold",
                                //       )
                                //     :
                                TextStyle(
                              fontSize: 30,
                              color: Colors.grey,
                              fontFamily: "VazirBold",
                            ),
                          ),
                          FlutterSwitch(
                            height: 22.0,
                            width: 37.0,
                            padding: 2.0,
                            toggleSize: 19.0,
                            borderRadius: 30.0,
                            inactiveColor: Colors.grey,
                            activeColor: Colors.red,
                            value: controller.repeat.value,
                            onToggle: (value) {
                              setState(() {
                                controller.repeat.value = value;
                                controller.repeat.value == true
                                    ? scheduleNotification(
                                        controller.hour.value,
                                        controller.minute.value,
                                      )
                                    : AwesomeNotifications()
                                        .cancelAllSchedules();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Repeat: Daily',
                          // style: controller.isSelected.value == true
                          //     ? Styles.tiny
                          //     : Styles.tinyGrey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
