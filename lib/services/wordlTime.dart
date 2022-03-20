import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:world_clock/main.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location = '';
  String Time = 'f';
  String flag = '';
  String urlUp = '';
  WorldTime({required this.location, required this.flag, required this.urlUp});

  Future<void> getData() async {
    try {
      var url = Uri.parse('http://worldtimeapi.org/api/timezone/$urlUp');
      var responce = await http.get(url);
      var data = jsonDecode(responce.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = 
      await DateTime.parse(datetime).add(Duration(hours: int.parse(offset)));

      Time = DateFormat.jm().format(await now);
      // Time = datetime.toString();
      print(now);
      print(offset);
    } catch (e) {
      Time = e.toString();
    }
  }
}

class wtm {
  String location = '';
  String Time = '';
  String flag = '';
  String urlUp = '';
  wtm(
      {required this.location,
      required this.flag,
      required this.urlUp,
      required this.Time});
}
