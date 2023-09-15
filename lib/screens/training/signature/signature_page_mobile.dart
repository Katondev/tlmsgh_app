import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/utils/Routes/teacher_route_arguments.dart';
import 'package:katon/utils/app_binding.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/text_field.dart';
import 'package:provider/provider.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';

class SignatureMobile extends StatefulWidget {
  final Arguments arguments;
  const SignatureMobile({super.key, required this.arguments});

  @override
  State<SignatureMobile> createState() => _SignatureMobileState();
}

class _SignatureMobileState extends State<SignatureMobile> {
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
                    isshowback: true,
                    title: "Training",
                    description: "${widget.arguments.title}",
                  ),
                ),
                ConnectionWidget.connection,
                value.value
                    ? Expanded(child: Loader(message: "loading_wait".tr))
                    : value.connection
                        ? Expanded(
                            child: NoInternet(
                                onTap: () => value.getAllTrainings()))
                        : value.trainingdetailModel == null ||
                                value.trainingdetailModel?.data?.content
                                        ?.length ==
                                    0
                            ? Expanded(
                                child: NoDataFound(message: "no_data_found".tr))
                            : Expanded(
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(20),
                                  children: [
                                    Text(
                                      "Signature",
                                      style: FontStyleUtilities.h4(
                                          fontWeight: FWT.medium,
                                          fontColor: AppColors.primary),
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextBox(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textInputAction:
                                                TextInputAction.next,
                                            hint: 'Enter your name',
                                            controller: value.signatureCnt,
                                            // onChanged: (val) {},
                                            onSubmitted: (val) {
                                              FocusScope.of(context).unfocus();
                                              log("hello");
                                            },
                                          ),
                                        ),
                                        w10,
                                        textButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();

                                            value.signatureVal =
                                                value.signatureCnt.text;
                                            // value.notifyListeners();
                                          },
                                          height: 50,
                                          child: Text(
                                            "Change",
                                            style: FontStyleUtilities.t1(
                                                fontWeight: FWT.semiBold,
                                                fontColor: AppColors.white),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ],
                                    ),
                                    h30,
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30),
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        childAspectRatio: 1,
                                        maxCrossAxisExtent: 200,
                                        mainAxisExtent: 100,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemBuilder: (context, i) {
                                        var data = value.signatureFontfamily[i];
                                        return GestureDetector(
                                          onTap: () {
                                            value.selectedSign = i;
                                            value.notifyListeners();
                                          },
                                          child: Container(
                                            // color: i == 7 ? AppColors.appbarRed : AppColors.blue,
                                            margin: EdgeInsets.all(3),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.grey,
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                ),
                                              ],
                                              border: (value.selectedSign == i)
                                                  ? Border.all(
                                                      color: AppColors.primary,
                                                      width: 2)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${value.signatureVal}",
                                              style: FontStyleUtilities.h4(
                                                      fontWeight: FWT.regular,
                                                      fontColor:
                                                          AppColors.black)
                                                  .copyWith(fontFamily: data),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          value.signatureFontfamily.length,
                                    ),
                                    h20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        LargeButton(
                                          height: 50,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              RoutesConst.trainingSignedform,
                                              arguments: TeacherRouteArguments()
                                                  .getTeacherArgument(
                                                      RoutesConst
                                                          .trainingSignedform),
                                            );
                                          },
                                          child: Text(
                                            "Next",
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
}
