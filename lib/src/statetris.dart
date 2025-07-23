// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:statetris/src/statetris_block.dart';

const _duration = Duration(milliseconds: 300);
const double _progressIndicatorHeight = 8;
const double _g24 = 24;
const double _g16 = 16;
const double _g4 = 4;
const double _g2 = 2;

typedef StateBuilder = StatetrisBlock Function(BuildContext);

class Statetris extends StatelessWidget {
  const Statetris({
    super.key,
    required this.mode,
    required this.builder,
    this.onLoading,
    this.onError,
  });

  final Mode mode;
  final WidgetBuilder builder;
  final StateBuilder? onLoading;
  final StateBuilder? onError;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _duration,
      reverseDuration: _duration,
      child: switch (mode) {
        Mode.loading =>
          onLoading == null
              ? builder(context)
              : StatetrisLoading(
                  block: onLoading!(context),
                ),
        Mode.loaded => builder(context),
        Mode.error =>
          onError == null
              ? builder(context)
              : StatetrisError(
                  block: onError!(context),
                ),
      },
    );
  }
}

class StatetrisLoading extends StatelessWidget {
  const StatetrisLoading({
    required this.block,
  });

  final StatetrisBlock block;

  @override
  Widget build(BuildContext context) {
    final progressIndicator = SizedBox(
      height: _progressIndicatorHeight,
      width: _progressIndicatorHeight,
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(_progressIndicatorHeight / 2),
      ),
    );

    final hasTitle = block.title != null;
    final hasSubtitle = block.subtitle != null;
    final hasAsset = block.asset != null;

    if (!hasTitle && !hasSubtitle && !hasAsset) {
      return _StateBodyWidget(
        child: progressIndicator,
      );
    }

    final textTheme = Theme.of(context).textTheme;
    return _StateBodyWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasAsset)
            Padding(
              padding: const EdgeInsets.only(bottom: _g24),
              child: block.asset!,
            ),
          progressIndicator,
          if (hasTitle)
            Padding(
              padding: const EdgeInsets.only(top: _g24),
              child: DefaultTextStyle(
                style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                child: block.title!,
              ),
            ),
          if (hasSubtitle)
            Padding(
              padding: const EdgeInsets.only(top: _g4),
              child: DefaultTextStyle(style: textTheme.bodyMedium!, child: block.subtitle!),
            ),
        ],
      ),
    );
  }
}

class StatetrisError extends StatelessWidget {
  const StatetrisError({
    required this.block,
  });

  final StatetrisBlock block;

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
      return _StateBodyWidget(
        child: titleWidget,
      );
    }

    return _StateBodyWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasAsset)
            Padding(
              padding: const EdgeInsets.only(bottom: _g24),
              child: block.asset!,
            ),
          titleWidget,
          if (hasSubtitle)
            Padding(
              padding: const EdgeInsets.only(top: _g4),
              child: DefaultTextStyle(style: textTheme.bodyMedium!, child: block.subtitle!),
            ),
          if (hasAction)
            Padding(
              padding: const EdgeInsets.only(top: _g2),
              child: block.action,
            ),
        ],
      ),
    );
  }
}

class _StateBodyWidget extends StatelessWidget {
  const _StateBodyWidget({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(_g16), child: child),
    );
  }
}

enum Mode { loading, loaded, error }
