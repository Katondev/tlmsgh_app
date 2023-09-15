import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/book_detail/widget/similar_book_module/similar_book_module.dart';
import 'package:katon/screens/my_library/widgets/library_book_module.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';

import '../../../teacher/drawer.dart';
import '../../../utils/app_binding.dart';
import '../../../utils/prefs/app_preference.dart';
import '../../../widgets/drawer/drawer.dart';

class LibraryBookDetailPageTablet extends StatelessWidget {
  const LibraryBookDetailPageTablet({Key? key}) : super(key: key);

  bool isMenuFixed(BuildContext context) {
    return MediaQuery.of(context).size.width > 500;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    BookDetailsM books = args[0];
    Arguments title = args[1];
    List<BookDetailsM> bookList = args[2];
    final theme = Theme.of(context);
    final menu = Container(
      color: theme.canvasColor,
      child: DrawerBox(navKey: navigatorKey),
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: commonAppBar(
          backIcon: true,
          onPressed: () {
            Navigator.pop(context);
          },
          title: title.title,
          description: title.description),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      // endDrawer: endDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // if (isMenuFixed(context)) menu,
            Padding(
              padding: l20t05r10b14,
              child: Row(
                children: [
                  LibraryBookModule(book: books),
                  w10,
                  bookList.isEmpty
                      ? const SizedBox.shrink()
                      : SimilarBookModule(
                          bookList: bookList,
                          isLibrary: true,
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
