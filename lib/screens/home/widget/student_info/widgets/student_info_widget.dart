import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';

class StudentInfoWidget extends StatelessWidget {
  final String? studentImage;
  final String? studentName;
  final String? classDetails;
  final String? schoolRollNO;
  const StudentInfoWidget(
      {Key? key,
      this.studentImage,
      this.studentName,
      this.classDetails,
      this.schoolRollNO})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: cr50,
            child: CachedNetworkImage(
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              imageUrl: studentImage.toString(),
              errorWidget: (context, url, error) => Image.asset(
                  Images.walkThrough,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover),
            ),
          ),
          w24,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: Translator().translate("${studentName}"),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData ? "${snapshot.data}" : "${studentName}",
                      style: FontStyleUtilities.h6(fontWeight: FWT.medium),
                    );
                  }),
              FutureBuilder(
                  future: Translator().translate("${classDetails}"),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData ? "${snapshot.data}" : "${classDetails}",
                      style:
                          FontStyleUtilities.t2(fontColor: AppColors.grey500),
                    );
                  }),
              Text("$schoolRollNO",
                  style: FontStyleUtilities.t2(fontColor: AppColors.grey500)),
            ],
          ),
        ],
      ),
    );
  }
}
