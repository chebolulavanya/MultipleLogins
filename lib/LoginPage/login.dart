import 'dart:async';

import 'package:MultiLogin/CommonComponents/reusableComponent.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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

  @override
  void initState() {
    super.initState();
  
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

    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          leading: _buildScreenLeading(context),
          elevation: 0.0,
          backgroundColor: Colors.blueAccent,
        ),
      body: 
      Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           
            SizedBox(height: 180),
            Padding(
              padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 0,top: 10),
              child: EmailClass(emailController: _emailController,
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
            Padding(
              padding: const EdgeInsets.only(left:30.0,right: 30.0),
              child: RememberMeClass(activeColor: Colors.grey,
              rememberCheckVaue: rememberValue,
              checkAction: (value){
                setState(() {
                  rememberValue = !rememberValue;
                });
              },
              textColor: Colors.black,
              ),
            ),
          //   Row(
          //      mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          //     children: [
          //       FaceBookLoginClass(onTapFacebookLogin: (value){
          //       print('facebook data $value');
          //     },
          //     image: 'assets/facebook.png',),
          //     GoogleLoginClass(onTapGoogleLogin: (value){
          //       print('account ** $value');
          //      print('iam google');
          //     },
          //     image: 'assets/Google.png',)
          //     ],
                          
          //   ),
            // TextFieldClass(),
            // ListClass(height: 100,errorMessage: 'no data available',datalistArray: _listViewData,subChild: (index){
            //   return Text('$index lavanya here');
            // },)
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
      if(emailError == '' && passwordError == '')
      {
        print('success');
      }
    }
    
    
    // BottomTabComponent
    // if(emailError == "" && passwordError == "")
    // {
      // Navigator.of(context).pushNamed("login_page");
    // }
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