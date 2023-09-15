


import 'package:flutter/material.dart';
import 'package:katon/utils/font_style.dart';

class SubjectMarks{
  String? subject;
  int? outOf;
  int? marks;
  TextStyle? textStyle;

  SubjectMarks({
    this.subject,
    this.marks,
    this.outOf,
     this.textStyle,

  });
}

List<SubjectMarks> marksList = [
  SubjectMarks(outOf:50,marks:35, subject: "English"),
  SubjectMarks(outOf:50,marks:31, subject: 'CVS'),
  SubjectMarks(outOf:50,marks:42, subject: 'History'),
  SubjectMarks(outOf:50,marks:38, subject: 'Mathematics'),
  SubjectMarks(outOf:50,marks:45, subject: 'Science'),
  SubjectMarks(outOf:250,marks:191, subject: '',textStyle: FontStyleUtilities.h5(fontWeight: FWT.semiBold,height: 0.0)),
];