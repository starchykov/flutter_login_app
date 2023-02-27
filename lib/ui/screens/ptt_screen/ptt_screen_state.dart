import 'dart:typed_data';

class PTTState {
  final bool isRecording;
  final List<Uint8List>? audioChunks;
  final Uint8List? audioToPlay;
  final String username;


  const PTTState({
    this.isRecording = false,
    this.audioChunks = const [],
    this.audioToPlay,
    required this.username,
  });

  PTTState copyWith({
    bool? isRecording,
    List<Uint8List>? audioChunks,
    Uint8List? audioToPlay,
    String? username,
  }) {
    return PTTState(
      isRecording: isRecording ?? this.isRecording,
      audioChunks: audioChunks ?? this.audioChunks,
      audioToPlay: audioToPlay ?? this.audioToPlay,
      username: username ?? this.username,
    );
  }
}