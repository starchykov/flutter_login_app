class Count {
  final int _count;

  Count(this._count);

  int get count => _count;

  Count copyWith({int? count}) => Count(count ?? _count);
}