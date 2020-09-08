import 'package:MultiLogin/Authentication/auth.dart';
import 'package:MultiLogin/CommonComponents/reusableComponent.dart';
import 'package:MultiLogin/LoginPage/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  String userId = "";

  String emailError = '';
  String passwordError = '';
  String confirmpswdError = '';
  String roleError = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool isLightTheme;
  ScrollController _scrollController;
  AnimationController animController;
  Animation<Offset> offset;
  Authentication auth;
  String authError = '';
    bool _isLoading;
    final FirebaseDatabase _database = FirebaseDatabase.instance;
     List<Role> _years = Role.getCompanies();
  List<DropdownMenuItem<Role>> _dropdownRoleItems;
  Role _selectedRole;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
    });
    auth = new Authentication();
    _scrollController = ScrollController();
      _dropdownRoleItems = buildDropdownYearItems(_years);
    _selectedRole = _dropdownRoleItems[0].value;
  }

  @override
  void dispose() {
    super.dispose();
  }

    List<DropdownMenuItem<Role>> buildDropdownYearItems(List roles) {
    List<DropdownMenuItem<Role>> items = List();
    for (Role company in roles) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownYear(Role selectedrole) {
    setState(() {

      if (selectedrole.name == 'Select Role') {
        roleError = 'Enter Role';
      } else {
        roleError = "";
      }
      FocusScope.of(context).requestFocus(new FocusNode());
      _selectedRole = selectedrole;
    });
  }

  //Animate Scroll views up and down when keyboard appears and disappears
  scrollUpDownFields(double offset, int timeInMilliSec) {
    _scrollController.animateTo(offset,
        curve: Curves.linear, duration: Duration(milliseconds: timeInMilliSec));
  }

  Future<bool> _onWillPop() async {
    return Future.value(true);
  }


  Widget widgetRoleDropDown() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: new Container(
            width: (MediaQuery.of(context).size.width),
            child: new Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                    ),
                    child: new DropdownButton(
                      underline: new Container(
                          color:  Colors.grey,
                          height: 1.1),
                      isExpanded: true,
                      style: new TextStyle(
                        decoration: TextDecoration.none,
                        color:Colors.black38,
                        fontSize: 16.0,
                      ),
                      value: _selectedRole,
                      items: _dropdownRoleItems,
                      onChanged: onChangeDropdownYear,
                    )))));
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
          color: Colors.white,
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
          backgroundColor: Colors.blueAccent,
          resizeToAvoidBottomPadding: true,
          appBar: new AppBar(
            elevation: 0.0,
            leading: _buildScreenLeading(context),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 0, top: 5, right: 0),
            ),
            backgroundColor: Colors.grey,
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
                color: Colors.black38,
                fontWeight: FontWeight.bold),
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
                   _showCircularProgress(),
                authError != null && authError != ''
                    ? IndividualErrorContainer(errorMsg: authError)
                    : SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 0, top: 30),
                  child: EmailClass(
                    emailLength: 50,
                    emailController: _emailController,
                    emailErrormsg: emailError,
                    getChagnedValue: (value) {
                      setState(() {
                        emailError = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 0, top: 30),
                  child: PasswordClass(
                    passwordController: _passwordController,
                    securetext: true,
                    pswdErrorMsg: passwordError,
                    onChanged: (value) {
                      setState(() {
                        passwordError = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 40, top: 30),
                  child: PasswordClass(
                    placeholder: 'Confirm Password',
                    passwordController: _confirmpasswordController,
                    securetext: true,
                    pswdErrorMsg: confirmpswdError,
                    onChanged: (value) {
                      String cnfpswd = '';
                      if (value == 'Enter password') {
                        cnfpswd = 'Enter Confirm password';
                      } else if (value ==
                          'Password should be min 8 characters.') {
                        cnfpswd = 'Confirm $value';
                      } else if (value == 'Enter Valid Password') {
                        cnfpswd = 'Enter Valid Confirm Password';
                      } else {
                        cnfpswd = '';
                      }
                      setState(() {
                        confirmpswdError = cnfpswd;
                      });
                    },
                  ),
                ),
                widgetRoleDropDown(),
                roleError != null && roleError != ''
                    ? Padding(
                      padding: const EdgeInsets.only(left:30.0,right: 30.0),
                      child: IndividualErrorContainer(errorMsg: roleError),
                    )
                    : SizedBox(height: 0),
                    SizedBox(height: 30),
                LoginButtonClass(
                  height: 50,
                  buttonText: 'SignUp',
                  buttonAction: () {
                    signUp();
                  },
                  width: 350,
                  backgroundColor: Colors.black38,
                ),
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
   Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  bool validateRoleField(String value) {
    if (value == 'select Role') {
      roleError = 'Enter Role';
      return false;
    } else {
      roleError = '';
      return true;
    }
  }

  signUp() {
    if (_emailController.text == '' &&
        _passwordController.text == '' &&
        _confirmpasswordController.text == '' && _selectedRole.name == 'Select Role') {
      setState(() {
        emailError = 'Enter Email';
        passwordError = 'Enter Password';
        confirmpswdError = 'Enter Confirm Password';
        roleError = 'Enter Role';
      });
    } else {
      if (emailError == '' && passwordError == '' && confirmpswdError == '' && roleError == '' && _selectedRole.name != 'Select Role') {
        setState(() {
          _isLoading = true;
        });
        signupWithFirebase();
      }
      else
      {
        if(_selectedRole.name == 'Select Role')
        {
          setState(() {
            roleError = 'Enter Role';
          });
        }
      }

    }
  }

  signupWithFirebase() async {
    try {
      userId =
          await auth.signUp(_emailController.text, _passwordController.text);
      print('Signed up user: $userId');
      signUpDataBaseWithRole(userId,_selectedRole.name);
    } catch (e) {
      print('Error: $e');
      setState(() {
        authError = e.message;
        _isLoading = false;
      });
    }
  }
  signUpDataBaseWithRole(String userId,String role) async{
         Map<String, dynamic> dataObject = {'role':role};
         _database
            .reference()
            .child("UserRoles")
            .child(userId)
            .set(dataObject);
            setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
                msg: 'SignUp Successfull',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3);
             Navigator.of(context).pop();   
  }
}

class Role {
  int id;
  String name;

  Role(this.id, this.name);

  static List<Role> getCompanies() {
    return <Role>[
      Role(1, 'Select Role'),
      Role(2, 'Role1'),
      Role(3, 'Role2'),
    ];
  }
}
