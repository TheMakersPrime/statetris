// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:statetris/src/data/state_pod.dart';
import 'package:statetris/src/widgets/statetris_body.dart';

class StatetrisLoading extends StatelessWidget {
  const StatetrisLoading({
    required this.block,
    this.progressBarHeight = 8,
  });

  final StatePod block;
  final double progressBarHeight;

  @override
  Widget build(BuildContext context) {
    final progressIndicator = SizedBox(
      height: progressBarHeight,
      width: progressBarHeight,
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(progressBarHeight / 2),
      ),
    );

    final hasTitle = block.title != null;
    final hasSubtitle = block.subtitle != null;
    final hasAsset = block.asset != null;

    if (!hasTitle && !hasSubtitle && !hasAsset) {
      return StatetrisBody(
        child: progressIndicator,
      );
    }

    final textTheme = Theme.of(context).textTheme;
    return StatetrisBody(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasAsset)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: block.asset!,
            ),
          progressIndicator,
          if (hasTitle)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: DefaultTextStyle(
                style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                child: block.title!,
              ),
            ),
          if (hasSubtitle)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: DefaultTextStyle(style: textTheme.bodyMedium!, child: block.subtitle!),
            ),
        ],
      ),
    );
  }
}
