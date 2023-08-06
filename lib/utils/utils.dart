import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
class Utils {
  static Future<bool> permissionRequest()async{

    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      var temp = await Permission.storage.status;
      if(temp.isDenied){
        return false;
      }else if(temp.isGranted){
        return true;
      }else if(temp.isRestricted){
        return false;
      }else{
        return false;
      }
    }
    else if(status.isGranted)
    {
      return true;
    }
    else if(status.isRestricted)
    {
      return false;
    }else{
      return false;
    }
  }



}