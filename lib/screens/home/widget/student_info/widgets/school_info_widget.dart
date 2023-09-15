import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';

class SchoolInfoWidget extends StatelessWidget {
  const SchoolInfoWidget({
    Key? key,
    required this.schoolImage,
    required this.schoolName,
    required this.schoolAddress,
    required this.schoolContact,
  }) : super(key: key);

  final String? schoolImage;
  final String? schoolName;
  final String? schoolAddress;
  final String? schoolContact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(
              backgroundImage:
              CachedNetworkImageProvider("$schoolImage"),
              radius: 27),
          w24,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: Translator().translate("${schoolName}"),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? "${snapshot.data}"
                          : "${schoolName}",
                      style:
                      FontStyleUtilities.h6(fontWeight: FWT.medium),
                    );
                  }),
              FutureBuilder(
                  future: Translator().translate("${schoolAddress}"),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? "${snapshot.data}"
                          : "${schoolAddress}",
                      style: FontStyleUtilities.t2(
                          fontColor: AppColors.grey500),
                    );
                  }),
              Text("$schoolContact",
                  style: FontStyleUtilities.t2(
                      fontColor: AppColors.grey500)),
            ],
          ),
        ],
      ),
    );
  }
}