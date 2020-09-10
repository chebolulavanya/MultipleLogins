
import 'package:MultiLogin/CommonComponents/reusableComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';


class EditProfileScreen extends StatefulWidget {
   EditProfileScreen({Key key ,this.userId, this.email,this.role,this.firstname,this.lastname,this.phonenumber})
      : super(key: key);

  final String userId;
  final String email;
  final String role;
  final String firstname;
  final String lastname;
  final String phonenumber;
  @override
  EditProfileScreenState createState() => new EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {

  final TextEditingController firstNameController  = TextEditingController();
  final TextEditingController lastNameController  = TextEditingController();
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  var maskTextInputFormatter = MaskTextInputFormatter(
      mask: "+#-###-###-####", filter: {"#": RegExp(r'[0-9]')});
  GlobalKey formKey;
   double totalHeight;
   int numberOfFields;
   String headerName;
   bool isErrorContainer;
   String errorMsg;
  String firstNameError;
  String lastNameError;
  String phoneNumberError;

@override
  void initState() {
    super.initState();
    setState(() {
      emailController.text = widget.email;
    });

  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        appBar: new AppBar(
           title: Text('Edit profile'),
          elevation: 0.0,
          backgroundColor: Colors.grey,
          automaticallyImplyLeading: false,
          actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.update),
            onPressed: () => 
            {

            }
            
           ),
           new IconButton(
             icon: new Icon(Icons.close),
            onPressed: () => 
            {

            }
            
           ),
         ],
        ), 
      body: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(child: _showForm(context)),
              ),
            ]),);
  }


  Widget showSpace(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double spaceHeight = screenSize.height * 0.065;
    return SizedBox(
      height: spaceHeight,
    );
  }

  Widget smallShowSpace(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double spaceHeight = screenSize.height * 0.03;
    return SizedBox(
      height: spaceHeight,
    );
  }




  /**Form has Firstname, last name, email & phone number widgets*/
  Widget _showForm(BuildContext context) {
    return new Container(
      color: Colors.white,
        // height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: new Form(
              key: this.formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  errorMsg != null && errorMsg != ''
                      ? IndividualErrorContainer(errorMsg: errorMsg)
                      : Container(),
                  firstNameField(context),
                  lastNameField(context),
                  _emailField(context),
                  _phoneNumberField(context),
                  showSpace(context),
                ],
              )),
        ));
  }

  /**First name Widget TextFormField */
  Widget firstNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:30.0,right: 30,top: 5,bottom: 5),
      child: Column(
        children: <Widget>[
          new TextFormField(
            inputFormatters: [
              new LengthLimitingTextInputFormatter(25),
            ],
            keyboardType: TextInputType.text,
            controller: firstNameController,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,),
            cursorColor: Colors.black, // Use email input type for emails.
            decoration: new InputDecoration(
                labelStyle: TextStyle(
                  color:  Colors.black.withOpacity(0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5)),
                ),
                errorMaxLines: 3,
                hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black.withOpacity(0.5),),
                labelText: "first name",
                hintText: "enter first name"),
          ),
          firstNameError != null && firstNameError != ''
              ? IndividualErrorContainer(
                  errorMsg: firstNameError,
                )
              : Container(),
        ],
      ),
    );
  }

  /**Last name Widget TextFormField */
  Widget lastNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:30.0,right: 30,top: 5,bottom: 5),
      child: Column(
        children: <Widget>[
          new TextFormField(
            inputFormatters: [
              new LengthLimitingTextInputFormatter(25),
            ],
            keyboardType: TextInputType.text,
            controller: lastNameController,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,),
            cursorColor: Colors.black, // Use email input type for emails.
            decoration: new InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:Colors.black.withOpacity(0.5)),
                ),
                errorMaxLines: 3,
                hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black.withOpacity(0.5)),
                labelText: "last name",
                hintText: "enter last name"),
          ),
          lastNameError != null && lastNameError != ''
              ? IndividualErrorContainer(
                  errorMsg: lastNameError,
                )
              : Container(),
        ],
      ),
    );
  }


  /**Email Widget Textform Field */
  Widget _emailField(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          enabled: false,
          controller: emailController,
          style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 16,
              fontWeight: FontWeight.normal,),
          cursorColor: Colors.black, // Use email input type for emails.
          decoration: new InputDecoration(
            labelStyle: TextStyle(
              color:  Colors.black.withOpacity(0.5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.5)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.5)),
            ),
            errorMaxLines: 3,
            hintStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[300],),
            labelText: "email",
          ),
          onSaved: (value) {},
        ));
  }

  /**Phone Number Widget(Optional value) */
  Widget _phoneNumberField(BuildContext context) {
    return Column(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
            child: TextFormField(
              inputFormatters: [
                new LengthLimitingTextInputFormatter(16),
                maskTextInputFormatter
              ],
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,),
              cursorColor:
                  Colors.black, // Use email input type for emails.
              decoration: new InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.5)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:  Colors.black.withOpacity(0.5)),
                  ),
                  errorMaxLines: 3,
                  hintStyle: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black.withOpacity(0.5),),
                  labelText: "optional hone number",
                  hintText: "enter phone number"),
            )),
        phoneNumberError != null && phoneNumberError != ''
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: IndividualErrorContainer(
                  errorMsg: phoneNumberError,
                ),
              )
            : Container()
      ],
    );
  }

  Widget lineSeperator(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.all(40.0),
        color: Colors.grey[500],
        width: screenSize.width / 1.15,
        height: 1.6,
      ),
    );
  }
}
