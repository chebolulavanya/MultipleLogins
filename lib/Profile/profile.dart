import 'dart:convert';
import 'package:MultiLogin/Authentication/auth.dart';
import 'package:MultiLogin/Profile/editProfile.dart';
import 'package:MultiLogin/Profile/profileModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

final String EDIT_ACTION = "EditAction";

class ProfileScreen extends StatefulWidget {
   ProfileScreen({Key key ,this.userId, this.email,this.role})
      : super(key: key);

  final String userId;
  final String email;
  final String role;
  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String userEmail = '';
  ProfileModel userModel;
  String firstnameValue = '';
  String lastnameValue = '';
  String accounnumberValue = '';
  String csoemailValue = '';
  String phonenumberValue = '';
  String connectionCodeValue = '';
  bool isVisibleBottomOverlay = false;
  bool isUserdataAvailable = false;
  String errorMessageData = '';
  bool totalPopUpheight = false;
  bool isSucessPopoverlay = false;
  bool isErrorContainer = false;
  String errorMsg = "";
  String firstNameError = '';
  String lastNameError = '';
  String phoneNumberError = '';
Authentication auth;
  SharedPreferences preferencesSystem;
  AnimationController animController;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    this.userModel = new ProfileModel();
    auth = new Authentication();
    getMyAccountDetails();

  }

  /** Fetch profile details over API*/
  void getMyAccountDetails() async {
  //   try {
  // Map<dynamic,dynamic> getRecentObject;
  //   final dbRef =
  //       FirebaseDatabase.instance.reference().child("UserRoles").child(widget.userId);
  // await  dbRef.once().then((DataSnapshot snapshot) {
  //         getRecentObject = snapshot.value;
  //   });
  //   }catch (e) {
  //     print('Error: $e');
  //     setState(() {
  //       errorMsg = e.message;
  //       _isLoading = false;
  //     });
  //   }
  
  }
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Profile'),
         automaticallyImplyLeading: false,
         actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.edit),
            onPressed: () => 
            {  
                Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen(userId:widget.userId,role: widget.role,email: widget.email,firstname: 'lavanya',lastname: 'chebolu',phonenumber: '99599098',)),
    )
            }
            
           ),
           new IconButton(
             icon: new Icon(Icons.power_settings_new),
            onPressed: () => 
            {
            auth.signOut(),
            Navigator.of(context).pop(null),    
            }
           ),
            
         ],
      ),
            backgroundColor: Colors.white,
            body: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(child: mainScreen()),
              ),
            ])));
  }

  // Widget getEditOverLay(BuildContext context) {
  //   return SlideTransition(
  //     position: offset,
  //     child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: <Widget>[
  //           EditMyAccountScreen(
  //               isErrorContainer: isErrorContainer,
  //               errorMsg: errorMsg,
  //               headerName: getGlobalString('edit_account_information'),
  //               totalHeight: Validator.getPopUpHeight(2),
  //               firstNameController: _firstNameameController,
  //               lastNameController: _lastNameController,
  //               phoneNumberController: _phoneNumberController,
  //               emailController: _emailController,
  //               firstNameError: firstNameError,
  //               lastNameError: lastNameError,
  //               phoneNumberError: phoneNumberError,
  //               mobileFormatter: _mobileFormatter,
  //               formKey: _formKey,
  //               closeBottomOverlay: () async {
  //                 await animController.reverse();
  //                 setState(() {
  //                   isVisibleBottomOverlay = false;
  //                   firstNameError = '';
  //                   phoneNumberError = '';
  //                   lastNameError = '';
  //                   errorMsg = '';
  //                 });
  //                 getControllerNames();
  //               },
  //               updateBottomOverlay: () {
  //                 bool isFirstNameAvailable =
  //                     validateFirstField(_firstNameameController.text);
  //                 bool isLastNameAvailable =
  //                     validateLastField(_lastNameController.text);
  //                 bool isPhoneNumberAvailbel =
  //                     validatePhoneField(_phoneNumberController.text);

  //                 if (isFirstNameAvailable &&
  //                     isLastNameAvailable &&
  //                     isPhoneNumberAvailbel) {
  //                   setState(() {
  //                     isErrorContainer = false;
  //                     phoneNumberError = '';
  //                     firstNameError = '';
  //                     lastNameError = '';
  //                   });
  //                   actionForEditAccount();
  //                 } else {
  //                   setState(() {
  //                     isErrorContainer = true;
  //                   });
  //                 }
  //               }),
  //         ]),
  //   );
  // }

  /**
   * Validate firstname field
   */
  validateFirstField(String value) {
    if (value == null || value == "" || value.length < 1) {
      firstNameError = 'Enter First name';
      return false;
    } else if (value.length > 25) {
      firstNameError = 'length should be max 25';
      return false;
    } else {
      firstNameError = '';
      return true;
    }
  }

  /**
   * Validate Lastname field
   */
  validateLastField(String value) {
    if (value == null || value == "" || value.length < 1) {
      lastNameError = 'enter last name';
      return false;
    } else if (value.length > 25) {
      lastNameError = 'length should be max 25';
      return false;
    } else {
      lastNameError = '';
      return true;
    }
  }

  /**
   * Validate Phone number field
   */
  // validatePhoneField(String value) {
  //   if (Validator.validateForPhonenumber(value) ==
  //       "Please enter mobile number") {
  //     phoneNumberError = '';
  //     return true;
  //   } else if (Validator.validateForPhonenumber(value) ==
  //       "Please enter valid mobile number") {
  //     phoneNumberError = getGlobalString('number_validation_msg');
  //     return false;
  //   } else if (Validator.validateForPhonenumber(value) ==
  //       "Please enter US format country code") {
  //     phoneNumberError = getGlobalString('number_validation_msg');
  //     return false;
  //   } else {
  //     phoneNumberError = '';
  //     return true;
  //   }
  // }

  Future<bool> _onWillPop() async {
    if (isVisibleBottomOverlay || isSucessPopoverlay) {
      await animController.reverse();
      setState(() {
        isVisibleBottomOverlay = false;
        isSucessPopoverlay = false;
      });
      return Future.value(false);
    }
    return Future.value(true);
  }

  /**
   * Main Widget of My account Screen
   */
  Widget mainScreen() {
    // return this.isUserdataAvailable ? fieldsData() : errorData();
    return fieldsData();
  }

  /**Success Main Container when successfully fetches profile data*/
  Widget fieldsData() {
    return Column(children: <Widget>[
      firstName(),
      smallShowSpace(),
      lasttName(),
      smallShowSpace(),
      smallShowSpace(),
      email(),
      smallShowSpace(),
      phoneNumber(),
      smallShowSpace(),
      role(),
      smallShowSpace(),
      lineSeperator(),
    ]);
  }

  /**Error Container */
  Widget errorData() {
    return Column(children: <Widget>[
      showSpace(),
      showSpace(),
      showSpace(),
      errorMessage(),
      smallShowSpace(),
      lineSeperator(),
    ]);
  }

  /**
   * Shows error message when api fails to return data
   */
  Widget errorMessage() {
    return new Padding(
      padding: EdgeInsets.all(15),
      child: Center(
          child: Text(this.errorMessageData,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ))),
    );
  }

  Widget showSpace() {
    final Size screenSize = MediaQuery.of(context).size;
    final double spaceHeight = screenSize.height * 0.065;
    return SizedBox(
      height: spaceHeight,
    );
  }

  Widget smallShowSpace() {
    final Size screenSize = MediaQuery.of(context).size;
    final double spaceHeight = screenSize.height * 0.03;
    return SizedBox(
      height: spaceHeight,
    );
  }

  /**First name label and value widgets of profile */
  Widget firstName() {
    return Padding(
      padding: const EdgeInsets.only(top: 26.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.only(left: 30),
              child: new Text(
                'First name',
                style: new TextStyle(
                    fontSize: 16.0,
                    color:  Colors.grey[500],
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              )),
          new Padding(
              padding: EdgeInsets.only(right: 30),
              child: new Text(
                this.firstnameValue ?? "not available",
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              ))
        ],
      ),
    );
  }

  /**Last name label and its value widgets of profile */
  Widget lasttName() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(left: 30),
            child: new Text(
              'Last name',
              // 'Last name',
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            )),
        new Padding(
            padding: EdgeInsets.only(right: 30),
            child: new Text(
              this.lastnameValue ?? 'not available',
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            ))
      ],
    );
  }

  /**Email label and its value widgets of profile */
  Widget email() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(left: 30),
            child: new Text(
              "email",
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            )),
        new Padding(
            padding: EdgeInsets.only(right: 30),
            child: new Text(
              widget.email,
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            ))
      ],
    );
  }

    Widget role() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(left: 30),
            child: new Text(
              "Role",
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            )),
        new Padding(
            padding: EdgeInsets.only(right: 30),
            child: new Text(
              widget.role,
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            ))
      ],
    );
  }

  /**Phone Number label and its value widgets of profile */
  Widget phoneNumber() {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(left: 30),
            child: new Text(
              'Phone number',
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            )),
        new Padding(
            padding: EdgeInsets.only(right: 30),
            child: new Text(
              this.phonenumberValue ?? 'not available',
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            ))
      ],
    );
  }

  Widget lineSeperator() {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(40.0),
      color: Colors.black38.withOpacity(0.5),
      width: screenSize.width / 1.20,
      height: 0.6,
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}

