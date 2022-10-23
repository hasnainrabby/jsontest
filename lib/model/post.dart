class Post{
 late  int userId;
 late  int id;
 late String title;
 late String body;

 Post({required this.userId, required this.id, required this.title, required this.body});

 factory Post.fromJson(Map<String,dynamic> json){
  return Post(userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);
 }
}