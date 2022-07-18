import 'package:flutter/material.dart';
import 'package:api/home.dart';

class PostDetails extends StatelessWidget {
  late String _title;
  late String _content;
  late Post _post;

  PostDetails(this._title, this._content, this._post);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.amber,
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100, // Image radius
                    backgroundImage: NetworkImage(_post.picture),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_title,
                      style: const TextStyle(fontSize: 35, color: Colors.red))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: SizedBox(
                      child: Text(
                        _content,
                        style:
                            TextStyle(color: Colors.green[500], fontSize: 15),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
