import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'Model/dogsclass.dart';
class pets extends StatefulWidget {
  const pets({super.key});

  @override
  State<pets> createState() => _petsState();
}

class _petsState extends State<pets> {
  Future<dogs>? _img;

  Future<dogs> fetchImage() async {
    var resp = await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    var data = jsonDecode(resp.body);
    return dogs.fromJson(data);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _img = fetchImage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: FutureBuilder<dogs>(
          future: _img ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data!.status.toString()),
                  Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data!.message.toString()),
                        fit: BoxFit.fill,
                      )
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return Column(
              children: [
                Text("Loading the image"),
                const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
