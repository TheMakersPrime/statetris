// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:statetris/src/data/state_pod.dart';
import 'package:statetris/src/widgets/statetris_body.dart';

class StatetrisError extends StatelessWidget {
  const StatetrisError({
    required this.block,
  });

  final StatePod block;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleWidget = DefaultTextStyle(
      style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
      child: block.title ?? const Text('Error'),
    );

    final hasTitle = block.title != null;
    final hasSubtitle = block.subtitle != null;
    final hasAsset = block.asset != null;
    final hasAction = block.action != null;

    if (!hasTitle && !hasSubtitle && !hasAsset) {
      return StatetrisBody(
        child: titleWidget,
      );
    }

    return StatetrisBody(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasAsset)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: block.asset!,
            ),
          titleWidget,
          if (hasSubtitle)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: DefaultTextStyle(style: textTheme.bodyMedium!, child: block.subtitle!),
            ),
          if (hasAction)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: block.action,
            ),
        ],
      ),
    );
  }
}
