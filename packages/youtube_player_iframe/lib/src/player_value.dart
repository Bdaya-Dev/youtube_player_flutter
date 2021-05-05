// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import '../src/player_params.dart';
import 'enums/playback_rate.dart';
import 'enums/player_state.dart';
import 'enums/youtube_error.dart';
import 'meta_data.dart';

/// Youtube Player value
class YoutubePlayerValue {
  /// The duration, current position, buffering state, error state and settings
  /// of a [YoutubePlayerController].
  const YoutubePlayerValue({
    this.params = const YoutubePlayerParams(),
    this.isReady = false,
    this.hasPlayed = false,
    this.position = const Duration(),
    this.buffered = 0.0,
    this.isFullScreen = false,
    this.volume = 100,
    this.playerState = PlayerState.unknown,
    this.playbackRate = PlaybackRate.normal,
    this.playbackQuality,
    this.error = YoutubeError.none,
    this.metadataMap = const <String, YoutubeMetaData>{},
    this.videoIds = const <String>[],
    this.currentVideoIdIndex = -1,
  });

  /// The parameters for the player
  final YoutubePlayerParams params;

  /// Current queue
  final List<String> videoIds;

  /// the index of the video in [videoIds] that is being played right now
  final int currentVideoIdIndex;

  /// gets the current video Id based on [videoIds] and [currentVideoIdIndex]
  String? get currentVideoId {
    if (videoIds.isEmpty) return null;
    if (currentVideoIdIndex < 0 || currentVideoIdIndex >= videoIds.length) {
      return null;
    }
    return videoIds[currentVideoIdIndex];
  }

  /// Gets the current metadata of the [currentVideoId]
  YoutubeMetaData? get currentMetaData {
    final curId = currentVideoId;
    if (curId == null) return null;
    return metadataMap[curId];
  }

  /// Returns true when the player is ready to play videos.
  final bool isReady;

  /// Returns true once the video start playing for the first time.
  final bool hasPlayed;

  /// The current position of the video.
  final Duration position;

  /// The position up to which the video is buffered.i
  final double buffered;

  /// Reports true if video is fullscreen.
  final bool isFullScreen;

  /// The current volume assigned for the player.
  final int volume;

  /// The current state of the player defined as [PlayerState].
  final PlayerState playerState;

  /// The current video playback rate defined as [PlaybackRate].
  final double playbackRate;

  /// Reports the error code as described [here](https://developers.google.com/youtube/iframe_api_reference#Events).
  ///
  /// See the onError Section.
  final YoutubeError error;

  /// Returns true is player has errors.
  bool get hasError => error != YoutubeError.none;

  /// Reports the current playback quality.
  final String? playbackQuality;

  /// Returns meta data of the currently loaded/cued video.
  final Map<String, YoutubeMetaData> metadataMap;

  /// Creates new [YoutubePlayerValue] with assigned parameters and overrides
  /// the old one.
  YoutubePlayerValue copyWith({
    int? currentVideoIdIndex,
    bool? isReady,
    bool? hasPlayed,
    List<String>? videoIds,
    Duration? position,
    double? buffered,
    bool? isFullScreen,
    int? volume,
    PlayerState? playerState,
    double? playbackRate,
    String? playbackQuality,
    YoutubeError? error,
    Map<String, YoutubeMetaData>? metadataMap,
  }) {
    return YoutubePlayerValue(
      currentVideoIdIndex: currentVideoIdIndex ?? this.currentVideoIdIndex,
      videoIds: videoIds ?? this.videoIds,
      isReady: isReady ?? this.isReady,
      hasPlayed: hasPlayed ?? this.hasPlayed,
      position: position ?? this.position,
      buffered: buffered ?? this.buffered,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      volume: volume ?? this.volume,
      playerState: playerState ?? this.playerState,
      playbackRate: playbackRate ?? this.playbackRate,
      playbackQuality: playbackQuality ?? this.playbackQuality,
      error: error ?? this.error,
      metadataMap: metadataMap ?? this.metadataMap,
    );
  }

  @override
  String toString() {
    return '$runtimeType('
        'metaData: ${metadataMap.toString()}, '
        'isReady: $isReady, '
        'position: ${position.inSeconds} sec. , '
        'buffered: $buffered , '
        'volume: $volume, '
        'playerState: $playerState, '
        'playbackRate: $playbackRate, '
        'playbackQuality: $playbackQuality, '
        'currentVideoIdIndex: $currentVideoIdIndex, '
        'videoIds: $videoIds, '
        'error: $error)';
  }
}
