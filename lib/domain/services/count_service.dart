import 'dart:math';

import 'package:flutter_login_app/data/data_providers/counter_data_provider.dart';
import 'package:flutter_login_app/domain/entities/count.dart';

class CountService {
  final CounterDateProvider _counterDateProvider = CounterDateProvider();

  Count _count = Count(0);

  Count get count => _count;

  Future<void> initialize() async {
    _count = await _counterDateProvider.loadValue();
  }

  Future<void> incrementCount() async {
    _count = count.copyWith(count: _count.count + 1);
    _counterDateProvider.saveValue(count: _count);
  }

  Future<void> decrementCount() async {
    _count = count.copyWith(count: max(_count.count - 1, 0));
    _counterDateProvider.saveValue(count: _count);
  }
}
