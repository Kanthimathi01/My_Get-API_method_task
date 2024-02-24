import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/populationclass.dart';


class say extends StatefulWidget {
  const say({Key? key});

  @override
  State<say> createState() => _sayState();
}

class _sayState extends State<say> {
  Future<List<Data>> details() async {
    var resp = await http.get(Uri.parse("https://api.nationalize.io?name=nathaniel"));
    if (resp.statusCode == 200) {
      var data = jsonDecode(resp.body)["country"];
      return (data as List).map((e) => Data.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: details(),
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              List<Data>? store = snapshot.data;
              return ListView.builder(
                itemCount: store?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(store![index].iDYear.toString()),
                        Text(store![index].population.toString()),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
