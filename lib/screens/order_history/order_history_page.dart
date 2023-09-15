import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/order_history/order_history_page_mobile.dart';
import 'package:katon/screens/order_history/order_history_page_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/utils/config.dart';
class OrderHistoryPage extends StatefulWidget {
  final Arguments? arguments;

  const OrderHistoryPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: CommonContainer(
        child: Responsive.isMobile(context)
            ? OrderHistoryPageMobile(arguments: widget.arguments)
            : OrderHistoryPageTablet(arguments: widget.arguments),
      ),
    );
  }
}
