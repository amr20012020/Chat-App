import 'package:chat_app/layout/base.dart';
import 'package:chat_app/models/user.dart';

abstract class LoginNavigator extends BaseNavigator{

  void goToHome(MyUser myUser);

}