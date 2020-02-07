import 'Capture.dart';
import 'more.dart';
import 'view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Home extends StatefulWidget {
  //var cameras;
  //Home(this.cameras);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 //write here properties
  int currentTab = 0;
  final List<Widget> screens = [
    View(),
    //Capture(cameras),
    CameraExample(),
    More(),
    View(),
  ];

  Widget currentscreen = View();//intial screen viewport
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      PageStorage(
        child: currentscreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        backgroundColor: Colors.red,
        onPressed: (){setState(() {
         //currentscreen=Capture(widget.cameras);
          currentscreen = CameraExample();
          currentTab = 0;
        });},

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//position of camera button
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: 30,
                  onPressed: (){setState(() {
                    currentscreen = View();
                    currentTab = 1;
                  });},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.map, color: currentTab == 2 ? Colors.blueAccent : Colors.red,size: 30,),
                    Text('View', style: TextStyle(color: currentTab == 1 ? Colors.blueAccent : Colors.red,fontSize: 20),)
                  ],

           ),
              ),
              MaterialButton(
                minWidth: 10,
                onPressed: (){setState(() {
                  currentscreen = More();
                  currentTab = 2;
                });},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.more_horiz, color: currentTab == 2 ? Colors.blueAccent : Colors.red,size: 30,),
                    Text('More', style: TextStyle(color: currentTab == 2 ? Colors.blueAccent : Colors.red,fontSize: 20),)
                  ],

                ),

              ),
            ],
          ),
        ),
      ),

    );
  }
}
