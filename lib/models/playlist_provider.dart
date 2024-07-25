import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier{
  // songs playlist
  final List<Song> _playlist = [
    // song 1
  Song(
      songName: "Type Shit",
      artistName: "Future & Metro Boomin",
      albumArtImagePath: "lib/assets/covers/cover1.png",
      audioPath: "lib/assets/music/typeshit.mp3"
  ),

    // song2
    Song(
        songName: "H*es",
        artistName: "Future & Metro Boomin",
        albumArtImagePath: "lib/assets/covers/cover1.png",
        audioPath: "lib/assets/music/song2.mp3"
    ),

  ];
// current song playing index
  int? _currentSongIndex;


  /*
   *
   *  A U D I O   P L A Y E R S
   */

  // audio players
  final AudioPlayer _audioPlayer = AudioPlayer();  

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;


  // constructor
  PlaylistProvider () {

    listenToDuration();
    
  } 

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async{
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  }
  // pause current song
  void pause() async{
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async{
    if(_isPlaying){
      pause();
    } else {
      resume();
    }

    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if(_currentSongIndex != null){
      if(_currentSongIndex! < _playlist.length - 1){
        // go to the next song if it's not long song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }
  // play previous song
  void playPreviousSong() async {
    // if more than 2 secs have passed, restart the current song
    if(_currentDuration.inSeconds > 2){
        seek(Duration.zero);
    }
    // if it's within first 2 secs of song go to prev song
    else{
      if(_currentSongIndex! > 0){
        currentSongIndex = _currentSongIndex! - 1;
      } else{
        // if its first song loop back to last song
        currentSongIndex = _playlist.length -  1;
      }
    }
  }

  // listen to duration
  void listenToDuration(){
      // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    } );


     // listen for current duration
     _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
     });


     // listen for song completion
     _audioPlayer.onPlayerComplete.listen((event) {
       playNextSong();
     });        

     
  }

  // dispose audio player

  /*
  G E T T E R S
   */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPLaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  /*
  S E T T E R S
  */
  set currentSongIndex(int? newIndex){
    _currentSongIndex = newIndex;

    if(newIndex != null) {
      play(); // play the song at the new index
    }

    // update UI
    notifyListeners();
  }



}