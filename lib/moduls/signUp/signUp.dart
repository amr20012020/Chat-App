import 'package:chat_app/layout/base.dart';
import 'package:chat_app/models/create_account_viewmodel.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/moduls/home/home.dart';
import 'package:chat_app/moduls/signUp/create_account_navigator.dart';
import 'package:chat_app/provider/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/style/colors.dart';

class SignUpScreen extends StatefulWidget{
  static const String routeName = "SignUp";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseView<SignUpScreen ,CreateAccountViewModel>
    implements CreateAccountNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  CreateAccountViewModel viewModel = CreateAccountViewModel();
  bool isPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
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
              title: Text('Create Account'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please Enter First Name";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "First Name",
                        prefixIcon: Icon(Icons.person),
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
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please Enter Email";
                        }else if(!text.toString().contains('@') || !text.toString().contains('.com')){
                          return 'ex: example@gmail.com';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return "Please Enter valid email";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        prefixIcon: Icon(Icons.email),
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
                    TextFormField(
                      controller: passwordController,
                      validator: (text) {
                        if (text!.trim() == "") {
                          return "Please Enter Password";
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                        suffix: isPassword ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
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
                      height: 5,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          ValidateForm();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Create Account',style: TextStyle(color: colorGrey),),
                            Icon(Icons.arrow_forward,color: colorGrey),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ValidateForm() async {
    if (formKey.currentState!.validate()) {
      viewModel.createAccountWithFirebaseAuth(
          emailController.text,
          passwordController.text,
          firstNameController.text);
      const SnackBar(
        content: Text('Added successfully'),
        backgroundColor: Colors.green,
      );
    }
  }



  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    // TODO: implement goToHome
    var provider = Provider.of<MyProvider>(context,listen: false);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
