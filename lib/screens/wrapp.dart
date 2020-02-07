import 'package:safty_first/screens/authenticate/authenticate.dart';
//import 'package:crew/screens/authenticate/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:safty_first/models/user.dart';
import 'package:safty_first/pages/home.dart';
import 'package:safty_first/pages/Capture.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
class Wrapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //return home or auth
    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
