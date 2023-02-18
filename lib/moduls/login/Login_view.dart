import 'package:chat_app/layout/base.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/moduls/home/home.dart';
import 'package:chat_app/moduls/login/login_navigator.dart';
import 'package:chat_app/moduls/login/login_view_model.dart';
import 'package:chat_app/moduls/signUp/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/create_account_viewmodel.dart';
import '../../provider/my_provider.dart';
import '../../shared/style/colors.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen,LoginViewModel>  implements LoginNavigator{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
 // CreateAccountViewModel viewModel = CreateAccountViewModel();
  bool isPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModeL.navigator = this;
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create:(context) => viewModeL,
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
                title: Text('Login'),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            ValidateForm();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Login',style: TextStyle(color: colorGrey),),
                              Icon(Icons.arrow_forward,color: colorGrey),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Don\'t have account?',style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ));
                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
  void ValidateForm(){
     viewModeL.LoginWithFirebaseAuth(emailController.text, passwordController.text);

  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    var provider = Provider.of<MyProvider>(context, listen: false);
    Navigator.pushReplacementNamed(context,
        HomeScreen.routeName);
  }
}


