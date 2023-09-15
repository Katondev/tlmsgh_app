import 'package:flutter/material.dart';
import 'package:katon/screens/home/widget/news_item/news_item_mobile.dart';
import 'package:katon/screens/home/widget/news_item/news_item_tablet.dart';
import 'package:katon/widgets/responsive.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? NewsItemMobile()
        : NewsItemTablet();
  }
}
