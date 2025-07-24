// Copyright (c) 2025 TheMakersPrime Authors. All rights reserved.

import 'package:flutter/material.dart';

class StatetrisBody extends StatelessWidget {
  const StatetrisBody({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
