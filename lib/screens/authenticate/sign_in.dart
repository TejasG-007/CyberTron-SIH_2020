import 'package:safty_first/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:safty_first/services/auth.dart';
import 'package:safty_first/shared/constants.dart';
//import 'package:safty_first/temp/temp.dart';
//import 'package:safty_first/screens/authenticate/sign_in_p.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });


  @override

  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[400],
        elevation: 0.0,
        title: Text('Safty First'),


        actions: <Widget>[
          //FlatButton.icon(
          //            icon: Icon(Icons.portrait),
          //            label: Text('Police'),
          //            onPressed: () => Temp(),
          //          ),
          FlatButton.icon(
            icon: Icon(Icons.person_add),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body:
      Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
             Image(image: AssetImage('images/bprd.png') ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment(1.0, 1.0),
               // padding: EdgeInsets.only(top: 10.0, left: 20.0),
                child: InkWell(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              RaisedButton(
                  color: Colors.lightBlueAccent[400],
                  child: Text(
                    'CITIZEN Sign-In',
                    style: TextStyle(color: Colors.white ),
                  ),
                  onPressed: () async {
                    color: Colors.greenAccent[400];
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not sign in with those credentials';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'GUEST Sign-in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if(result == null) {
                       print('error in guest sign in');

                      }
                      else{
                        print('sign in as guest');
                      }
                    }

              ),
              SizedBox(height: 12.0),
//              RaisedButton(
//                  color: Colors.lightBlueAccent[400],
//                  child: Text(
//                    'POLICE sign-in',
//                    style: TextStyle(color: Colors.white ),
//                  ),
//                  onPressed: () async {
//                    color: Colors.greenAccent[400];
//                    if(_formKey.currentState.validate()){
//                      setState(() => loading = true);
//                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
//                      if(result == null) {
//                        setState(() {
//                          loading = false;
//                          error = 'Could not sign in with those credentials';
//                        });
//                      }
//                    }
//                  }
//              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

            ],
          ),
        ),
      ),
    );
  }
}