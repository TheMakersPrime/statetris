import 'package:flutter/material.dart';

class StatetrisBlock {
  const StatetrisBlock.loading({
    Widget? asset,
    Widget? title,
    Widget? subtitle,
  }) : _asset = asset,
       _title = title,
       _subtitle = subtitle,
       _action = null;

  const StatetrisBlock.error({
    Widget? asset,
    Widget? title,
    Widget? subtitle,
    Widget? action,
  }) : _asset = asset,
       _title = title,
       _subtitle = subtitle,
       _action = action;

  final Widget? _asset;
  final Widget? _title;
  final Widget? _subtitle;
  final Widget? _action;

  Widget? get asset => _asset;

  Widget? get title => _title;

  Widget? get subtitle => _subtitle;

  Widget? get action => _action;
}
