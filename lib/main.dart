// ignore_for_file: prefer_const_constructors



import 'package:world_clock/pages/location.dart';
import 'package:world_clock/pages/lodding.dart';
import 'package:world_clock/services/wordlTime.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

void main() => runApp(MaterialApp(
      // home: Home(),
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => Location(),
        '/sublocation' : (context) => SubLocation()
      },
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

String time = '';
String location = '';
bool first =false;

income (){

}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //  final wtm  data = ModalRoute.of(context).settings.arguments;
    final data = ModalRoute.of(context)!.settings.arguments as wtm;
    // income(data);
    // final Argument data = ModalRoute.of(context).settings.arguments;
  if(!first){
      time = data.Time;
      location = 'nirobi';
      first= true;
  }
    

   

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        // ignore: prefer_const_literals_to_create_immutables

        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlatButton.icon(
                    onPressed: () => {
                  
                      _navigateAndDisplaySelection(context)

                      // print(Navigator.pushNamed(context, '/location')),
                      // Navigator.pushNamed(context, '/location')
                    },
                    icon: Icon(Icons.edit_location_alt_outlined),
                    label: Text('location', style: TextStyle(fontSize: 24)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('$location', style: TextStyle(fontSize: 48)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(' $time', style: TextStyle(fontSize: 72)),
                ]),
          ),
        ),
      )),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/location');

    WorldTime instance = await WorldTime(
        location: result.toString(),
        flag: 'tokyo',
        urlUp: result.toString());
    await instance.getData();
    print(instance.location);
    print(instance.Time);

    setState(() {
      location = instance.location;
      time = instance.Time;
    });
  }
}
