import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/nationclass.dart';
class dtt extends StatefulWidget {
  const dtt({super.key});

  @override
  State<dtt> createState() => _dttState();
}

class _dttState extends State<dtt> {
  Future<List<Country>> details() async{
    var resp = await http.get(Uri.parse("https://api.nationalize.io?name=nathaniel"));
    var data = jsonDecode(resp.body)["country"];
    print(resp.body);
    return(data as List).map((e) => Country.fromJson(e)).toList();
  }
  Future<National> det() async{
    var a = await http.get(Uri.parse("https://api.nationalize.io?name=nathaniel"));
    var datas = jsonDecode(a.body);
    print(a.body);
    return National.fromJson(jsonDecode(a.body));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: details(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    List<Country> getting_data = snapshot.data!;
                    return Container(
                      height: 500,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                          itemCount: getting_data.length,
                          itemBuilder: (BuildContext context, int index){
                          return Column(
                            children: [
                              Text(getting_data[index].countryId.toString()),
                              Text(getting_data[index].probability.toString()),
                              Text(getting_data[index].countryId.toString()),
                              Text(getting_data[index].probability.toString()),
                              Text(getting_data[index].countryId.toString()),
                              Text(getting_data[index].probability.toString()),

                            ],
                          );
                          }
                      ),
                    );
        
                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }return CircularProgressIndicator();
                }
            ),
            FutureBuilder(
                future: det(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        Text(snapshot.data!.count.toString()),
                        Text(snapshot.data!.name.toString()),
                      ],
                    );
                  }else if (snapshot.hasError){
                    return Text("${snapshot.hasError}");
                  }return CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}
