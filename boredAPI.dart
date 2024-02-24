import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'Model/boredClass.dart';
class bored extends StatefulWidget {
  const bored({super.key});

  @override
  State<bored> createState() => _boredState();
}

class _boredState extends State<bored> {
  Future<boredclass>? _boreddata;

  Future<boredclass> fetchAlbum() async {
    final response = await http.get(Uri.parse('https://www.boredapi.com/api/activity'));

    if (response.statusCode == 200) {
      return boredclass.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Data');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _boreddata=fetchAlbum();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Things to do when you are bored")),
      ),
      body: Center(
        child: FutureBuilder<boredclass>(
          future: _boreddata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 25,),
                  Text(snapshot.data!.activity.toString(),style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                  SizedBox(height: 150,),
                  Text(snapshot.data!.type.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("PARTICIPANTS:     "),
                      Text(snapshot.data!.participants.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("PRICE:    "),
                      Text(snapshot.data!.price.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("KEY:  "),
                      Text(snapshot.data!.key.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ACCESSIBILITY:  "),
                      Text(snapshot.data!.accessibility.toString()),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return Row(
              children: [
                Text("loading the data"),
                const CircularProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
