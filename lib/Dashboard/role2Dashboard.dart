import 'package:MultiLogin/Authentication/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Role2Dashboard extends StatefulWidget {

  @override
  Role2DashboardState createState() => Role2DashboardState();
}

class Role2DashboardState extends State<Role2Dashboard> {
Authentication auth;
@override
  void initState() {
    super.initState();
  auth = new Authentication();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('DashBoard'),
         automaticallyImplyLeading: false,
         actions: <Widget>[
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
      body: Center(
      
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome Role2 User',
            ),
          ],
        ),
      ),
    );
  }
}
