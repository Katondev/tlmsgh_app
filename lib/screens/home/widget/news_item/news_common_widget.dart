import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';

class NewsEntry extends StatelessWidget {
  const NewsEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
                "https://media.istockphoto.com/photos/portrait-of-schoolboy-standing-at-school-campus-picture-id1163984184?k=20&m=1163984184&s=612x612&w=0&h=GI3jbN2rEoM69Z1MPJwvNgnfwFg8hCKFykIvQgGIcdA=")),
        w8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('jane_cooper'.tr,
                style: FontStyleUtilities.t4(
                    fontWeight: FWT.medium, fontColor: AppColors.primaryColor)),
            h2,
            Text('july'.tr,
                style: FontStyleUtilities.t6(fontColor: AppColors.gray400)),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary.withOpacity(0.10),
          child: Center(child: SvgIcon(Images.arrowRightSvg)),
        ),
      ],
    );
  }
}

class NewsImage extends StatelessWidget {
  final double height;
  final double width;
  const NewsImage({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: height,
      decoration: BoxDecoration(
        borderRadius: cr12,
        image: const DecorationImage(
            image: NetworkImage(
              "https://media.istockphoto.com/photos/multiethnic-group-of-latin-american-college-students-smiling-picture-id1349297974?b=1&k=20&m=1349297974&s=170667a&w=0&h=HXhZJOkouT4BWGa-or0-AriJlmXJHZdCZBQqGwu6yvs=",
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}
