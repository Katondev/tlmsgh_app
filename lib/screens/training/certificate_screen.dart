import 'package:flutter/material.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/font_style.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  static GlobalKey previewContainer = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TrainingProvider>(
        builder: (context, value, child) => Center(
          child: RepaintBoundary(
            key: previewContainer,
            child: Stack(
              children: [
                Image.asset("${AppAssets.certificate}"),
                Positioned.fill(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 40,
                  child: Center(
                    child: Text(
                      value.signatureCnt.text,
                      style: AppTextStyle.normalRegular20.copyWith(
                          color: AppColors.primaryBlack,
                          fontFamily:
                              value.signatureFontfamily[value.selectedSign]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
