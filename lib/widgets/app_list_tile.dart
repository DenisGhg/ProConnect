import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';

class AppListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Function()? onTap;

  const AppListTile({
    super.key,
    this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: context.defaultPagePadding),
      horizontalTitleGap: 12.0,
      dense: true,
    );
  }
}