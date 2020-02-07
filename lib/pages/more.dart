import 'package:flutter/material.dart';
import 'package:safty_first/services/auth.dart';
class More extends StatefulWidget {

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child:  Text('MORE OPTIONS'),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
      ),
      body: BodyLayout(),
//      new GridView.count(crossAxisCount: 2, children: [
//
//
//        new Card(
//            color: Colors.blue.shade200,
//            child: new Center(
//              child: Image(image: AssetImage('images/bprd.png') ),
//            )
//        ),
//        new Card(
//            color: Colors.blue.shade200,
//            child: new Center(
//              child: Image(image: AssetImage('images/1.png') ),
//            )
//        ),
//        new Card(
//            color: Colors.blue.shade200,
//            child: new Center(
//              child: Image(image: AssetImage('images/2.png') ),
//            )
//        ),
//        new Card(
//            color: Colors.blue.shade200,
//            child: new Center(
//              child: Image(image: AssetImage('images/3.png') ),
//            )
//        ),
//        new Card(
//            color: Colors.blue.shade200,
//            child: new Center(
//              child: Image(image: AssetImage('images/4.png') ),
//            )
//        ),
//        new Card(
//            color: Colors.blue.shade200,
//            child: new Center(
//              child: Image(image: AssetImage('images/5.png') ),
//            )
//        ),
//
//
//      ]),
    );


  }
}
class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}


Widget _myListView(BuildContext context) {
  return ListView(
    children: <Widget>[
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/bprd.png'),
        ),
        title: Text('profile'),
        subtitle: Text('profile related options here'), //           <-- subtitle
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/1.png'),
        ),
        title: Text('SOS'),
        subtitle: Text('SOS settings'), //           <-- subtitle
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/3.png'),
        ),
        title: Text('Report Crime'),
        subtitle: Text('Crimes related information.'), //           <-- subtitle
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/4.png'),
        ),
        title: Text('Rewards'),
        subtitle: Text('Police Friend.'), //           <-- subtitle
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/5.png'),
        ),
        title: Text('Track Report'),
        subtitle: Text('Status of reported crime.'), //           <-- subtitle
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/6.png'),
        ),
        title: Text('Notification'),
        subtitle: Text('Notification controls.'), //           <-- subtitle
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/2.png'),
        ),
        title: Text('Share Location'),
        subtitle: Text('Share location to Friends & Family '), //           <-- subtitle
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/8.png'),
        ),
        title: Text('Track Location'),
        subtitle: Text('See where are you'), //           <-- subtitle
      ),
    ],
  );
}





