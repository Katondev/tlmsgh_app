import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/exam_result.dart';
import 'package:katon/screens/exam_result/widgets/circular_processer.dart';
import 'package:katon/utils/config.dart';

class ExamTable extends StatelessWidget {
  final Color? color;
  final String? text;
  final Color circleColor;
  final Color strokeColor;
  final double? processPercentage;

  const ExamTable(
      {Key? key,
      this.color,
      this.text,
      this.processPercentage,
      required this.circleColor,
      required this.strokeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              height: 150,
              width: 405,
              decoration: BoxDecoration(
                  borderRadius: onlyTopLeftRight12,
                  color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(text.toString(),
                      style: FontStyleUtilities.h3(fontWeight: FWT.semiBold)),
                  CircularProcessor(
                    strokeColor: strokeColor,
                    circleColor: circleColor,
                    processPercentage: processPercentage,
                    processTitle: "$processPercentage%",
                  ),
                ],
              ),
            )
          ],
        ),
        h20,
        Container(
          height: 345,
          width: 405,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ]),
          child: ClipRRect(
            borderRadius: cr12,
            child: DataTable(
              dataRowHeight: 51.05,
              headingRowHeight: 50,
              dividerThickness: 0.01,
              headingTextStyle: FontStyleUtilities.h5(
                  fontColor: AppColors.white, fontWeight: FWT.semiBold),
              headingRowColor: MaterialStateProperty.all(color),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: cr12),
              rows: marksList
                  .map(
                    (marks) => DataRow(
                      cells: [
                        DataCell(Text("${marks.subject}")),
                        DataCell(
                            Text("${marks.outOf}", style: marks.textStyle)),
                        DataCell(Text("${marks.marks}", style: marks.textStyle))
                      ],
                    ),
                  )
                  .toList(),
              columns: _columns(),
              columnSpacing: 0,
            ),
          ),
        ),
      ],
    );
  }
}

List<DataColumn> _columns() {
  return [
     DataColumn(label: Text('subjects'.tr)),
     DataColumn(label: Text('out_of'.tr)),
     DataColumn(label: Text('marks'.tr)),
  ];
}
