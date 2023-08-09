import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as path;
class BottomPlayerController extends GetxController{
  RxBool isPlaying=false.obs;
  RxDouble angle=0.0.obs;
  RxDouble progress=0.0.obs;
  RxString totalLength=''.obs;
  RxString currentLength='0:0'.obs;
  RxString filePath=''.obs;
  RxString fileName=''.obs;
  final player=AudioPlayer();

  setFilePath(String filePath_){
    player.setFilePath(filePath_).then((value) {
      totalLength.value='${player.duration!.inMinutes.toString()}:${(player.duration!.inSeconds % 60).toString()}';
      filePath.value=filePath_;
      var temp=path.basename(filePath_);
      temp.substring(0,temp.indexOf('.'));
      if(temp.length>20)
        {
          temp=temp.substring(0,19);
        }
      fileName.value=temp;
      playSong();
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
    player.stop();
    isPlaying.value=false;
  }

  setProgress(){

      if(player.playerState.playing){
        progress.value=player.position.inSeconds/player.duration!.inSeconds;
        currentLength.value='${player.position.inMinutes.toString()}:${(player.position.inSeconds % 60).toString()}';
        if(currentLength==totalLength){
          player.stop();
          isPlaying.value=false;
        }

    }
  }
}