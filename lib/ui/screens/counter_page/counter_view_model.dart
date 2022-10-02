import 'package:flutter/material.dart';
import 'package:flutter_login_app/domain/services/count_service.dart';
import 'package:flutter_login_app/ui/screens/counter_page/counter_state.dart';

class CounterViewModel extends ChangeNotifier {
  final CountService _countService = CountService();

  CountViewModelState _state = CountViewModelState(count: '0');

  CountViewModelState get state => _state;

  CounterViewModel() {
    _loadValue();
  }

  Future<void> _loadValue() async {
    await _countService.initialize();
    _state = CountViewModelState(count: '${_countService.count.count}');
    _updateState();
  }

  Future<void> onIncrementButtonPressed() async {
    await _countService.incrementCount();
    _updateState();
  }

  Future<void> onDecrementButtonPressed() async {
    await _countService.decrementCount();
    _updateState();
  }

  Future<void> _updateState() async {
    _state = _state.copyWith(count: '${_countService.count.count}');
    notifyListeners();
  }
}
