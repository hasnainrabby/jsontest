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
              return createListView(context, snapshot.data);
              //return Text(snapshot.data[0]['title']);
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

  Widget createListView(BuildContext context, List data) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
          itemBuilder: (context,int index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(height:5.0,thickness: 5.0,color: Colors.blue,),
            ListTile(
              title: Text("${data[index]['title']}"),
              subtitle: Text("${data[index]['body']}"),
              leading: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 25.0,
                    child: Text("${data[index]["id"]}"),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
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
