import 'package:chat_app/DatabaseUtils/databaseUtils.dart';
import 'package:chat_app/layout/base.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/shared/compontents/firebase_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../moduls/signUp/create_account_navigator.dart';

class CreateAccountViewModel extends BaseViewModeL<CreateAccountNavigator>{


  String message = "";
  void createAccountWithFirebaseAuth(String email, String password, String fName) async{
  try {
      navigator!.showLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: email,
     password: password,
    );
      message = "Account Created";
      MyUser myUser = MyUser(
          id: credential.user?.uid ?? "",
          fName: fName,
          email: email);
       DatabaseUtils.AddUserToFirestore(myUser).then((value){
        // Go To Home
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      });
  } on FirebaseAuthException catch (e) {
    if (e.code == FirebaseError.weakPassword) {
      message = "The password provided is too weak.";
  } else if (e.code == FirebaseError.emailUsed) {
      message = "The account already exists for that email...";
   }
  } catch (e) {
    message = "SomeThing Wrong $e";
  }

  if(message != ""){
    navigator!.hideDialog();
    navigator!.showMessage(message);
  }
 }
}