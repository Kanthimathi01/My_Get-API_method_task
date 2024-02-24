import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Model/jokesclass.dart';
class smile extends StatefulWidget {
  const smile({super.key});

  @override
  State<smile> createState() => _smileState();
}

class _smileState extends State<smile> {
  Future<jokes>? _content;

  Future<jokes> fetchJokes() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));

    if (response.statusCode == 200) {
      return jokes.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _content=fetchJokes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Jokes Here",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.redAccent),)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: FutureBuilder<jokes>(
            future: _content,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [SizedBox(height: 150,),
                    Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.yellow[100],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 25,),
                          Text(snapshot.data!.type.toString()),
                          Text(snapshot.data!.setup.toString()),
                          Text(snapshot.data!.punchline.toString()),
                          Text(snapshot.data!.id.toString()),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
