import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/global_singlton.dart';
import 'package:katon/widgets/custom_dialog.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:native_video_view/native_video_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../home_page.dart';

class Video extends StatefulWidget {
  const Video({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  String? dirPath;
  bool loading = false;
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  Future load_path_video() async {
    loading = true;
    //final Directory extDir = await getApplicationDocumentsDirectory();
    // var tempDir = await getTemporaryDirectory();
    var tempDir = await getApplicationDocumentsDirectory();
// .split("/").last
    dirPath = '${tempDir.path}/${widget.title}';
    bool exists = await File(dirPath!).exists();
    log("video exists----->${exists}");
    
    // print(dirPath);

    loading = false;
    setState(() {});
    getVideo();
  }

  bool isFullScape = false;
  RxBool isShowControls = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    load_path_video();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    super.initState();
  }

  getVideo() async {
    log("videopath------->>------${widget.title!}");

    // videoPlayerController = VideoPlayerController.file(File(widget.title!));

    
videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        '${ApiRoutes.imageURL}${widget.title!}'));
   
//  videoPlayerController = VideoPlayerController.file(
//         File("${GlobalSingleton().Dirpath}/${widget.title?.split("/").last}"));
    
   
      
        
   
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.size.aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      allowFullScreen: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    chewieController!.dispose();
    videoPlayerController.dispose();
    // if (Responsive.isMobile(context)) {
    //   SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    //   );
    // } else {
    //   SystemChrome.setPreferredOrientations(
    //       [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    // }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Responsive.isMobilenew(context)) {
          log("mobile view");
          SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
          );
          Navigator.of(context).pop();
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft
          ]);
          Navigator.of(context).pop();
        }
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
            overlays: []);

        return false;
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Orientation currentOrientation =
                        MediaQuery.of(context).orientation;

                    if (currentOrientation == Orientation.landscape) {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                    } else {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    }

                    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
                    //     overlays: []);
                  },
                  heroTag: "1",
                  child: const Icon(
                    Icons.fullscreen,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (Responsive.isMobilenew(context)) {
                      SystemChrome.setPreferredOrientations(
                        [
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.portraitUp
                        ],
                      );
                    } else {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeRight,
                        DeviceOrientation.landscapeLeft
                      ]);
                    }
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
                        overlays: []);
                    Navigator.of(context).pop();
                  },
                  heroTag: "2",
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          body: loading
              ? const CircularProgressIndicator()
              : _buildVideoPlayerWidget(widget.title!),
        ),
      ),
    );
  }

  Widget _buildVideoPlayerWidget(String path) {
    return Column(
      children: [
        Expanded(
            child: (chewieController == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Chewie(controller: chewieController!)

            // child: NativeVideoView(
            //   showMediaController: true,
            //   enableVolumeControl: true,
            //   onCreated: (controller) {
            //     controller.setVideoSource(
            //       path,
            //       sourceType: VideoSourceType.network,
            //       requestAudioFocus: true,
            //     );
            //   },
            //   onPrepared: (controller, info) {
            //     debugPrint('NativeVideoView: Video prepared');
            //     controller.play();
            //   },
            //   onError: (controller, what, extra, message) {
            //     debugPrint(
            //         'NativeVideoView: Player Error ($what | $extra | $message)');
            //   },
            //   onCompletion: (controller) {
            //     debugPrint('NativeVideoView: Video completed');
            //   },
            // ),
            ),
      ],
    );
  }
}
