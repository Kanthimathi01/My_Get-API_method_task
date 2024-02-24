import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/populationclass.dart';

class Population extends StatefulWidget {
  const Population({Key? key}) : super(key: key);

  @override
  State<Population> createState() => _PopulationState();
}

class _PopulationState extends State<Population> {
  Future<List<Data>> storage() async {
    var resp = await http.get(Uri.parse(
        "https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
    var data = jsonDecode(resp.body)['Data'];
    print(resp.body);
    return (data as List).map((e) => Data.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: storage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Data>? collect = snapshot.data as List<Data>?;
              return FittedBox(
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "ID NATION",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "NATION",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "ID YEAR",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "YEAR",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "POPULATION",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "SLUG NATION",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                  rows: collect!.map((entry) {
                    return DataRow(cells: [
                      DataCell(Text(entry.iDNation.toString())),
                      DataCell(Text(entry.nation.toString())),
                      DataCell(Text(entry.iDYear.toString())),
                      DataCell(Text(entry.year.toString())),
                      DataCell(Text(entry.population.toString())),
                      DataCell(Text(entry.slugNation.toString())),
                    ]);
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
