import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/CatClass.dart';

class CatAPI extends StatefulWidget {
  const CatAPI({super.key});

  @override
  State<CatAPI> createState() => _CatAPIState();
}

class _CatAPIState extends State<CatAPI> {
  String x = "Helo";
  Future<CatFact>? _future;

  Future<CatFact> FetchCatDetails() async{
  var resp = await http.get(Uri.parse("https://catfact.ninja/fact"));
  var data = jsonDecode(resp.body);
  return CatFact.fromJson(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = FetchCatDetails();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<CatFact>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.fact.toString()),
                    Text(snapshot.data!.length.toString())
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
