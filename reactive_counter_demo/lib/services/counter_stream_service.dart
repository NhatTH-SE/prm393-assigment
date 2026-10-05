import 'dart:async';

class ReactiveCounterService {
  // Stream 1: Counter
  final StreamController<int> _counterController = StreamController<int>.broadcast();
  // Stream 2: System Messages (Yêu cầu mở rộng: 2 stream cùng lúc)
  final StreamController<String> _messageController = StreamController<String>.broadcast();

  Timer? _timer;
  int _counter = 0;

  Stream<int> get counterStream => _counterController.stream;
  Stream<String> get messageStream => _messageController.stream;

  void start() {
    _messageController.add("Hệ thống khởi động...");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _counter++;
      _counterController.add(_counter);

      if (_counter % 5 == 0) {
        _messageController.add("Hệ thống đang chạy ổn định. (Tick: $_counter)");
      }
    });
  }

  // Yêu cầu mở rộng: Pause / Resume Stream
  void pause() {
    _timer?.cancel();
    _timer = null;
    _messageController.add("Hệ thống tạm dừng.");
  }

  void resume() {
    if (_timer == null || !_timer!.isActive) {
      start();
      _messageController.add("Hệ thống tiếp tục hoạt động.");
    }
  }

  void dispose() {
    _timer?.cancel();
    _counterController.close();
    _messageController.close();
  }
}
