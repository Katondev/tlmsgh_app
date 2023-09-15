import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';

class EventItem extends StatelessWidget {
  final String? date;
  final String? title;
  final String? desc;
  final Color? backgroundColor;
  final Color? fontColor;

  const EventItem(
      {Key? key,
      this.title,
      this.desc,
      this.date,
      this.backgroundColor,
      this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 212.w,
      padding: h18v10,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: cr12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: Translator().translate("${date}"),
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData ? "${snapshot.data}" : "${date}",
                style: FontStyleUtilities.t4(fontColor: fontColor),
              );
            },
          ),
          h6,
          FutureBuilder(
            future: Translator().translate("${title}"),
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData ? "${snapshot.data}" : "${title}",
                style: FontStyleUtilities.t3(
                    fontWeight: FWT.medium, fontColor: fontColor),
              );
            },
          ),
          if (desc != null) h6,
          if (desc != null)
            FutureBuilder(
              future: Translator().translate("${desc}"),
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? "${snapshot.data}" : "${desc}",
                  style: FontStyleUtilities.t6(fontColor: fontColor),
                );
              },
            ),
        ],
      ),
    );
  }
}
