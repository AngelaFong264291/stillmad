import 'package:just_audio/just_audio.dart';

class SoundService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playReleaseCue() async {
    // Wire this to a local asset once the audio direction is chosen.
    if (_player.playing) {
      await _player.stop();
    }
  }

  Future<void> dispose() => _player.dispose();
}
