import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/no_data_found.dart';

/// Convert this pdf page into pdf_view_page.dart
class NotificationPdfView extends StatelessWidget {
  final String filename;
  const NotificationPdfView({Key? key, required this.filename})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const PDF().fromUrl(
        errorWidget: (error) {
          return Container(
            color: AppColors.white,
            child: const NoDataFound(
              message: "No Pdf Found!!",
            ),
          );
        },
        placeholder: (progress) {
          return Container(
            color: AppColors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        ApiRoutes.imageURL + filename,
      ),
    );
  }
}
