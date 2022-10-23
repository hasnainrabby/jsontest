import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/post.dart';

class JsonparsingMap extends StatefulWidget {
  const JsonparsingMap({Key? key}) : super(key: key);

  @override
  State<JsonparsingMap> createState() => _JsonparsingMapState();
}

class _JsonparsingMapState extends State<JsonparsingMap> {
  late Future<PostList> data;
  @override
  void initState() {

    super.initState();

    Network network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.loadPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PODO"),
      ),
     body: Center(
       child: Container(
         child: FutureBuilder(
           future: data,
             builder: (context,AsyncSnapshot<PostList>snapshot){
           List<Post> allPosts;
           if(snapshot.hasData){
             allPosts = snapshot.data!.posts;
              return createListView(context, allPosts);
            // return Text("${allPosts[0].title}");
           }else{
             return CircularProgressIndicator();
           }
         }
         ),


       ),
     ),
    );
  }

  Widget createListView(BuildContext context, List<Post> data) {

    return Container(
      child: ListView.builder(
        itemCount: data.length,
          itemBuilder: (context,int index){
          return Column(
            children: [
              Divider(height: 5.0,thickness: 5.0,color: Colors.blue),
              ListTile(
                title: Text("${data[index].title}"),
                subtitle: Text("${data[index].body}"),
                leading: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 25.0,
                      child: Text("${data[index].id}"),
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

  Future <PostList> loadPosts() async {
   final response = await get(Uri.parse(Uri.encodeFull(url)));
   if(response.statusCode == 200){
     return PostList.fromJson(json.decode(response.body));
   }else{
     throw Exception("Failed to get posts");
   }
  }

}