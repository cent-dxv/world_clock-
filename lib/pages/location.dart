// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

List dataa = [];

class _LocationState extends State<Location> {
  void getData() async {
    try {
      var url = Uri.parse('http://worldtimeapi.org/api/timezone/');
      // var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
      var responce = await http.get(url);
      var data_t = await jsonDecode(responce.body);
      List data = [];
      String tempo = 'n';
      for (int i = 0; i < data_t.length; i++) {
        String str_data = data_t[i].split('/')[0].toString();
        if (tempo != str_data) {
          data.add(str_data);
        }
        tempo = str_data;
      }
      print(data);
      setState(() {
        dataa = data;
      });
    } catch (e) {
      print(e);
      // getData();
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose location'),
      ),
      body: ListView.builder(
          itemCount: dataa.length,
          itemBuilder: (BuildContext context, int index) {
            return RaisedButton(
              onPressed: () =>
                  _navigateAndDisplaySelection(context, dataa[index]),
              child: ListTile(
                  leading: Icon(Icons.list),
                  trailing: Text(
                    "GFG",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text(
                      //
                      dataa[index])),
            );
          }),
    );
  }
}

_navigateAndDisplaySelection(BuildContext context, data) async {
  final result =
      await Navigator.pushNamed(context, '/sublocation', arguments: data);
  Navigator.pop(context, result);
}

////////////////////////////////////////////// second class ////////////////////////////////////

class SubLocation extends StatefulWidget {
  const SubLocation({Key? key}) : super(key: key);

  @override
  State<SubLocation> createState() => _SubLocationState();
}

class _SubLocationState extends State<SubLocation> {
  String ur = 'africa';
  void getData(ur) async {
    try {
      var url = Uri.parse('http://worldtimeapi.org/api/timezone/$ur');
      // var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
      var responce = await http.get(url);
      var data = await jsonDecode(responce.body);

      String tempo = 'n';

      print(data);
      setState(() {
        dataa = data;
      });
    } catch (e) {
      print(e);
      // getData();
    }
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(ur);
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    setState(() {
      getData(data);
    });
    
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text('choose location'),
      ),
      body: ListView.builder(
          itemCount: dataa.length,
          itemBuilder: (BuildContext context, int index) {
            return RaisedButton(
              onPressed: () => Navigator.pop(context, dataa[index]),
              child: ListTile(
                  leading: Icon(Icons.list),
                  trailing: Text(
                    "GFG",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text(dataa[index].toString())),
            );
          }),
    );
  }
}
