import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function tapHandler;

  const AdaptiveAppBar(this.title, this.tapHandler);

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => tapHandler(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(title),
            actions: [
              IconButton(
                  onPressed: () => tapHandler(context),
                  icon: const Icon(Icons.add))
            ],
          )) as PreferredSizeWidget;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
