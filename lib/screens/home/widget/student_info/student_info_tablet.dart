import 'package:flutter/material.dart';
import 'package:katon/screens/home/widget/student_info/widgets/school_info_widget.dart';
import 'package:katon/screens/home/widget/student_info/widgets/student_info_widget.dart';
import 'package:katon/utils/config.dart';

class StudentInfoTablet extends StatelessWidget {
  final String? studentImage;
  final String? studentName;
  final String? classDetails;
  final String? schoolRollNO;
  final String? schoolImage;
  final String? schoolName;
  final String? schoolAddress;
  final String? schoolContact;
  const StudentInfoTablet(
      {Key? key,
      this.studentImage,
      this.schoolImage,
      this.studentName,
      this.schoolName,
      this.classDetails,
      this.schoolAddress,
      this.schoolContact,
      this.schoolRollNO})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      width: 617,
      padding: all12,
      decoration: BoxDecoration(
        color: AppColors.orangeAccent,
        borderRadius: cr24,
      ),
      child: Container(
        padding: l11t12b8,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: cr24,
        ),
        child: Row(
          children: [
            SchoolInfoWidget(
                schoolImage: schoolImage,
                schoolName: schoolName,
                schoolAddress: schoolAddress,
                schoolContact: schoolContact),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  150 ~/ 4,
                  (index) => Expanded(
                        child: Container(
                          color: index % 2 == 0
                              ? Colors.transparent
                              : AppColors.orangeAccent,
                          height: 2,
                          width: 2,
                        ),
                      )),
            ),
            w10,
            StudentInfoWidget(studentImage:  studentImage,studentName: studentName,schoolRollNO: schoolRollNO,classDetails: classDetails)
          ],
        ),
      ),
    );
  }
}
