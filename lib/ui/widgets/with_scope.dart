import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WithScope extends StatelessWidget {
  final List<Override> overrides;
  final Widget child;

  const WithScope({
    super.key,
    required this.overrides,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: overrides,
      child: child,
    );
  }
}