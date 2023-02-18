import 'package:chat_app/DatabaseUtils/databaseUtils.dart';
import 'package:chat_app/layout/base.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/moduls/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/compontents/firebase_error.dart';

class LoginViewModel extends BaseViewModeL<LoginNavigator>{


  var auth = FirebaseAuth.instance;
  String message = "";

  void LoginWithFirebaseAuth(String email, String password)async{
    try {
      navigator!.showLoading();
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
     // message ="Login Successfully";
      MyUser? myUser = await DatabaseUtils.readUserFromFirestore(credential.user?.uid ?? "");
      if(myUser != null){
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      }
      const SnackBar(
        content: Text('Login successfully'),
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      message ="Wrong email or password";
    } catch (e) {
      message ="SomeThing Wrong $e";
    }

    if(message != ""){
      navigator!.hideDialog();
      navigator!.showMessage(message);
    }
  }


}