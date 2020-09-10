import 'dart:async';

import 'package:MultiLogin/Authentication/auth.dart';
import 'package:MultiLogin/CommonComponents/reusableComponent.dart';
import 'package:MultiLogin/Profile/profile.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginComponent extends StatefulWidget {
  @override
  SampleLoginState createState() => SampleLoginState();
}
class SampleLoginState extends State<LoginComponent> {
   static const platform = const MethodChannel('samples.flutter.dev/battery');
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _textController = TextEditingController();
    final TextEditingController _alertTextController = TextEditingController();
   EmailClass email = new EmailClass();
   PasswordClass password = new PasswordClass();
      bool rememberValue = false;
  bool validaEmail = false;
  bool validPassword = false;
  bool isfirstTime = false;
  String emailError = '';
  String passwordError = '';
  bool _isLoading = false;
  String userId = '';
  Authentication auth;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String authError = '';

  @override
  void initState() {
    super.initState();
  auth = new Authentication();
  }

   Widget _buildScreenLeading(context) {
    return GestureDetector(
      onTap: () {
        // There is nowhere at the moment
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.keyboard_backspace,
          color:  Colors.white,
        ),
      ),
    );
  }

  Widget showText() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Container(
          alignment: Alignment.center,
          child: new Text(
            'Login',
            style: new TextStyle(
                fontSize: 32.0,
                color: Colors.black38,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          leading: _buildScreenLeading(context),
          elevation: 0.0,
          backgroundColor: Colors.grey,
        ),
      body: 
      Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           
            SizedBox(height: 80),
            showText(),
            _showCircularProgress(),
            authError != null && authError != ''
                    ? Padding(
                      padding: const EdgeInsets.only(left:30.0,right: 30.0),
                      child: IndividualErrorContainer(errorMsg: authError),
                    )
                    : SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 0,top: 10),
              child: EmailClass(
                emailLength: 50,
                emailController: _emailController,
             emailErrormsg: emailError,getChagnedValue: (value){
               setState(() {
                 emailError = value;
               });
             },),
            ),
            Padding(padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 10,top: 0),
            child: PasswordClass(passwordController: _passwordController,securetext: true,
           pswdErrorMsg: passwordError,onChanged: (value){
             setState(() {
               passwordError = value;
             });
           },),),
            LoginButtonClass(height: 50,buttonText: 'Login',buttonAction: (){

              login();
              // print('emial $emailError password $passwordError');
            },
            width: 350,
            backgroundColor: Colors.black38,),
            // Padding(
            //   padding: const EdgeInsets.only(left:30.0,right: 30.0),
            //   child: RememberMeClass(activeColor: Colors.grey,
            //   rememberCheckVaue: rememberValue,
            //   checkAction: (value){
            //     setState(() {
            //       rememberValue = !rememberValue;
            //     });
            //   },
            //   textColor: Colors.black,
            //   ),
            // ),
            SizedBox(height:200)
            
          ],
        ),

    );
  }
  login(){
    if(_emailController.text == '' && _passwordController.text == '')
    {
     setState(() {
      emailError = 'Enter email address';
      passwordError = 'Enter Pasword';
    });
    }
    else
    {
      if(emailError == '' && passwordError == '' && _emailController.text != '' && _passwordController.text != '')
      {
        setState(() {
          _isLoading = true;
        });
       loginFunction();
      }
      else
      {
        Fluttertoast.showToast(
                msg: 'Please fill all mandatory fields',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3);
      }
    }
  }
  loginFunction()async{
    FocusScope.of(context).requestFocus(FocusNode());
       try {
      userId =
          await auth.signIn(_emailController.text, _passwordController.text);
      print('Signed up user: $userId');
      getuserRole(userId);
    } catch (e) {
      print('Error: $e');
      setState(() {
        authError = e.message;
        _isLoading = false;
      });
    }
    }
    getuserRole(String userId) async{
      try {
  Map<dynamic,dynamic> getRecentObject;
    final dbRef =
        FirebaseDatabase.instance.reference().child("UserRoles").child(userId);
  await  dbRef.once().then((DataSnapshot snapshot) {
          getRecentObject = snapshot.value;
    });

    if(getRecentObject != null)
    {
       String userRole =  getRecentObject['role'];
       print('role is: $userRole');
       if(userRole == 'Role1')
       {
         
        //  Navigator.of(context).pushNamed("profile");
         Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(userId:userId,role: userRole,email: _emailController.text,)),
    );
    // setState(() {
    //        _emailController.text = '';
    //        _passwordController.text = '';
    //      });
       }
       else if(userRole == 'Role2')
       {
         setState(() {
           _emailController.text = '';
           _passwordController.text = '';
         });
         Navigator.of(context).pushNamed("role2_dashboard");
       }
       else
       {
         setState(() {
        authError = 'there is no user basing on this role';
      });
       }
    }
    else
    {
      setState(() {
        authError = 'something wentWrong with This user';
      });
    }
   setState(() {
     _isLoading = false;
   });
    } catch (e) {
      print('Error: $e');
      setState(() {
        authError = e.message;
        _isLoading = false;
      });
    }
       
    }
 
  Widget subChild(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  TextFormField(
          keyboardType: TextInputType.emailAddress,
          enabled: false,
          controller: _alertTextController,
          style: TextStyle(
              color: Colors.black38,
              fontSize: 16,
              fontWeight: FontWeight.normal,),
          cursorColor: Colors.grey, // Use email input type for emails.
          decoration: new InputDecoration(
            errorMaxLines: 3,
            hintStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[200],),
          ),
          // validator: validateEmail,
          onSaved: (value) {},
      ),
    );
  }


}