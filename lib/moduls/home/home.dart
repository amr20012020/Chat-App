import 'package:chat_app/layout/base.dart';
import 'package:chat_app/moduls/add_room/add-room-screen.dart';
import 'package:chat_app/moduls/home/home_navigator.dart';
import 'package:chat_app/moduls/home/home_view_model.dart';
import 'package:chat_app/moduls/home/room_widget.dart';
import 'package:chat_app/moduls/login/Login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen,HomeViewModel> implements HomeNavigator{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModeL.navigator = this;
    viewModeL.readRooms();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModeL,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/bg.png",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.routeName);
              },
              child: Icon(Icons.add,color: Colors.white,),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text("Chat-App"),
              actions: [
                IconButton(onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                }, icon: Icon(Icons.logout))
              ],
            ),
            body: Consumer<HomeViewModel>(
              builder: (_, homeViewModel, c) {
                return GridView.builder(
                    itemBuilder: (context, index){
                      return RoomWidget(homeViewModel.rooms[index]);
                    },
                  itemCount: homeViewModel.rooms.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 16,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                  ),
                );
              },

            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
