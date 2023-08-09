import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
class HomeController extends GetxController{
  RxBool isPlaying=false.obs;
  RxDouble angle=0.0.obs;
  RxDouble progress=0.0.obs;
  RxDouble volume=0.7.obs;
  RxString totalLength=''.obs;
  RxString currentLength='0:0'.obs;
  final player=AudioPlayer();
  setVol(){
    player.setVolume(volume.value);
  }
  setFilePath(String filePath){
    player.setFilePath(filePath).then((value) {
      totalLength.value='${player.duration!.inMinutes.toString()}:${(player.duration!.inSeconds % 60).toString()}';
      setPlay();
    });

  }
  playSong() async {
    isPlaying.value=true;
    player.play().then((value) async {
    },);
  }
  setPlay(){
    if(isPlaying.value){
      pauseSong();
    }else{
      playSong();
    }
  }
  pauseSong() async {
    player.pause();
    isPlaying.value=false;
   }
   seekForward(){
    if(player.position.inSeconds<player.duration!.inSeconds-10){
      player.seek( Duration(seconds:player.position.inSeconds+ 10));
    }
   }
  seekBack(){

    if(player.position.inSeconds>10){
      player.seek( Duration(seconds: player.position.inSeconds-10));
    }


  }


  int i=0;
  setProgress(){

        progress.value=player.position.inSeconds/player.duration!.inSeconds;
        currentLength.value='${player.position.inMinutes.toString()}:${(player.position.inSeconds % 60).toString()}';
        if(currentLength==totalLength){
          player.stop();
          isPlaying.value=false;
        }


  }
}