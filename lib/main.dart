import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model_class.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_Page(),
    ),
  );
}

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  TextStyle mystyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  late Future<People?> fetchAllPeople;

  String BASE_URL = "https://randomuser.me";
  String ENDPOINT = "/api";

  Future<People?> fechPeopleData() async {
    Uri API = Uri.parse(BASE_URL + ENDPOINT);

    http.Response response = await http.get(API);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      People people = People.fromJson(data);

      return people;
    } else {
      print("no data");
      print(response.statusCode);
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchAllPeople = fechPeopleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Random People data",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: fetchAllPeople,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:- ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            People data = snapshot.data;

            return Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.pinkAccent.withOpacity(0.5),
                      ),
                      child: Icon(Icons.camera_alt_outlined,
                          color: Colors.pink, size: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data.phone,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 115),
                  child: Text(
                    "My Account",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(data.gender),
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(data.email),
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text(data.dob),
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(data.country),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("State: ${data.state}"),
                        Text("City: ${data.city}"),
                        Text("Street: ${data.street}")
                      ],
                    ),

                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}