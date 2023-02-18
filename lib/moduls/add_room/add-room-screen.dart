import 'package:chat_app/layout/base.dart';
import 'package:chat_app/models/category.dart';
import 'package:chat_app/moduls/add_room/add-room-navigator.dart';
import 'package:chat_app/moduls/add_room/add-room-view-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/style/colors.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "add-room";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  // CreateAccountViewModel viewModel = CreateAccountViewModel();
  var categories = RoomCategory.getCategories();
 late  RoomCategory selectedCategory;

  bool isPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModeL.navigator = this;
    selectedCategory = categories[0];
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text('Add Room'),
            ),
            body: SingleChildScrollView(
              child: Card(
                elevation: 22,
                margin: EdgeInsets.all(30),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text("Crete New Room",
                              textAlign: TextAlign.center,
                             style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/images/group.png"),
                            ),
                            TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              validator: (text) {
                                if (text!.trim() == "") {
                                  return "Please Enter Room Title";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: "Title",
                                prefixIcon: Icon(Icons.title),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButton<RoomCategory>(
                               value: selectedCategory,
                                items: categories.map((cat)=>
                                    DropdownMenuItem<RoomCategory>(
                                        value: cat,
                                        child: Row(
                                      children: [
                                        Image.asset(cat.image),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(cat.name),
                                      ],
                                    ))).toList(),
                                onChanged: (category){
                                  if(category == null)
                                    {
                                      return;
                                    }else
                                    {
                                    selectedCategory = category;
                                    }
                                  setState(() {

                                  });
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              validator: (text) {
                                if (text!.trim() == "") {
                                  return "Please Enter Room Description";
                                }
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "Description",
                                prefixIcon: Icon(Icons.description),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              ValidateForm();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Create Room',
                                  style: TextStyle(color: colorGrey),
                                ),
                                Icon(Icons.create, color: colorGrey),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void ValidateForm(){
    if(formKey.currentState!.validate())
    {
      viewModeL.AddRoomToDB(
          titleController.text,
          descriptionController.text,
          selectedCategory.id
      );

    }
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  @override
  void RoomCreated() {
    Navigator.pop(context);
  }
}
