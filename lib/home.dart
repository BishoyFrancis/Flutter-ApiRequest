import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api/details.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = ApiCall().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    posts = ApiCall().fetchPosts();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API REQUEST'),
        ),
        body: FutureBuilder(
          future: posts,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data as List<Post>;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: ((context, index) {
                  return UserItemDisplay2(posts[index]);
                }),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}

//Data Layer
class Post {
  late String title;
  late String picture;
  late String content;
  late String id;

  Post(
      {required this.title,
      required this.picture,
      required this.content,
      required this.id});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    picture = json['picture'];
    content = json['content'];
    id = json['id'];
  }
}

//Api Call
class ApiCall {
  Future<List<Post>> fetchPosts() async {
    var response = await http.get(
        Uri.parse('https://62d4154fcd960e45d452f790.mockapi.io/api/article'));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("SUCCESSSSSSSSSSS");
      var list = (jsonResponse as List).map((e) => Post.fromJson(e)).toList();
      return list;
    } else {
      throw Exception('Can not resolve Api Request , Try Again');
    }
  }
}

class UserItemDisplay extends StatelessWidget {
  var _post;
  UserItemDisplay(this._post);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      child: Card(
        child: Row(children: [
          Container(
            child: Image.network(_post.picture),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _post.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class UserItemDisplay2 extends StatelessWidget {
  var _post;
  UserItemDisplay2(this._post);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetails(_post.title , _post.content, _post),
            ));
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        child: Card(
          child: Row(children: [
            Container(
              child: Image.network(_post.picture),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _post.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
