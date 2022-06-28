import 'dart:async';
import 'dart:html';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'chat_screen.dart';
import 'group_chat_screen.dart';

const appId = "c3ff506b3e894f05850712bdade6cc8e";
const token =
    "006c3ff506b3e894f05850712bdade6cc8eIADCLFBKvZqN9kbz/s7z/o0wb7npAnTLrMLQ61Y+6sUwQ7nYDM0AAAAAEACJVdSD1G+7YgEAAQDUb7ti";
const channel = "EA";

class VideoCallScreen extends StatefulWidget {
  final String username;

  const VideoCallScreen({
    Key? key,
    required this.username,
  }) : super(key: key);
  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  int? _remoteUid;
  late RtcEngine _engine;
  bool isJoined = false, switchCamera = true, openMicrophone = true;
  bool _isRenderSurfaceView = false;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channel);
    initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = true;
    });
  }

  _switchCamera() async {
    if (!switchCamera) _engine.enableLocalVideo(false);

    /*setState(() {
        switchCamera = !switchCamera;
      });*/
  }

  _switchMicrophone() async {
    // await _engine.muteLocalAudioStream(!openMicrophone);
    if (!openMicrophone) _engine.enableLocalAudio(false);
    /*await _engine.enableLocalAudio(!openMicrophone).then((value) {
      _engine.disableAudio();
      /*setState(() {
        openMicrophone = !openMicrophone;
      });*/
    }).catchError((err) {
      //logSink.log('enableLocalAudio $err');
    });*/
  }

  Future<void> initAgora() async {
    //await window.navigator.getUserMedia(audio: true, video: true);
    //create the engine
    _engine = await RtcEngine.create(appId);

    await _engine.enableAudio();
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            isJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(token, channel, null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 150,
              child: Center(
                child: isJoined
                    ? RtcLocalView.SurfaceView()
                    : CircularProgressIndicator(),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
              alignment: Alignment(0.5, 0.8),
              child: SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: _switchMicrophone,
                    child: const Icon(
                      Icons.mic_none_outlined,
                      size: 20,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(width: 50), // give it width
            Align(
              alignment: Alignment(0.5, 0.8),
              child: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Color.fromARGB(255, 255, 58, 58),
                    onPressed: () {
                      _leaveChannel();
                      final route = MaterialPageRoute(
                          builder: (context) => GroupChatScreen(
                              username: widget.username)); //Canviar a Signup
                      Navigator.push(context, route);
                    },
                    mini: true,
                    child: const Icon(Icons.phone_disabled_outlined, size: 20)),
              ),
            ),
            SizedBox(width: 50), // give it width
            Align(
              alignment: Alignment(0.5, 0.8),
              child: SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: _switchCamera,
                    child: const Icon(Icons.video_camera_front_outlined,
                        size: 20)),
              ),
            ),
          ])
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: channel,
      );
    } else {
      return Text(
        'Please wait for another user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}