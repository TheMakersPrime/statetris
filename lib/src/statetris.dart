// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:statetris/src/data/state_pod.dart';
import 'package:statetris/src/widgets/statetris_error.dart';
import 'package:statetris/src/widgets/statetris_loading.dart';

const _duration = Duration(milliseconds: 300);

typedef StateBuilder = StatePod Function(BuildContext);

class Statetris extends StatelessWidget {
  const Statetris({
    super.key,
    required this.mode,
    required this.builder,
    this.onLoadingStateBuilder,
    this.onLoadingBuilder,
    this.onErrorStateBuilder,
    this.onErrorBuilder,
  });

  final StatetrisMode mode;
  final WidgetBuilder builder;

  final StateBuilder? onLoadingStateBuilder;
  final WidgetBuilder? onLoadingBuilder;

  final StateBuilder? onErrorStateBuilder;
  final WidgetBuilder? onErrorBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _duration,
      reverseDuration: _duration,
      child: switch (mode) {
        StatetrisMode.loading =>
          onLoadingBuilder?.call(context) ??
              (onLoadingStateBuilder == null
                  ? builder(context)
                  : StatetrisLoading(
                      block: onLoadingStateBuilder!(context),
                    )),
        StatetrisMode.loaded => builder(context),
        StatetrisMode.error =>
          onErrorBuilder?.call(context) ??
              (onErrorStateBuilder == null
                  ? builder(context)
                  : StatetrisError(
                      block: onErrorStateBuilder!(context),
                    )),
      },
    );
  }
}

enum StatetrisMode { loading, loaded, error }
