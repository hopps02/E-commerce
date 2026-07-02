import 'package:audioplayers/audioplayers.dart';

class NewOrderAlarmService {
  static final NewOrderAlarmService _instance = NewOrderAlarmService._();

  factory NewOrderAlarmService() => _instance;

  NewOrderAlarmService._();

  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;

  Future<void> start() async {
    if (_isPlaying) return;

    _isPlaying = true;
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.setVolume(1);
      await _player.play(AssetSource('sounds/new_order_alert.wav'));
    } catch (_) {
      _isPlaying = false;
    }
  }

  Future<void> stop() async {
    if (!_isPlaying) return;

    try {
      await _player.stop();
      await _player.release();
    } catch (_) {
      // Best-effort alarm teardown.
    } finally {
      _isPlaying = false;
    }
  }
}
