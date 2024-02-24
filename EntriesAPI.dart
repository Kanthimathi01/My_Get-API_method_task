import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/OrgEntryClass.dart';

class EntriesAPI extends StatefulWidget {
  const EntriesAPI({super.key});

  @override
  State<EntriesAPI> createState() => _EntriesAPIState();
}

class _EntriesAPIState extends State<EntriesAPI> {


  Future<List<Entries>> GetEntries() async{
  var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));
  var data = jsonDecode(resp.body)["entries"];
  return (data as List).map((e) => Entries.fromJson(e)).toList();
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
          child: FutureBuilder<List<Entries>>(
            future: GetEntries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Entries>? li = snapshot.data;
                // List<Entries> filList = [];
                //  filList = li.take(5).length
                return  ListView.builder(
                    itemCount: li!.take(5).length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: const Icon(Icons.list),
                          trailing: const Text(
                            "GFG",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text(li[index].hTTPS.toString()));
                    });

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
