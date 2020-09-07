import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity/connectivity.dart';

class EmailClass extends StatefulWidget {
  TextEditingController emailController = TextEditingController();
  String placeholder;
  Color textColor;
  double fontSize;
  FontWeight fontWeight;
  bool autoCorrect;
  bool enableSuggestion;
  String fontFamily;
  Color cursorColor;
  Color labelTextColor;
  Color borderColor;
  Color focusBorderColor;
  double hintTextSize;
  Color hintTextColr;
  Function getChagnedValue;
  String emailRegex;
  String emailErrormsg;
  int emailLength;
  String emailError;
  

  @override
  EmailState createState() => new EmailState();
  EmailClass(
      {this.placeholder,
      this.hintTextColr,
      this.fontSize,
      this.emailController,
      this.getChagnedValue,
      this.textColor,
      this.emailLength,
      this.emailRegex,
      this.hintTextSize,
      this.focusBorderColor,
      this.borderColor,
      this.cursorColor,
      this.fontFamily,
      this.enableSuggestion,
      this.autoCorrect,
      this.emailErrormsg,
      this.fontWeight,
      this.labelTextColor});
}

class EmailState extends State<EmailClass> {
  String emailError = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new TextFormField(
          autocorrect: widget.autoCorrect != null ? widget.fontWeight : false,
          enableSuggestions:
              widget.enableSuggestion != null ? widget.enableSuggestion : false,
          controller: widget.emailController,
          style: TextStyle(
              color: widget.textColor != null ? widget.textColor : Colors.black,
              fontSize: widget.fontSize != null ? widget.fontSize : 14,
              fontWeight: widget.fontWeight != null
                  ? widget.fontWeight
                  : FontWeight.normal,
              fontFamily:
                  widget.fontFamily != null ? widget.fontFamily : 'Ubuntu'),
          cursorColor:
              widget.cursorColor != null ? widget.fontFamily : Colors.grey,
          keyboardType:
              TextInputType.emailAddress, // Use email input type for emails.
          inputFormatters: [
            new LengthLimitingTextInputFormatter(
                widget.emailLength != null ? widget.emailLength : 20),
            BlacklistingTextInputFormatter(new RegExp('[ -]'))
          ],
          decoration: new InputDecoration(
              labelStyle: TextStyle(
                color: widget.labelTextColor != null
                    ? widget.labelTextColor
                    : Colors.grey,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor != null
                        ? widget.borderColor
                        : Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: widget.focusBorderColor != null
                        ? widget.focusBorderColor
                        : Colors.grey),
              ),
              hintText:
                  widget.placeholder != null ? widget.placeholder : 'Email',
              hintStyle: TextStyle(
                fontSize:
                    widget.hintTextSize != null ? widget.hintTextSize : 12.0,
                color: widget.hintTextColr != null
                    ? widget.hintTextColr
                    : Colors.grey,
              ),
              labelText:
                  widget.placeholder != null ? widget.placeholder : 'Email'),
          onChanged: (value) {
            String error = validateEmail(value);
            print(error);
          },
        ),
        widget.emailErrormsg != null && widget.emailErrormsg != ''
            ? IndividualErrorContainer(errorMsg: widget.emailErrormsg)
            : SizedBox(height: 0),
      ],
    );
  }

  String validateEmail(String value) {
    String emaiR = widget.emailRegex != null
        ? widget.emailRegex
        : r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool emailValid = RegExp(emaiR).hasMatch(value);
    if (value == '') {
      widget.getChagnedValue('Enter email address');
      // setState(() {
      //   widget.emailError = widget.emailErrormsg != null
      //       ? widget.emailErrormsg: 'Enter email address';
      // });
      return 'Enter email address';
    } else if (!emailValid) {
      widget.getChagnedValue('Enter valid email address');
      // setState(() {
      //   widget.emailError = widget.emailErrormsg != null
      //       ? widget.emailErrormsg
      //       : 'Enter valid email address';
      // });
      return widget.emailErrormsg != null
          ? widget.emailErrormsg
          : 'Enter valid email address';    
    } else {
      widget.getChagnedValue('');
      // setState(() {
      //   widget.emailError = '';
      // });
      return null;
    }
  }
}

class IndividualErrorContainer extends StatelessWidget {
  final String errorMsg;

  IndividualErrorContainer({
    this.errorMsg,
  });
  @override
  Widget build(BuildContext context) {
    return errorPopup(context);
  }

  Widget errorPopup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minWidth: 10.0,

          //maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            alignment: Alignment.bottomLeft,
            decoration: new BoxDecoration(
                color: Colors.redAccent,
                borderRadius: new BorderRadius.circular(15)),
            child: ConstrainedBox(
              constraints: new BoxConstraints(
                minWidth: 20,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 5, bottom: 5, right: 15),
                child: Text(
                  errorMsg,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordClass extends StatefulWidget {
  TextEditingController passwordController = TextEditingController();
  String placeholder;
  Color textColor;
  double fontSize;
  FontWeight fontWeight;
  bool autoCorrect;
  bool enableSuggestion;
  String fontFamily;
  Color cursorColor;
  Color labelTextColor;
  Color borderColor;
  Color focusBorderColor;
  double hintTextSize;
  Color hintTextColr;
  Function onChanged, iconTap;
  String passwordRegex;
  String pswdErrorMsg;
  int passwordLength;
  bool securetext;
  String eyeOpenImage, eyeCloseImage;
  String passworderror;

  @override
  PasswordState createState() => new PasswordState();
  PasswordClass(
      {this.placeholder,
      this.hintTextColr,
      this.fontSize,
      this.passwordController,
      this.onChanged,
      this.textColor,
      this.passwordLength,
      this.passwordRegex,
      this.hintTextSize,
      this.focusBorderColor,
      this.borderColor,
      this.cursorColor,
      this.fontFamily,
      this.enableSuggestion,
      this.autoCorrect,
      this.pswdErrorMsg,
      this.fontWeight,
      this.labelTextColor,
      this.eyeCloseImage,
      this.eyeOpenImage,
      this.securetext,
      this.iconTap});
}

class PasswordState extends State<PasswordClass> {
  String passworderror = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            TextFormField(
                controller: widget.passwordController,
                style: TextStyle(
                    color: widget.textColor != null
                        ? widget.textColor
                        : Colors.black,
                    fontSize: widget.fontSize != null ? widget.fontSize : 14,
                    fontWeight: widget.fontWeight != null
                        ? widget.fontWeight
                        : FontWeight.normal,
                    fontFamily: widget.fontFamily != null
                        ? widget.fontFamily
                        : 'Ubuntu'),
                cursorColor: widget.cursorColor != null
                    ? widget.fontFamily
                    : Colors.grey,
                obscureText: widget.securetext != null
                    ? widget.securetext
                    : true, // Use email input type for emails.
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(
                      widget.passwordLength != null
                          ? widget.passwordLength
                          : 20),
                  BlacklistingTextInputFormatter(new RegExp('[ -]')),
                ],
                decoration: new InputDecoration(
                  labelStyle: TextStyle(
                    color: widget.labelTextColor != null
                        ? widget.labelTextColor
                        : Colors.grey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.borderColor != null
                            ? widget.borderColor
                            : Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.focusBorderColor != null
                            ? widget.focusBorderColor
                            : Colors.grey),
                  ),
                  errorMaxLines: 3,
                  hintText: widget.placeholder != null
                      ? widget.placeholder
                      : 'Password',
                  // 'Enter password',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: widget.hintTextColr != null
                        ? widget.hintTextColr
                        : Colors.grey,
                  ),
                  labelText: widget.placeholder != null
                      ? widget.placeholder
                      : 'Password',
                  // Util.Password_placeholder,
                ),
                onChanged: (value) {
                  validatePassword(value);
                }
                // validator: this._validatePassword,
                // validator: Validator.validatePassword,
                ),
            Positioned(
              right: 20,
              bottom: 20,
              child: Container(
                height: 15.53,
                width: 25.34,
                child: Container(
                  child: Material(
                      shape: CircleBorder(),
                      color: Colors.transparent,
                      child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {
                            setState(() {
                              widget.securetext = !widget.securetext;
                            });
                          },
                          splashColor: Colors.grey,
                          child: Icon(
                            widget.securetext
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[400],
                          ))),
                ),
              ),
            ),
          ],
        ),
        widget.pswdErrorMsg != null && widget.pswdErrorMsg != ''
            ? IndividualErrorContainer(errorMsg: widget.pswdErrorMsg)
            : SizedBox(height: 0),
      ],
    );
  }

  String validatePassword(String value) {
    String passwordR = widget.passwordRegex != null
        ? widget.passwordRegex
        : r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(passwordR);
    print(value);
    if (value.isEmpty) {
      widget.onChanged('Enter password');
      // setState(() {
      //   widget.passworderror = widget.pswdErrorMsg != null
      //         ? widget.pswdErrorMsg
      //         :  'Enter password';
      // });
      return 'Enter password';
    } else if (value.length < 8) {
        widget.onChanged('Password should be min 8 characters.');
      // setState(() {
      //   widget.passworderror = widget.pswdErrorMsg != null
      //         ? widget.pswdErrorMsg
      //         :  'Password should be min 8 characters';
      // });
      return 'Password should be min 8 characters.';
    } else {
      widget.onChanged('Enter Valid Password');
      if (!regex.hasMatch(value)) {
        // setState(() {
        //   widget.passworderror = widget.pswdErrorMsg != null
        //       ? widget.pswdErrorMsg
        //       : 'Enter Valid Password';
        // });
        return widget.pswdErrorMsg != null
            ? widget.pswdErrorMsg
            : 'Enter Valid Password';
      } else {
          widget.onChanged('');
        // setState(() {
        //   widget.passworderror = '';
        // });
        return null;
      }

      // return '';
    }
  }
}

class LoginButtonClass extends StatefulWidget {
  double height;
  double width;
  double borderRadius;
  Color borderColor;
  Color backgroundColor;
  String buttonText;
  String textFont;
  Color textColor;
  FontWeight fontWeight;
  Function buttonAction;
  double fontSize;

  @override
  LoginButtonState createState() => new LoginButtonState();
  LoginButtonClass(
      {this.textColor,
      this.backgroundColor,
      this.fontWeight,
      this.borderRadius,
      this.buttonAction,
      this.fontSize,
      this.buttonText,
      this.height,
      this.textFont,
      this.width,
      this.borderColor});
}

class LoginButtonState extends State<LoginButtonClass> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: new Container(
            // alignment: Alignment.center,
            child: SizedBox(
          height: widget.height != null ? widget.height : 30,
          width: widget.width != null ? widget.width : 200,
          child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  side: BorderSide(
                      color: widget.borderColor != null
                          ? widget.borderColor
                          : Colors.white),
                  borderRadius: new BorderRadius.circular(
                      widget.borderRadius != null
                          ? widget.borderRadius
                          : 25.0)),
              color: widget.backgroundColor != null
                  ? widget.backgroundColor
                  : Colors.grey,
              child: new Text(
                  widget.buttonText != null ? widget.buttonText : 'Login',
                  style: new TextStyle(
                      fontSize: widget.fontSize != null ? widget.fontSize : 15,
                      color: widget.textColor != null
                          ? widget.textColor
                          : Colors.white,
                      fontWeight: widget.fontWeight != null
                          ? widget.fontWeight
                          : FontWeight.bold)),
              onPressed: widget.buttonAction),
        )),
      )
    ]);
  }
}

class RememberMeClass extends StatefulWidget {
  Color themeColor;
  bool rememberCheckVaue;
  Color activeColor;
  Color checkColor;
  String rememberText;
  String textFont;
  Color textColor;
  FontWeight fontWeight;
  double fontSize;
  Function checkAction;

  @override
  RememberMeState createState() => new RememberMeState();
  RememberMeClass(
      {this.textFont,
      this.fontWeight,
      this.fontSize,
      this.rememberText,
      this.rememberCheckVaue,
      this.checkColor,
      this.activeColor,
      this.textColor,
      this.themeColor,
      this.checkAction});
}

class RememberMeState extends State<RememberMeClass> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor:
                widget.themeColor != null ? widget.themeColor : Colors.grey,
          ),
          child: Checkbox(
            value: widget.rememberCheckVaue != null
                ? widget.rememberCheckVaue
                : false,
            activeColor:
                widget.activeColor != null ? widget.activeColor : Colors.grey,
            checkColor:
                widget.checkColor != null ? widget.checkColor : Colors.white,
            onChanged: (rememberMe) {
              widget.checkAction(rememberMe);
            },
          ),
        ),
        Text(
          widget.rememberText != null ? widget.rememberText : 'Remember Me',
          style: TextStyle(
              fontSize: widget.fontSize != null ? widget.fontSize : 14,
              color: widget.textColor != null ? widget.textColor : Colors.grey,
              fontWeight: widget.fontWeight != null
                  ? widget.textFont
                  : FontWeight.normal),
        ),
      ],
    );
  }
}

class FaceBookLoginClass extends StatefulWidget {
  Function onTapFacebookLogin;
  String image;
  double height;
  double width;

  @override
  FaceBookLoginState createState() => new FaceBookLoginState();
  FaceBookLoginClass(
      {this.onTapFacebookLogin, this.image, this.height, this.width});
}

class FaceBookLoginState extends State<FaceBookLoginClass> {
  String _message = 'Log in/out by pressing the buttons below.';
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Padding(
        key: Key('social buttons'),
        padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: faceBookLogin,
              elevation: 0.0,
              highlightElevation: 0.0,
              color: Colors.transparent,
              child: Image.asset(
                widget.image != null ? widget.image : 'assets/facebook.png',
                height: widget.height != null ? widget.height : 50,
                width: widget.width != null ? widget.width : 50,
              ),
            ),
          ],
        ));
  }

  faceBookLogin() async {
    print('iam facebook');
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        widget.onTapFacebookLogin(result);
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }
}

class GoogleLoginClass extends StatefulWidget {
  Function onTapGoogleLogin;
  String image;
  double height;
  double width;

  @override
  GoogleLoginState createState() => new GoogleLoginState();
  GoogleLoginClass(
      {this.onTapGoogleLogin, this.image, this.width, this.height});
}

class GoogleLoginState extends State<GoogleLoginClass> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      widget.onTapGoogleLogin(_googleSignIn.currentUser);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: Key('social buttons'),
        padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: _handleSignIn,
              elevation: 0.0,
              highlightElevation: 0.0,
              color: Colors.transparent,
              child: Image.asset(
                widget.image != null ? widget.image : 'assets/Google.png',
                height: widget.height != null ? widget.height : 50,
                width: widget.width != null ? widget.width : 50,
              ),
            ),
          ],
        ));
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();

String getNetworkString(Map<dynamic, dynamic> _source){
    String connectionString;
switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        connectionString = "Offline";
         Fluttertoast.showToast(
                msg: connectionString,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3);
          return connectionString;
        break;
      case ConnectivityResult.mobile:
        connectionString = "Online";
          Fluttertoast.showToast(
                msg: connectionString,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3);
          return connectionString;
        break;
      case ConnectivityResult.wifi:
        connectionString = "Online";
          Fluttertoast.showToast(
                msg: connectionString,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3);
          return connectionString;
        break;
      default :
      return '';
      break;  
    }
  }
}

class ListClass extends StatefulWidget {
 
  double height;
  double width;
  Function didTap;
  Widget subChildWidget;
  String errorMessage;
  String textFont;
  Color textColor;
  FontWeight fontWeight;
  double fontSize;
 List<dynamic>  datalistArray;
 dynamic emptyObject;
 Function(int) subChild;

// ListClass({Key key, this.subChild}) : super(key: key);

  @override
  ListState createState() => new ListState();
  ListClass(
      { this.width, this.height, this.didTap,this.subChildWidget,this.errorMessage,this.fontSize,this.fontWeight,this.textColor,
      this.textFont,this.datalistArray, this.subChild});
}

class ListState extends State<ListClass> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        key: Key('social buttons'),
        padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0.0),
        child: dataList());
  }

   Widget dataList() {
    return Container(
      height: widget.height != null ? widget.height : MediaQuery.of(context).size.height / 2,
      child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 50),
          child:
               widget.datalistArray != null  
                  ?
              dataListView()
          : errorClass(),
          ),
    );
  }


  Widget dataListView() {
    return
         widget.datalistArray.length != 0
            ?
        ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  color: Colors.transparent,
                ),
            padding: EdgeInsets.only(top: 10),
            itemCount: widget.datalistArray.length != null ? widget.datalistArray.length : 0,
            itemBuilder: (context, index) {
              return Container(child:widget.subChild(index),color: Colors.transparent,) ;
            }
            )
    : errorClass();
  }
  Widget errorClass(){
     return new Padding(
      padding: EdgeInsets.all(15),
      child: Center(
          child: Text(widget.errorMessage != null ? widget.errorMessage : 'No Data Found',
              style: TextStyle(
                color: widget.textColor != null ? widget.textColor : Colors.black,
                fontWeight: widget.fontWeight != null ? widget.fontWeight : FontWeight.bold,
                fontSize: widget.fontSize != null ? widget.fontSize : 16,
              ))),
    );
  }
}

class TextFieldClass extends StatefulWidget {
  TextEditingController emailController = TextEditingController();
  String placeholder;
  Color textColor;
  double fontSize;
  FontWeight fontWeight;
  bool autoCorrect;
  bool enableSuggestion;
  String fontFamily;
  Color cursorColor;
  Color labelTextColor;
  Color borderColor;
  Color focusBorderColor;
  double hintTextSize;
  Color hintTextColr;
  Function getChagnedValue;
  String errormsg;
  int length;
  String error;
  

  @override
  TextFieldState createState() => new TextFieldState();
  TextFieldClass(
      {this.placeholder,
      this.hintTextColr,
      this.fontSize,
      this.emailController,
      this.getChagnedValue,
      this.textColor,
      this.length,
      this.hintTextSize,
      this.focusBorderColor,
      this.borderColor,
      this.cursorColor,
      this.fontFamily,
      this.enableSuggestion,
      this.autoCorrect,
      this.errormsg,
      this.fontWeight,
      this.labelTextColor});
}

class TextFieldState extends State<TextFieldClass> {
  String emailError = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new TextFormField(
          autocorrect: widget.autoCorrect != null ? widget.fontWeight : false,
          enableSuggestions:
              widget.enableSuggestion != null ? widget.enableSuggestion : false,
          controller: widget.emailController,
          style: TextStyle(
              color: widget.textColor != null ? widget.textColor : Colors.black,
              fontSize: widget.fontSize != null ? widget.fontSize : 14,
              fontWeight: widget.fontWeight != null
                  ? widget.fontWeight
                  : FontWeight.normal,
              fontFamily:
                  widget.fontFamily != null ? widget.fontFamily : 'Ubuntu'),
          cursorColor:
              widget.cursorColor != null ? widget.fontFamily : Colors.grey,
          keyboardType:
              TextInputType.emailAddress, // Use email input type for emails.
          inputFormatters: [
            new LengthLimitingTextInputFormatter(
                widget.length != null ? widget.length : 20),
            BlacklistingTextInputFormatter(new RegExp('[ -]'))
          ],
          decoration: new InputDecoration(
              labelStyle: TextStyle(
                color: widget.labelTextColor != null
                    ? widget.labelTextColor
                    : Colors.grey,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor != null
                        ? widget.borderColor
                        : Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: widget.focusBorderColor != null
                        ? widget.focusBorderColor
                        : Colors.grey),
              ),
              hintText:
                  widget.placeholder != null ? widget.placeholder : 'TextField',
              hintStyle: TextStyle(
                fontSize:
                    widget.hintTextSize != null ? widget.hintTextSize : 12.0,
                color: widget.hintTextColr != null
                    ? widget.hintTextColr
                    : Colors.grey,
              ),
              labelText:
                  widget.placeholder != null ? widget.placeholder : 'TextField'),
          onChanged: (value) {
            widget.getChagnedValue(value);
          },
        ),
        widget.errormsg != null && widget.errormsg != ''
            ? IndividualErrorContainer(errorMsg: widget.errormsg)
            : SizedBox(height: 0),
      ],
    );
  }
}