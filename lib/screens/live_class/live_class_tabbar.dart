import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';

import '../../widgets/responsive.dart';

class LiveClassTabbar extends StatefulWidget {
  const LiveClassTabbar({super.key});

  @override
  State<LiveClassTabbar> createState() => _LiveClassTabbarState();
}

class _LiveClassTabbarState extends State<LiveClassTabbar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LiveClassProvider>(
      builder: (context, lcP, child) => SizedBox(
        height: Responsive.isMobile(context) ? 60 : 70,
        child: Padding(
          padding: Responsive.isMobile(context) ? h15v10 : h30v10,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    lcP.tabbarIndex = 0;
                    await lcP.getScheduledLiveClass(
                        bkCategory: "", bkSubCategory: "");
                    lcP.notifyListeners();
                    log(lcP.tabbarIndex.toString());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(
                        BorderSide(
                            color: (lcP.tabbarIndex == 0)
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2),
                      ),
                    ),
                    child: Text("Scheduled",
                        style: Responsive.isMobile(context)
                            ? FontStyleUtilities.h5(
                                fontColor: (lcP.tabbarIndex == 0)
                                    ? AppColors.primary
                                    : AppColors.black)
                            : FontStyleUtilities.h4(
                                fontColor: (lcP.tabbarIndex == 0)
                                    ? AppColors.primary
                                    : AppColors.black)),
                  ),
                ),
              ),
              w12,
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  lcP.tabbarIndex = 1;
                  await lcP.getHistoryLiveClass(
                      bkCategory: "", bkSubCategory: "");
                  lcP.notifyListeners();
                  log(lcP.tabbarIndex.toString());
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(BorderSide(
                          color: (lcP.tabbarIndex == 1)
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2))),
                  child: Text("History",
                      style: Responsive.isMobile(context)
                          ? FontStyleUtilities.h5(
                              fontColor: (lcP.tabbarIndex == 1)
                                  ? AppColors.primary
                                  : AppColors.black)
                          : FontStyleUtilities.h4(
                              fontColor: (lcP.tabbarIndex == 1)
                                  ? AppColors.primary
                                  : AppColors.black)),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
