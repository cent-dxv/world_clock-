// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_clock/services/wordlTime.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpwtime() async {
    WorldTime instance =
        WorldTime(location: 'tokyo', flag: 'tokyo', urlUp: 'asia/tokyo');
    await instance.getData();
    Navigator.pushReplacementNamed(context, '/home',
        arguments: wtm(
            location: instance.flag,
            flag: instance.flag,
            urlUp: instance.urlUp,
            Time: instance.Time));

    // print('done');
  }

  @override
  void initState() {
    super.initState();
    setUpwtime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // child: Text("😎😎😎😎"),
        child: SpinKitCircle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
