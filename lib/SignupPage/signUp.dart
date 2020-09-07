
import 'package:MultiLogin/CommonComponents/reusableComponent.dart';
import 'package:MultiLogin/LoginPage/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// class SignupPageRoute extends CupertinoPageRoute {
//   SignupPageRoute()
//       : super(builder: (BuildContext context) => new SignUpScreen());
// }

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _signupformKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _passwordobscureText = true;
  bool _confirmpasswordobscureText = true;
  String userId = "";
  bool _termsandconditions = true;
  bool isVisibleBottomOverlay = false;
  String messageType;
  String message;
  String errorMsg = "";
  String emailError = '';
  String passwordError = '';
  String confirmpswdError = '';
  bool isPopUpShown = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool isLightTheme;
  ScrollController _scrollController;
  int _keyboardVisibilitySubscriberId;
  AnimationController animController;
  Animation<Offset> offset;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }


  @override
  void dispose() {
    super.dispose();
  }

  //Animate Scroll views up and down when keyboard appears and disappears
  scrollUpDownFields(double offset, int timeInMilliSec) {
    _scrollController.animateTo(offset,
        curve: Curves.linear, duration: Duration(milliseconds: timeInMilliSec));
  }


  Future<bool> _onWillPop() async {
    if (isVisibleBottomOverlay) {
      await animController.reverse();
      setState(() {
        isVisibleBottomOverlay = false;
      });
      return Future.value(false);
    }
    return Future.value(true);
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          appBar: new AppBar(
            elevation: 0.0,
            leading: _buildScreenLeading(context),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 0, top: 8, right: 0),
            ),
            backgroundColor: Colors.white,
          ),
          body: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(
              0.0,
              0.0,
              0.0,
            ),
            child: Stack(
              children: <Widget>[
                Scrollbar(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: _showForm(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: FlatButton(
                              onPressed: () {
                                  Navigator.of(context).pushNamed("login_page");
                              },
                              color: Colors.white,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
         
              ],
            ),
          )),
    );
  }

Widget showText() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Container(
          alignment: Alignment.center,
          child: new Text(
            'Sign Up',
            style: new TextStyle(
                fontSize: 32.0,
                color:  Colors.black38,
                fontWeight: FontWeight.bold ),
          ),
        ));
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: new Form(
            key: this._signupformKey,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                showSpace(),
                showText(),
                Padding(
              padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 0,top: 30),
              child: EmailClass(emailController: _emailController,
             emailErrormsg: emailError,getChagnedValue: (value){
               setState(() {
                 emailError = value;
               });
             },),
            ),
            Padding(padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 0,top: 30),
            child: PasswordClass(passwordController: _passwordController,securetext: true,
           pswdErrorMsg: passwordError,onChanged: (value){
             setState(() {
               passwordError = value;
             });
           },),),
           Padding(padding: const EdgeInsets.only(left:30.0,right: 30.0,bottom: 40,top: 30),
            child: PasswordClass(placeholder: 'Confirm Password', passwordController: _confirmpasswordController,securetext: true,
           pswdErrorMsg: confirmpswdError,onChanged: (value){
             String cnfpswd = '';
             if(value == 'Enter password')
             {
               cnfpswd = 'Enter Confirm password';
             }
             else if(value == 'Password should be min 8 characters.')
             {
               cnfpswd = 'Confirm $value';
             }
             else if(value == 'Enter Valid Password')
             {
               cnfpswd = 'Enter Valid Confirm Password';
             }
             else
             {
               cnfpswd = '';
             }
             setState(() {
               confirmpswdError = cnfpswd ;
             });
           },),),
            LoginButtonClass(height: 50,buttonText: 'SignUp',buttonAction: (){
               signUp();
            },
            width: 350,
            backgroundColor: Colors.black38,),
              ],
            )));
  }

  Widget spaceNearShowText() {
    return SizedBox(
      height: 91,
    );
  }

  Widget showSpace() {
    final Size screenSize = MediaQuery.of(context).size;
    final double spaceHeight = screenSize.height * 0.075;
    return SizedBox(
      height: spaceHeight,
    );
  }

  Widget spaceAfterShowText() {
    return SizedBox(
      height: 89,
    );
  }

  signUp(){

    if(_emailController.text == '' && _passwordController.text == '' && _confirmpasswordController.text == '')
    {
      setState(() {
        emailError = 'Enter Email';
        passwordError = 'Enter Password';
        confirmpswdError = 'Enter Confirm Password';
      });
    }
    else
    {
      if(emailError == '' && passwordError == '' && confirmpswdError == '')
      {
        print('success');
      }
    }
  }



/* Social logins commented for now
  Widget widgetSocialLoginButtons() {
    final Size screenSize = MediaQuery.of(context).size;
    //final double loginBtnWidth = screenSize.width * 0.2;
    final double loginBtnHeight = screenSize.height * 0.02;
    final double spaceHeight = screenSize.height * 0.04;
    final double fbLogoHeight = screenSize.height * 0.05;
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, loginBtnHeight, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                facebookLogin();
              },
              elevation: 0.0,
              color: Colors.transparent,
              child: Image.asset(
                'assets/Facebook-logo-black.png',
                height: fbLogoHeight,
                width: fbLogoHeight,
              ),
            ),
            Container(
              width: spaceHeight,
            ),
            RaisedButton(
              onPressed: () {
                signInWithGoogle();
              },
              elevation: 0.0,
              color: Colors.transparent,
              child: Image.asset(
                'assets/gmail_icon.png',
                height: fbLogoHeight,
                width: fbLogoHeight,
              ),
            ),
          ],
        ));
  }
*/



/* Social logins commented for now
  Future facebookLogin() async {
    bool checkConnectivity = await NetworkHandler.networkChecking(context);
    if (checkConnectivity) {
      try {
        Dialogs.showLoadingDialog(context);
        _firebaseUser = await auth.facebooksignIn();

        if (_firebaseUser != null) {
          this.socialApiRequest("facebook");
          // this.navigateScreen("facebook");
        } else {
          Dialogs.dismissLoadingDialog(context);
          setState(() {
            isPopUpShown = true;
            errorMsg = getGlobalString("facebook_error_msg");
          });
          // AlertHandler.alertDisplay(context," An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.");
        }
      } catch (e) {
        print('Error: $e');
        Dialogs.dismissLoadingDialog(context);
        setState(() {
          isPopUpShown = true;
          errorMsg = e.toString() ?? getGlobalString('something_went_wrong');
        });
        //AlertHandler.alertDisplay(context, e.toString());
      }
    }

    // fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // if you remove above comment then facebook login will take username and pasword for login in Webview
  }

  Future signInWithGoogle() async {
    //return 'signInWithGoogle succeeded: $user';
    bool value = await NetworkHandler.networkChecking(context);
    if (value) {
      Dialogs.showLoadingDialog(context);
      try {
        _firebaseUser = await auth.googlesignIn(context);
        if (_firebaseUser != null) {
          this.socialApiRequest("google");
        } else {
          Dialogs.dismissLoadingDialog(context);
        }
      } catch (e) {
        print('Error: $e');
        Dialogs.dismissLoadingDialog(context);
        AlertHandler.alertDisplay(context, e.toString());
      }
    }
  }*/

  /*

  Future socialApiRequest(String providerId) async {
    Map map = {
      "email": _firebaseUser.email,
      "provider": providerId,
      "providerToken": _firebaseUser.getIdToken().toString()
    };
    HttpServiceHandler handler = new HttpServiceHandler();
    ServiceModel model =
        await handler.servicePostMethod(map, Services.SOCIAL_AUTH_URL);
    if (model.status == true) {
      if (model.value.statusCode == 200) {
        // print("resonse =  $response.stst");
        // String reply = await model.value.transform(utf8.decoder).join();
        // final jsonResponse = json.decode(reply);
        preferencesSystem.setBool(Constants.PREFERENCES_KEY_IS_LOGGED, true);
        this.navigateScreen(providerId);

        // loginSuccess(reply);
        // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

        // widget.loginCallback();

      } else if (model.value.statusCode != 200) {
        Dialogs.dismissLoadingDialog(context);
        var message =
            Validator.errorResponseWithErrorCodes(model.value.statusCode);
        setState(() {
          isPopUpShown = true;
          errorMsg = message;
        });
      } else {
        String reply = await model.value.transform(utf8.decoder).join();
        final jsonResponse = json.decode(reply);
        Dialogs.dismissLoadingDialog(context);
        //AlertHandler.alertDisplay(context, jsonResponse.toString());
        setState(() {
          isPopUpShown = true;
          errorMsg = jsonResponse?.toString() ??
              getGlobalString('something_went_wrong');
        });
      }
    } else {
      Dialogs.dismissLoadingDialog(context);
      setState(() {
        isPopUpShown = true;
        errorMsg =
            model?.value?.toString() ?? getGlobalString('something_went_wrong');
      });
      //AlertHandler.alertDisplay(context, model.value.toString());
    }
  }*/

}
