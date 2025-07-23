// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);
const double _progressIndicatorHeight = 8;
const double _g24 = 24;
const double _g16 = 16;
const double _g4 = 4;
const double _g2 = 2;

class Statetris extends StatelessWidget {
  const Statetris({
    super.key,
    required WidgetBuilder this.builder,
  }) : _mode = _Mode.loaded,
       asset = null,
       title = null,
       subtitle = null,
       action = null;

  const Statetris.loading({
    super.key,
    this.asset,
    this.title,
    this.subtitle,
  }) : _mode = _Mode.loading,
       action = null,
       builder = null;

  const Statetris.error({
    super.key,
    this.asset,
    this.title,
    this.subtitle,
    this.action,
  }) : _mode = _Mode.error,
       builder = null;

  final Widget? asset;
  final Widget? title;
  final Widget? subtitle;
  final Widget? action;
  final WidgetBuilder? builder;
  final _Mode _mode;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _duration,
      reverseDuration: _duration,
      child: switch (_mode) {
        _Mode.loading => _LoadingWidget(asset: asset, title: title, subtitle: subtitle),
        _Mode.loaded => builder!(context),
        _Mode.error => _ErrorWidget(asset: asset, title: title, subtitle: subtitle, action: action),
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({required this.asset, required this.title, required this.subtitle});

  final Widget? asset;
  final Widget? title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final progressIndicator = SizedBox(
      height: _progressIndicatorHeight,
      width: _progressIndicatorHeight,
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(_progressIndicatorHeight / 2),
      ),
    );

    final hasTitle = title != null;
    final hasSubtitle = subtitle != null;
    final hasAsset = asset != null;

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
              child: asset!,
            ),
          progressIndicator,
          if (hasTitle)
            Padding(
              padding: const EdgeInsets.only(top: _g24),
              child: DefaultTextStyle(
                style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                child: title!,
              ),
            ),
          if (hasSubtitle)
            Padding(
              padding: const EdgeInsets.only(top: _g4),
              child: DefaultTextStyle(style: textTheme.bodyMedium!, child: subtitle!),
            ),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({required this.asset, required this.title, required this.subtitle, required this.action});

  final Widget? asset;
  final Widget? title;
  final Widget? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleWidget = DefaultTextStyle(
      style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
      child: title ?? const Text('Error'),
    );

    final hasTitle = title != null;
    final hasSubtitle = subtitle != null;
    final hasAsset = asset != null;
    final hasAction = action != null;

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
              child: asset!,
            ),
          titleWidget,
          if (hasSubtitle)
            Padding(
              padding: const EdgeInsets.only(top: _g4),
              child: DefaultTextStyle(style: textTheme.bodyMedium!, child: subtitle!),
            ),
          if (hasAction)
            Padding(
              padding: const EdgeInsets.only(top: _g2),
              child: action,
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

enum _Mode { loading, loaded, error }
