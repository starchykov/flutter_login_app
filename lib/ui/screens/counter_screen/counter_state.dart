import 'package:flutter/cupertino.dart';

@immutable
class CountViewModelState {
  final String count;
  const CountViewModelState({required this.count});

  CountViewModelState copyWith({
    String? count,
  }) {
    return CountViewModelState(
      count: count ?? this.count,
    );
  }
}
