import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../models/argument_model.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import 'package:path_provider/path_provider.dart';

class SignedFormMobile extends StatefulWidget {
  final Arguments arguments;
  const SignedFormMobile({super.key, required this.arguments});

  @override
  State<SignedFormMobile> createState() => _SignedFormMobileState();
}

class _SignedFormMobileState extends State<SignedFormMobile> {
  static GlobalKey previewContainer = new GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<TrainingProvider>(
            builder: (context, value, child) => Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: CommonAppBar2(
                      title: "Training",
                      description: widget.arguments.title,
                      isshowback: true,
                    )),
                ConnectionWidget.connection,
                value.connection
                    ? Expanded(
                        child: NoInternet(onTap: () => value.getAllTrainings()))
                    : value.trainingdetailModel == null ||
                            value.trainingdetailModel?.data?.content?.length ==
                                0
                        ? Expanded(
                            child: NoDataFound(message: "no_data_found".tr))
                        : Expanded(
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                Screenshot(
                                  controller: screenshotController,
                                  child: Container(
                                    color: AppColors.primaryWhite,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment(0.8, 0),
                                          child: Image.asset(
                                            "${AppAssets.ic_splash_black}",
                                            height: 60,
                                          ),
                                        ),
                                        h30,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ATTASTATION FORM",
                                              style: FontStyleUtilities.h4(
                                                fontWeight: FWT.semiBold,
                                                fontColor: AppColors.primary,
                                              ),
                                            ),
                                            // h10,
                                            Text(
                                              "ICT SKILLS ACQUISITION FOR TEACHERS",
                                              style: FontStyleUtilities.t1(
                                                fontWeight: FWT.semiBold,
                                                fontColor: AppColors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        h30,
                                        Text(
                                          "I hereby attest that I have completed the ICT SKILLS ACQUISITION FOR TEACHERS as well as the office 365 Teacher Academy and Microsoft Innovative Education.",
                                          style: FontStyleUtilities.t1(
                                              fontWeight: FWT.medium),
                                        ),
                                        h20,
                                        Text(
                                          "I have been taught, read and understood the subject areas covered under the training. Thank you.",
                                          style: FontStyleUtilities.t1(
                                              fontWeight: FWT.medium),
                                        ),
                                        h30,
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "NAME :",
                                                  style: FontStyleUtilities.t1(
                                                      fontWeight: FWT.medium),
                                                ),
                                                w10,
                                                Text(
                                                  AppPreference().getString(
                                                      PreferencesKey.uName),
                                                  style: FontStyleUtilities.t1(
                                                      fontWeight: FWT.medium),
                                                ),
                                              ],
                                            ),
                                            h6,
                                            Divider(
                                              color: AppColors.black,
                                              height: 5,
                                              thickness: 1,
                                            ),
                                          ],
                                        ),
                                        h10,
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "STAFF ID :",
                                                  style: FontStyleUtilities.t1(
                                                      fontWeight: FWT.medium),
                                                ),
                                                w10,
                                                Text(
                                                  "${AppPreference().getString(PreferencesKey.staffId).toString()}",
                                                  style: FontStyleUtilities.t1(
                                                      fontWeight: FWT.medium),
                                                ),
                                              ],
                                            ),
                                            h6,
                                            Divider(
                                              color: AppColors.black,
                                              height: 5,
                                              thickness: 1,
                                            ),
                                          ],
                                        ),
                                        h10,
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "NAME OF SCHOOL :",
                                                  style: FontStyleUtilities.t1(
                                                      fontWeight: FWT.medium),
                                                ),
                                                w10,
                                                Text(
                                                  value.selectedSchoolValue
                                                      .tcSchoolName
                                                      .toString(),
                                                  style: FontStyleUtilities.t1(
                                                      fontWeight: FWT.medium),
                                                ),
                                              ],
                                            ),
                                            h6,
                                            Divider(
                                              color: AppColors.black,
                                              height: 5,
                                              thickness: 1,
                                            ),
                                          ],
                                        ),
                                        h10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "SIGNATURE :",
                                              style: FontStyleUtilities.t1(
                                                  fontWeight: FWT.medium),
                                            ),
                                            h6,
                                            Column(
                                              children: [
                                                Text(
                                                  value.signatureCnt.text,
                                                  style: FontStyleUtilities.h4(
                                                          fontWeight:
                                                              FWT.medium,
                                                          fontColor:
                                                              AppColors.primary)
                                                      .copyWith(
                                                          fontFamily: value
                                                                  .signatureFontfamily[
                                                              value
                                                                  .selectedSign]),
                                                ),
                                                Divider(
                                                  color: AppColors.black,
                                                  height: 10,
                                                  thickness: 1,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        h30,
                                        Image.asset(
                                            "assets/images/signform_logo.jpg"),
                                        h30,
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LargeButton(
                                      height: 50,
                                      borderRadius: BorderRadius.circular(30),
                                      onPressed: () async {
                                        // Get.to(()=>CertificateScreen());
                                        captureScreenshot(value);
                                        // await value.generateSignedForm(context);
                                      },
                                      child: Text(
                                        "Submit",
                                        style: FontStyleUtilities.t1(
                                            fontWeight: FWT.semiBold,
                                            fontColor: AppColors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                h20,
                              ],
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void captureScreenshot(TrainingProvider value) {
    screenshotController.capture().then((Uint8List? image) async {
      //Capture Done

      value.imageFile.value = image!;
      print("image file----${value.imageFile.value}");
      var iosPath = await getApplicationDocumentsDirectory();
      final filePath = "${iosPath.path}/tlms_form.png";
      var androidPath = "/storage/emulated/0/Download/tlms_form.png";
      File? imgFile;
      if (Platform.isAndroid) {
        imgFile = File(androidPath);
        log("imagefile----1-${imgFile}---");
      } else if (Platform.isIOS) {
        imgFile = File(filePath);
        log("imagefile----2-${imgFile}---");
      }
      // = new File('/storage/emulated/0/Download/tlms_form.png');

      await imgFile?.writeAsBytes(value.imageFile.value).then((val) async {
        print("message------${val}");
        value.downloadForm = val;
        await value.convertImageToPDF().whenComplete(() async {
          await value.generateSignedForm(context);
        });
        // await value.setImageInFile();
      }).catchError((onError) {
        print(onError);
      });
      setState(() {});
    });
  }

  void takeScreenshot() {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5);
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      log("$directory");
      File imgFile = new File('/storage/emulated/0/Download/screenshot.png');
      imagePaths.add(imgFile.path);
      log("$imagePaths");
      imgFile.writeAsBytes(pngBytes).then((value) async {
        // await Share.shareFiles(imagePaths,
        //     subject: 'Share',
        //     text: 'Check this Out!',
        //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {
        print(onError);
      });
    });
  }
}
