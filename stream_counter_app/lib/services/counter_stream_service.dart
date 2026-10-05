import 'dart:async';
import 'dart:math';

class CounterStreamService {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  int _price = 10000;

  CounterStreamService() {
    _startCounting();
  }

  Stream<int> get stream => _controller.stream;

  void _startCounting() {
    // Bài tập mở rộng: Đổi thời gian thành 500ms
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // Bài tập mở rộng: Thay số đếm bằng giá sản phẩm realtime (dao động ngẫu nhiên)
      int fluctuation = Random().nextInt(1000) - 500; // -500 đến 500
      _price += fluctuation;
      if (_price < 0) _price = 0;
      
      print('Stream phát giá trị mới: $_price');
      _controller.sink.add(_price);
    });
  }

  // Bài tập mở rộng: Thêm nút Pause
  void pause() {
    _timer?.cancel();
    _timer = null;
    print('Stream Paused');
  }

  // Bài tập mở rộng: Thêm nút Resume
  void resume() {
    if (_timer == null || !_timer!.isActive) {
      _startCounting();
      print('Stream Resumed');
    }
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
