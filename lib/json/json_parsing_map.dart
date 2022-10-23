import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonparsingMap extends StatefulWidget {
  const JsonparsingMap({Key? key}) : super(key: key);

  @override
  State<JsonparsingMap> createState() => _JsonparsingMapState();
}

class _JsonparsingMapState extends State<JsonparsingMap> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class Network{
  final String url;

  Network(this.url);

  Future fetchData() async{
    print("$url");
    Response response = await get(Uri.parse(Uri.encodeFull(url)));

    if(response.statusCode == 200)
    {
      print(response.body[0]);
      return json.decode(response.body);
    }
    else{
      print(response.statusCode);
    }
  }

}