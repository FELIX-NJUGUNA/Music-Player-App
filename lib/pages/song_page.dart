import 'package:flutter/material.dart';
import 'package:music_player_app/components/neu_box.dart';
import 'package:music_player_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});


  // convert duration to min:sec
  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
        builder: (context, value, child) {

          // get playlist
          final playlist = value.playlist;

          // get current song index
          final currentSong = playlist[value.currentSongIndex ?? 0];

            // return Scaffold UI
             return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // app bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {Navigator.pop(context);},
                                  icon: Icon(Icons.arrow_back_ios_new)
                              ),
                              
                              Text("P L A Y I N G"),
                              
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.menu)
                              )
                            ],
                          ),
                      
                          const SizedBox(height: 10,),
                                  
                          // album art
                          NeuBox(
                              child: Column(
                                children: [
                                  // image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(currentSong.albumArtImagePath),
                                  ),
                                  
                                  // name and song
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // song artist and name
                                        Column(
                                          children: [
                                            Text(
                                              currentSong.songName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold, 
                                              fontSize: 20
                                            ),),
                                            Text(currentSong.artistName)
                                          ],
                                        ),
                                  
                                        
                                        // fav icon
                                       const Icon(Icons.favorite, color: Colors.red,),
                                      ],
                                    ),
                                  )
                                  
                                ],
                              ),
                          ),

                          const SizedBox(height: 20,),
                          
                          // song duration
                           Column(
                             children: [
                               Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     // start and end time
                                     Text(formatTime(value.currentDuration)),
                                 
                                     const Icon(Icons.shuffle),
                                 
                                     const Icon(Icons.repeat),
                                 
                                     Text(formatTime(value.totalDuration))
                                 
                                   ],
                                 ),
                              ),

                                  
                              // song duration progress
                               SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                                ),
                                 child: Slider(
                                   min: 0.0,
                                   max: value.totalDuration.inSeconds.toDouble(),
                                   value: value.currentDuration.inSeconds.toDouble(),
                                    activeColor: Colors.green,
                                   onChanged: (double double) {
                                      // during when the user is sliding around

                                   }, 
                                   onChangeEnd: (double double) {
                                    // sliding has finished, go to that position in song duration
                                      value.seek(Duration(seconds: double.toInt()));
                                   },
                                   ),
                               ),
                             ],
                           ),
                                  

                                  
                          // playback controls
                          Row(
                            children: [
                              // prev
                              Expanded(
                                child: GestureDetector(
                                  onTap: value.playPreviousSong ,
                                  child: const NeuBox(
                                    child: Icon(Icons.skip_previous),
                                    ),
                                ),
                              ),
                                  
                              const SizedBox(width: 20,),
                                  
                              // pause
                              Expanded(
                                child: GestureDetector(
                                  onTap: value.pauseOrResume ,
                                  child: NeuBox(
                                    child: Icon(value.isPLaying ? Icons.pause: Icons.play_arrow),
                                    ),
                                ),
                              ),
                                  
                                  
                               const SizedBox(width: 20,),
                                  
                            // next
                              Expanded(
                                child: GestureDetector(
                                  onTap: value.playNextSong ,
                                  child: const NeuBox(
                                    child: Icon(Icons.skip_next),
                                    ),
                                ),
                              ),
                            ],
                          )
                                  
                        ],
                      ),
                    ),
                  ),
                )
            );
            }
    );
  }
}
