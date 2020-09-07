

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {


  @override
  void initState() {
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
                preferredSize: Size.fromHeight(0.0), // here the desired height
                child: new AppBar(
                  automaticallyImplyLeading: false,
// leading: _buildScreenLeading(context),
                  elevation: 0.0,
                  backgroundColor: Colors.blueAccent,
                )),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(height: 50),
                showLogo(),
                showLoginButton(),
                showSignupButton(),
                Container(height: 50),
                // showTermaandconditions()
                /// For checking languages
                // Container(height: 50),
                // languageButtons()
                // skipButton()
              ],
            ),
          ),
        ));
  }

  Widget showSpace() {
    final Size screenSize = MediaQuery.of(context).size;
    //final double spaceWidth = screenSize.width * 0.3;
    final double spaceHeight = screenSize.height * 0.2;
    return SizedBox(
      height: spaceHeight,
    );
  }

  Widget showLogo() {
    return Image.asset(
      'assets/335-3358419_free-png-download-design-welcome-png-images-background.png',
      width: 180,//(MediaQuery.of(context).size.width) * 0.6,
      height: 80,
      fit: BoxFit.fill ,
    );
  }

  Widget showLoginButton() {
    final Size screenSize = MediaQuery.of(context).size;

    final double buttonHeight = screenSize.height * 0.06;
    return new Padding(
        padding: EdgeInsets.fromLTRB(30.0, 48.0, 30.0, 0.0),
        child: SizedBox(
          height: buttonHeight,
          width: MediaQuery.of(context).size.width,
          child: new RaisedButton(
            key: Key("login_button"),
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12.0)),
            color: Colors.grey,
            child: new Text(
              // Util.Login,
                "Login",
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,)),
            onPressed: () {
              Navigator.of(context).pushNamed("login_page");
            },
          ),
        ));
  }

  Widget showSignupButton() {
    final Size screenSize = MediaQuery.of(context).size;

    final double buttonHeight = screenSize.height * 0.06;
    return new Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 15.0),
        child: SizedBox(
          height: buttonHeight,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            key: Key("sign_up_button"),
            onPressed: () {
              Navigator.of(context).pushNamed("signup_page");
            },
            child: new Text(
              // Util.Signup,
               "SgnUp",
                style: new TextStyle(
                    fontSize: 16.0,
                    color:Colors.white,
                    fontWeight: FontWeight.w500,)),
            color: Colors.black38,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12.0), 
                side: BorderSide(
        width: 1,
        color:  Colors.transparent,
      ),),
          ),
        ));
  }

}


