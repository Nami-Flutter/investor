// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sizer/sizer.dart';
//
// const token="007eJxTYNi442FHkucPZhcuWYvytK6JefMXbtWIdb6T497A/jrtzgkFBss0MzMT81RDU4tkc5NUg5TERFMTYwszc9Pk1JRES3Nzb6/LKQ2BjAy7Ll9lYWSAQBCfgyEzryy1uCS/iIEBALxYIZI=";
//
// const id="9f6647e158c74e0daa5438675ceda977";
//
// const  channel="investor";
//
//
// class VideoCall extends StatefulWidget {
//   const VideoCall({Key? key}) : super(key: key);
//
//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }
//
// class _VideoCallState extends State<VideoCall> {
//   @override
//   void initState() {
//     initAgora();
//     super.initState();
//   }
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   bool miceMute = false;
//   late RtcEngine _engine;
//
//   Future<void> initAgora()async{
//     await  [Permission.microphone,Permission.camera].request();
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize( const RtcEngineContext(
//       appId: id,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );
//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();
//
//     await _engine.joinChannel(
//       token: token,
//       channelId: channel,
//       uid: 1,
//       options: const ChannelMediaOptions(),
//     );
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: Center(
//                 child:  _localUserJoined
//                     ? Stack(
//                   children: [
//                     AgoraVideoView(
//                       controller: VideoViewController(
//                         rtcEngine: _engine,
//                         canvas: const VideoCanvas(uid: 0),
//                       ),
//                     ),
//                     Positioned(
//                         top: 0,
//                         child: Container(
//                           height:30.h,
//                           width:30.w ,
//                           color: Colors.black,
//                           child: _remoteVideo(),)),
//                   ],
//                 )
//                     : const CircularProgressIndicator(),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(onPressed: (){
//                   setState(() {
//                     _engine.disableVideo();
//                     _engine.leaveChannel();
//                     _engine.release();
//                     _localUserJoined = false;
//                   });
//                   Navigator.pop(context);
//                 }, icon: Icon(Icons.cancel)),
//                 IconButton(onPressed: (){
//                   setState(() {
//                     miceMute=!miceMute;
//                     _engine.muteLocalVideoStream(miceMute);
//                   });
//                 }, icon: (miceMute)?Icon(Icons.mic_off):Icon(Icons.mic))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection:  RtcConnection(channelId: channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }