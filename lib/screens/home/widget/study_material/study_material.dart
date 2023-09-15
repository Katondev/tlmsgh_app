import 'package:flutter/material.dart';
import 'package:katon/screens/home/widget/study_material/study_material_mobile.dart';
import 'package:katon/screens/home/widget/study_material/study_material_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class StudyMaterial extends StatelessWidget {
  final String? bookName;
  final double? bookPrice;
  final bool? isFree;
  final int? rating;
  final String? image;

  const StudyMaterial({
    Key? key,
    required this.bookName,
    required this.bookPrice,
    required this.isFree,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? StudyMaterialMobile(image: image,bookName: bookName,bookPrice: bookPrice,isFree: isFree)
        : StudyMaterialTablet(image: image,bookName: bookName,bookPrice: bookPrice,isFree: isFree);
  }
}
