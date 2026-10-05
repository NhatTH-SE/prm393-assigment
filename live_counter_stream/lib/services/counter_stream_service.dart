import 'dart:async';

class CounterStreamService {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  int _counter = 0;

  Stream<int> get stream => _controller.stream;

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _counter++;
      print('Emit counter: $_counter');
      _controller.add(_counter);

      // Yêu cầu mở rộng: Thêm lỗi giả lập (addError)
      if (_counter % 5 == 0) {
        _controller.addError('Lỗi giả lập khi counter = $_counter');
      }
    });
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
    print('Stream Paused');
  }

  void resume() {
    if (_timer == null || !_timer!.isActive) {
      start();
      print('Stream Resumed');
    }
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
