import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../models/argument_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../controller/training_prv.dart';

class SignedFormTablet extends StatefulWidget {
  final Arguments arguments;
  const SignedFormTablet({super.key, required this.arguments});

  @override
  State<SignedFormTablet> createState() => _SignedFormTabletState();
}

class _SignedFormTabletState extends State<SignedFormTablet> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          // endDrawer: endDrawer(),
          backgroundColor: Colors.white,
          // appBar: commonAppBar(
          //     onPressed: () => Navigator.pop(context),
          //     backIcon: true,
          //     title: widget.arguments.title,
          //     description: widget.arguments.description),
          body: Consumer<TrainingProvider>(
            builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
                  child: CommonAppBar2(
                      isshowback: true,
                      title: widget.arguments.title,
                      description: widget.arguments.description),
                ),
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
                              padding: EdgeInsets.all(30),
                              children: [
                                Screenshot(
                                  controller: screenshotController,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment(0.8, 0),
                                        child: Image.asset(
                                          "${AppAssets.ic_splash_black}",
                                          height: 80,
                                        ),
                                      ),
                                      h10,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ATTASTATION FORM",
                                            style: FontStyleUtilities.h2(
                                              fontWeight: FWT.semiBold,
                                              fontColor: AppColors.primary,
                                            ),
                                          ),
                                          // h10,
                                          Text(
                                            "ICT SKILLS ACQUISITION FOR TEACHERS",
                                            style: FontStyleUtilities.h5(
                                              fontWeight: FWT.semiBold,
                                              fontColor: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      h30,
                                      Text(
                                        "I hereby attest that I have completed the ICT SKILLS ACQUISITION FOR TEACHERS as well as the office 365 Teacher Academy and Microsoft Innovative Education.",
                                        style: FontStyleUtilities.h5(
                                            fontWeight: FWT.medium),
                                      ),
                                      h20,
                                      Text(
                                        "I have been taught, read and understood the subject areas covered under the training. Thank you.",
                                        style: FontStyleUtilities.h5(
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
                                                "NAME  :",
                                                style: FontStyleUtilities.h5(
                                                    fontWeight: FWT.medium),
                                              ),
                                              w20,
                                              Text(
                                                AppPreference().getString(
                                                    PreferencesKey.uName),
                                                style: FontStyleUtilities.h5(
                                                    fontWeight: FWT.medium),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: AppColors.black,
                                            height: 10,
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
                                                "STAFF ID  :",
                                                style: FontStyleUtilities.h5(
                                                    fontWeight: FWT.medium),
                                              ),
                                              w20,
                                              Text(
                                                AppPreference()
                                                    .getString(
                                                        PreferencesKey.staffId)
                                                    .toString(),
                                                style: FontStyleUtilities.h5(
                                                    fontWeight: FWT.medium),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: AppColors.black,
                                            height: 10,
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
                                                "NAME OF SCHOOL  :",
                                                style: FontStyleUtilities.h5(
                                                    fontWeight: FWT.medium),
                                              ),
                                              w20,
                                              Text(
                                                value.selectedSchoolValue
                                                    .tcSchoolName
                                                    .toString(),
                                                style: FontStyleUtilities.h5(
                                                    fontWeight: FWT.medium),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: AppColors.black,
                                            height: 10,
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
                                                "SIGNATURE  :",
                                                style: FontStyleUtilities.h5(
                                                    fontWeight: FWT.medium),
                                              ),
                                            ],
                                          ),
                                          // h20,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                value.signatureCnt.text,
                                                style: FontStyleUtilities.h1(
                                                        fontWeight: FWT.medium,
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
                                                height: 5,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LargeButton(
                                      height: 50,
                                      borderRadius: BorderRadius.circular(30),
                                      onPressed: () async {
                                        // Get.to(() => CertificateScreen());

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
      print("image file----${value.imageFile}");
      var iosPath =
          "${(await getApplicationDocumentsDirectory()).path}/Download/tlms_form.png";
      var androidPath = "/storage/emulated/0/Download/tlms_form.png";
      File? imgFile;
      if (Platform.isAndroid) {
        imgFile = File(androidPath);
        print("imagefile-----${imgFile}");
      } else if (Platform.isIOS) {
        imgFile = File(iosPath);
        print("imagefile-----${imgFile}");
      }

      imgFile?.writeAsBytes(value.imageFile.value).then((val) async {
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
}
