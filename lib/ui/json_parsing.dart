import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSimple extends StatefulWidget {
  const JsonParsingSimple({Key? key}) : super(key: key);

  @override
  State<JsonParsingSimple> createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  late Future data;

  @override
  void initState() {

    super.initState();
    
    data = getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON Parsing"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
            {
            if(snapshot.hasData){
              return Text(snapshot.data[0]['title']);
            }
            return CircularProgressIndicator();
          },

          ),
        ),
      ),
    );
  }

  Future getData() async {
    var data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    data = network.fetchData();

    // data.then((value){
    //   print(value);
    // });



    return data;
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
