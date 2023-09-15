import 'package:flutter/material.dart';
import 'package:katon/screens/home/widget/student_info/student_info_mobile.dart';
import 'package:katon/screens/home/widget/student_info/student_info_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class StudentInfo extends StatelessWidget {
  final String? studentImage;
  final String? schoolImage;
  final String? studentName;
  final String? schoolName;
  final String? classDetails;
  final String? schoolAddress;
  final String? schoolContact;
  final String? schoolRollNO;

  const StudentInfo(
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
    return Responsive.isMobile(context)
        ? StudentInfoMobile(
            classDetails: classDetails,
            schoolAddress: schoolAddress,
            schoolContact: schoolContact,
            schoolImage: schoolImage,
            schoolName: schoolName,
            schoolRollNO: schoolRollNO,
            studentImage: studentImage,
            studentName: studentName,
          )
        : StudentInfoTablet(
            classDetails: classDetails,
            schoolAddress: schoolAddress,
            schoolContact: schoolContact,
            schoolImage: schoolImage,
            schoolName: schoolName,
            schoolRollNO: schoolRollNO,
            studentImage: studentImage,
            studentName: studentName,
          );
  }
}
