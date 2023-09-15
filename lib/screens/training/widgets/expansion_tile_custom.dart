import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:katon/utils/config.dart';

class ExpansionTileCustom extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final Widget? leading;
  final bool? initiallyExpanded;
  final Function(bool)? onExpansionChanged;
  const ExpansionTileCustom(
      {required this.title,
      required this.children,
      super.key,
      this.leading,
      this.onExpansionChanged,
      this.initiallyExpanded});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: title,
      children: children,
      leading: leading,
      maintainState: true,
      onExpansionChanged: onExpansionChanged,
      initiallyExpanded: initiallyExpanded ?? false,
      tilePadding: EdgeInsets.zero,
    );
  }
}
