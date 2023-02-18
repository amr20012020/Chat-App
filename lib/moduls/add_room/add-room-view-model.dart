import 'package:chat_app/DatabaseUtils/databaseUtils.dart';
import 'package:chat_app/layout/base.dart';
import 'package:chat_app/models/room.dart';
import 'package:chat_app/moduls/add_room/add-room-navigator.dart';

class AddRoomViewModel extends BaseViewModeL<AddRoomNavigator>{
  
  void AddRoomToDB(String title, String desc, String catId){
    Room room = Room(
        title: title,
        desc: desc,
        catId: catId);

    DatabaseUtils.AddRoomToFirestore(room).then((value) {
      navigator!.RoomCreated();
    }).catchError((error){

    });
  }
}