import 'package:chat_app/DatabaseUtils/databaseUtils.dart';
import 'package:chat_app/layout/base.dart';

import '../../models/room.dart';

class HomeViewModel extends BaseViewModeL{

   List<Room> rooms = [];
  void readRooms(){
    DatabaseUtils.readRoomsFromFireStore().then((value) {
      rooms = value;
    }).catchError((error){
      navigator!.showMessage(error.toString());
    });
  }
}