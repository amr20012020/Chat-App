import 'package:chat_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/room.dart';

class DatabaseUtils{
   static CollectionReference<MyUser> getUsersCollection(){
     return FirebaseFirestore.instance.collection(MyUser.COLLECTION_NAME)
         .withConverter<MyUser>(
         fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
         toFirestore: (value,options) => value.toJson());
   }

  static Future<void> AddUserToFirestore(MyUser myUser){
   return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFirestore(String id)async{
    DocumentSnapshot<MyUser> user = await getUsersCollection().doc(id).get();
     var myUser = user.data();
     return myUser;
  }

   static CollectionReference<Room> getRoomsCollection(){
     return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME)
         .withConverter<Room>(
         fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
         toFirestore: (room,options) => room.toJson());
   }

   static Future<void> AddRoomToFirestore(Room room){
     var collection = getRoomsCollection();
     var docRef = collection.doc();
     room.id = docRef.id;
     return docRef.set(room);
   }

   static Future<List<Room>> readRoomsFromFireStore() async{
     QuerySnapshot<Room> snapRooms = await getRoomsCollection().get();

     return snapRooms.docs.map((doc) => doc.data()).toList();
   }}