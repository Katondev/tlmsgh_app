import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/past_paper/past_paper_mobile.dart';
import 'package:katon/screens/past_paper/past_paper_tablet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import 'package:katon/utils/config.dart';
class PastPaperPage extends StatefulWidget {
  final Arguments? arguments;

  const PastPaperPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<PastPaperPage> createState() => _PastPaperPageState();
}

class _PastPaperPageState extends State<PastPaperPage> {
  PastPaperProvider? paperProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paperProvider = Provider.of<PastPaperProvider>(context, listen: false);
    init();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await paperProvider?.getAllPastPaperList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Consumer<PastPaperProvider>(
        builder: (context, value, child) => CommonContainer(
            child: Responsive.isMobile(context)
                ? PastPaperPageMobile(arguments: widget.arguments)
                : PastPaperPageTablet(arguments: widget.arguments)),
      ),
    );
  }
}
