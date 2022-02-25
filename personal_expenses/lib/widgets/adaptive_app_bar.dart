import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function tapHandler;

  const AdaptiveAppBar(this.title, this.tapHandler);

  PreferredSizeWidget _buildIOS(BuildContext context) => CupertinoNavigationBar(
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
      );

  PreferredSizeWidget _buildAndroid(BuildContext context) => AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => tapHandler(context),
            icon: const Icon(Icons.add),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildIOS(context) : _buildAndroid(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
