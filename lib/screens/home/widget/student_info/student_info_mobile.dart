import 'package:flutter/material.dart';
import 'package:katon/screens/home/widget/student_info/widgets/school_info_widget.dart';
import 'package:katon/screens/home/widget/student_info/widgets/student_info_widget.dart';
import 'package:katon/utils/config.dart';

class StudentInfoMobile extends StatelessWidget {
  final String? studentImage;
  final String? schoolImage;
  final String? studentName;
  final String? schoolName;
  final String? classDetails;
  final String? schoolAddress;
  final String? schoolContact;
  final String? schoolRollNO;
  const StudentInfoMobile(
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
      padding: t13l10r10b14,
      decoration: BoxDecoration(
        color: AppColors.orangeAccent,
        borderRadius: cr24,
      ),
      child: Container(
          height: 220,
          padding: l11t12b8,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: cr24,
          ),
          child: Column(
            children: [
              SchoolInfoWidget(
                  schoolImage: schoolImage,
                  schoolName: schoolName,
                  schoolAddress: schoolAddress,
                  schoolContact: schoolContact),
              Expanded(
                child: Row(
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
              ),
              StudentInfoWidget(
                  studentImage: studentImage,
                  studentName: studentName,
                  schoolRollNO: schoolRollNO,
                  classDetails: classDetails)
            ],
          )),
    );
  }
}
