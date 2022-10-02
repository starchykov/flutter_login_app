import 'dart:async';
import 'package:flutter_login_app/domain/entities/notification_entity.dart';

class NotificationProvider {
  Timer? _timer;
  var _notification = const NotificationEntity(id: 0, title: 'New message', body: 'Bla bla', type: '');
  final StreamController<NotificationEntity> _controller = StreamController<NotificationEntity>();

  Stream<NotificationEntity> get notificationStream => _controller.stream.asBroadcastStream();

  NotificationEntity get notification => _notification;

  void openConnect() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _notification = const NotificationEntity(id: 0, title: 'New message', body: 'Bla bla', type: '');
      _controller.add(_notification);
    });
  }

  void closeConnect() {
    _timer?.cancel();
    _timer = null;
  }
}
