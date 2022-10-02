class CountViewModelState {
  final String count;
  CountViewModelState({required this.count});

  CountViewModelState copyWith({
    String? count,
  }) {
    return CountViewModelState(
      count: count ?? this.count,
    );
  }
}
