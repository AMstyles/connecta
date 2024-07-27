// import 'dart:async';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:callkeep/callkeep.dart';
// import 'package:uuid/uuid.dart';
// import 'my_firebase_messaging_service.dart';

// final FlutterCallkeep _callKeep = FlutterCallkeep();
// bool _callKeepInited = false;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  
// }



// class calls extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class Call {
//   Call(this.number);
//   String number;
//   bool held = false;
//   bool muted = false;
// }

// class _MyAppState extends State<calls> {
//   final FlutterCallkeep _callKeep = FlutterCallkeep();
//   Map<String, Call> calls = {};
//   String newUUID() => Uuid().v4();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   void iOS_Permission() {
//     _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   void removeCall(String callUUID) {
//     setState(() {
//       calls.remove(callUUID);
//     });
//   }

//   void setCallHeld(String callUUID, bool held) {
//     setState(() {
//       calls[callUUID]?.held = held;
//     });
//   }

//   void setCallMuted(String callUUID, bool muted) {
//     setState(() {
//       calls[callUUID]?.muted = muted;
//     });
//   }

//   Future<void> answerCall(CallKeepPerformAnswerCallAction event) async {
//     final String? callUUID = event.callUUID;
//     final String number = calls[callUUID]!.number;
//     print('[answerCall] $callUUID, number: $number');
//     Timer(const Duration(seconds: 1), () {
//       print('[setCurrentCallActive] $callUUID, number: $number');
//       _callKeep.setCurrentCallActive(callUUID!);
//     });
//   }

//   Future<void> endCall(CallKeepPerformEndCallAction event) async {
//     print('endCall: ${event.callUUID}');
//     removeCall(event.callUUID!);
//   }

//   Future<void> didPerformDTMFAction(CallKeepDidPerformDTMFAction event) async {
//     print('[didPerformDTMFAction] ${event.callUUID}, digits: ${event.digits}');
//   }

//   Future<void> didReceiveStartCallAction(
//       CallKeepDidReceiveStartCallAction event) async {
//     if (event.handle == null) {
//       return;
//     }
//     final String callUUID = event.callUUID ?? newUUID();
//     setState(() {
//       calls[callUUID] = Call(event.handle!);
//     });
//     print('[didReceiveStartCallAction] $callUUID, number: ${event.handle}');

//     _callKeep.startCall(callUUID, event.handle!, event.handle!);

//     Timer(const Duration(seconds: 1), () {
//       print('[setCurrentCallActive] $callUUID, number: ${event.handle}');
//       _callKeep.setCurrentCallActive(callUUID);
//     });
//   }

//   Future<void> didPerformSetMutedCallAction(
//       CallKeepDidPerformSetMutedCallAction event) async {
//     final String number = calls[event.callUUID]?.number ?? '';
//     print(
//         '[didPerformSetMutedCallAction] ${event.callUUID}, number: $number (${event.muted})');

//     setCallMuted(event.callUUID!, event.muted!);
//   }

//   Future<void> didToggleHoldCallAction(
//       CallKeepDidToggleHoldAction event) async {
//     final String number = calls[event.callUUID]?.number ?? '';
//     print(
//         '[didToggleHoldCallAction] ${event.callUUID}, number: $number (${event.hold})');

//     setCallHeld(event.callUUID!, event.hold!);
//   }

//   Future<void> hangup(String callUUID) async {
//     _callKeep.endCall(callUUID);
//     removeCall(callUUID);
//   }

//   Future<void> setOnHold(String callUUID, bool held) async {
//     _callKeep.setOnHold(callUUID, held);
//     final String handle = calls[callUUID]?.number ?? '';
//     print('[setOnHold: $held] $callUUID, number: $handle');
//     setCallHeld(callUUID, held);
//   }

//   Future<void> setMutedCall(String callUUID, bool muted) async {
//     _callKeep.setMutedCall(callUUID, muted);
//     final String handle = calls[callUUID]?.number ?? '';
//     print('[setMutedCall: $muted] $callUUID, number: $handle');
//     setCallMuted(callUUID, muted);
//   }

//   Future<void> updateDisplay(String callUUID) async {
//     final String number = calls[callUUID]?.number ?? '';
//     if (Platform.isIOS) {
//       _callKeep.updateDisplay(callUUID, displayName: 'New Name', handle: number);
//     } else {
//       _callKeep.updateDisplay(callUUID, displayName: number, handle: 'New Name');
//     }

//     print('[updateDisplay: $number] $callUUID');
//   }

//   Future<void> displayIncomingCallDelayed(String number) async {
//     Timer(const Duration(seconds: 3), () {
//       displayIncomingCall(number);
//     });
//   }

//   Future<void> displayIncomingCall(String number) async {
//     final String callUUID = newUUID();
//     setState(() {
//       calls[callUUID] = Call(number);
//     });
//     print('Display incoming call now');
//     final bool hasPhoneAccount = await _callKeep.hasPhoneAccount();
//     if (!hasPhoneAccount) {
//       await _callKeep.hasDefaultPhoneAccount(context, <String, dynamic>{
//         'alertTitle': 'Permissions required',
//         'alertDescription': 'This application needs to access your phone accounts',
//         'cancelButton': 'Cancel',
//         'okButton': 'ok',
//         'foregroundService': {
//           'channelId': 'com.company.my',
//           'channelName': 'Foreground service for my app',
//           'notificationTitle': 'My app is running on background',
//           'notificationIcon': 'Path to the resource icon of the notification',
//         },
//       });
//     }

//     print('[displayIncomingCall] $callUUID number: $number');
//     _callKeep.displayIncomingCall(callUUID, number,
//         handleType: 'number', hasVideo: false);
//   }

//   void didDisplayIncomingCall(CallKeepDidDisplayIncomingCall event) {
//     var callUUID = event.callUUID;
//     var number = event.handle;
//     print('[displayIncomingCall] $callUUID number: $number');
//     setState(() {
//       calls[callUUID!] = Call(number!);
//     });
//   }

//   void onPushKitToken(CallKeepPushKitToken event) {
//     print('[onPushKitToken] token => ${event.token}');
//   }

//   @override
//   void initState() {
//     super.initState();
//     _callKeep.on(CallKeepDidDisplayIncomingCall(), didDisplayIncomingCall);
//     _callKeep.on(CallKeepPerformAnswerCallAction(), answerCall);
//     _callKeep.on(CallKeepDidPerformDTMFAction(), didPerformDTMFAction);
//     _callKeep.on(CallKeepDidReceiveStartCallAction(), didReceiveStartCallAction);
//     _callKeep.on(CallKeepDidToggleHoldAction(), didToggleHoldCallAction);
//     _callKeep.on(CallKeepDidPerformSetMutedCallAction(), didPerformSetMutedCallAction);
//     _callKeep.on(CallKeepPerformEndCallAction(), endCall);
//     _callKeep.on(CallKeepPushKitToken(), onPushKitToken);

//     _callKeep.setup(context, <String, dynamic>{
//       'ios': {
//         'appName': 'CallKeepDemo',
//       },
//       'android': {
//         'alertTitle': 'Permissions required',
//         'alertDescription': 'This application needs to access your phone accounts',
//         'cancelButton': 'Cancel',
//         'okButton': 'ok',
//         'foregroundService': {
//           'channelId': 'com.company.my',
//           'channelName': 'Foreground service for my app',
//           'notificationTitle': 'My app is running on background',
//           'notificationIcon': 'Path to the resource icon of the notification',
//         },
//       },
//     });

//     if (Platform.isAndroid) {
//       _firebaseMessaging.getToken().then((token) {
//         print('[FCM] token => $token');
//       });

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print('onMessage: $message');
//         if (message.data.isNotEmpty) {
//           var payload = message.data;
//           var callerId = payload['caller_id'] as String;
//           var callerName = payload['caller_name'] as String;
//           var uuid = payload['uuid'] as String;
//           var hasVideo = payload['has_video'] == "true";
//           final callUUID = uuid ?? Uuid().v4();
//           setState(() {
//             calls[callUUID] = Call(callerId);
//           });
//           _callKeep.displayIncomingCall(callUUID, callerId,
//               localizedCallerName: callerName, hasVideo: hasVideo);
//         }
//       });

//       FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         print('onLaunch: $message');
//       });

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print('onResume: $message');
//       });
//     }
//   }

//   Widget buildCallingWidgets() {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: calls.entries
//             .map((MapEntry<String, Call> item) => Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('number: ${item.value.number}'),
//                   Text('uuid: ${item.key}'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: () async {
//                           setOnHold(item.key, !item.value.held);
//                         },
//                         child: Text(item.value.held ? 'Unhold' : 'Hold'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           updateDisplay(item.key);
//                         },
//                         child: const Text('Display'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           setMutedCall(item.key, !item.value.muted);
//                         },
//                         child: Text(item.value.muted ? 'Unmute' : 'Mute'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           hangup(item.key);
//                         },
//                         child: const Text('Hangup'),
//                       ),
//                     ],
//                   )
//                 ]))
//             .toList());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   displayIncomingCall('10086');
//                 },
//                 child: const Text('Display incoming call now'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   displayIncomingCallDelayed('10086');
//                 },
//                 child: const Text('Display incoming call now in 3s'),
//               ),
//               buildCallingWidgets()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
