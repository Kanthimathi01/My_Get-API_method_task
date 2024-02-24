import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/OrgEntryClass.dart';

class heyy extends StatefulWidget {
  const heyy({Key? key}) : super(key: key);

  @override
  State<heyy> createState() => _heyyState();
}

class _heyyState extends State<heyy> {
  late Future<List<Entries>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetch();
  }

  Future<List<Entries>> fetch() async {
    var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data = jsonDecode(resp.body)["entries"];
    print(resp.body);
    return (data as List).map((e) => Entries.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<Entries>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              List<Entries> gettingData = snapshot.data!;
              return FittedBox(
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "API",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Auth",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "HTTPS",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Cors",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Cors",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: gettingData.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry.aPI.toString())), // Assuming 'api' is a property of Entries class
                        DataCell(Text(entry.description.toString())),
                        DataCell(Text(entry.auth.toString())),
                        DataCell(Text(entry.hTTPS.toString())),
                        DataCell(Text(entry.cors.toString())),
                        DataCell(Text(entry.link.toString())),
                      ],
                    );
                  }).toList(),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
