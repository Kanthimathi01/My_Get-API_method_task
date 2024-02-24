import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal/universalclass.dart';
import 'modal/zippoclass.dart';

class pos extends StatefulWidget {
  const pos({super.key});

  @override
  State<pos> createState() => _posState();
}

abstract class _posState extends State<pos> {
  Future<List<Places>> getlist() async {
    var resp = await http.get(Uri.parse("https://api.zippopotam.us/us/33162"));
    var data = jsonDecode(resp.body)["places"];
    print(resp.body);
    return (data as List).map((e) => Places.fromJson(e)).toList();
  }
  Future<post> dare() async{
      var resp = await http.get(Uri.parse("https://api.zippopotam.us/us/33162"));
      var data = jsonDecode(resp.body);
      print(resp.body);
      return post.fromJson(jsonDecode(resp.body));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getlist(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    List<Places> hey = snapshot.data!;
                    return Column(
                      children: [
                        Container(
                          height: 500,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                              itemCount: hey.length,
                              itemBuilder: (BuildContext context, int index){
                              return Column(
                                children: [
                                  Text(hey[index].longitude.toString()),
                                  Text(hey[index].latitude.toString()),
                                  Text(hey[index].placeName.toString()),
                                  Text(hey[index].state.toString()),
                                  Text(hey[index].stateAbbreviation.toString()),

                                ],
                              );
                              }
                          ),
                        )
                      ],
                    );

                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }return CircularProgressIndicator();
                }
            ),
            FutureBuilder(
                future: dare(),
                builder: (context,snapshot){
                  if (snapshot.hasData){
                    return Column(
                      children: [
                        Text(snapshot.data!.postCode.toString()),
                        Text(snapshot.data!.country.toString()),
                        Text(snapshot.data!.countryAbbreviation.toString()),

                      ],
                    );
                  }else if (snapshot.hasError){
                    return Text('${snapshot.error}');
                  }return CircularProgressIndicator();
                })

          ],
        )

      ),
    );
  }
}
