import 'package:flutter/material.dart';
import 'package:screens_for_touristapp/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:screens_for_touristapp/auth/auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2022-09-31&sortBy=publishedAt&language=en&apiKey=716addab3492407aaa6516a8726cc119'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final String? title;
  final String? description ;
  final String? url;
  final String urlToImage;

  const Album({
    this.title,
    this.description,
    this.url,
    required this.urlToImage,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      title: json["articles"][0]["title"],
      description: json["articles"][0]["description"],
      url: json["articles"][0]["url"],
      urlToImage: json["articles"][0]["urlToImage"],
    );
  }
}

class HomePageFirst extends StatefulWidget {
  HomePageFirst({Key? key}) : super(key: key);
  @override
  State<HomePageFirst> createState() => _HomePageFirstState();
}

class _HomePageFirstState extends State<HomePageFirst> {

  // the below lines are the the authentication functions
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }
  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }
  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }
  // that's it with the authentication function
  late Future<Album> futureAlbum;
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient:mainGradient(context)),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                const Text("hello "),
                _userUid(),
                _signOutButton(),
              ],
            ),
            const Expanded(
                flex: 1,
                child: Text("Welcome to",style: TextStyle(fontSize: 40),textAlign: TextAlign.start,)),
            Expanded(
                flex: 2,
                child: Center(
                  child: Row(
                    children: const [
                      Center(child: Icon(Icons.location_pin,size: 30,)),
                      Center(child: Text("Location",style: TextStyle(fontSize: 25),))
                    ],
                  ),
                )),
            Expanded(
              flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: FutureBuilder<Album>(
                    future: futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        double cWidth = MediaQuery.of(context).size.width*0.8;
                        return InkWell(
                          onTap: () => launchUrl(Uri.parse('${snapshot.data!.url}')),
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.cyan,
                            ),
                            // height: 100,
                            //
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    width: cWidth*0.7,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            flex : 3,
                                            child: Text(
                                              '''${snapshot.data!.title}''',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            )
                                        ),
                                        Flexible(
                                            flex :1,
                                            child: Text(
                                              '''${snapshot.data!.description}''',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black54,
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    width: cWidth*0.35,
                                    padding: const EdgeInsets.all(0.3),
                                    child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network(
                                            snapshot.data!.urlToImage ,
                                            width: cWidth*0.3,
                                            height: 70,
                                            fit: BoxFit.fill,

                                          ),
                                        )
                                    )
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
            ),
            Expanded(child: Row(
              children: const [
                Text("Whats new -",style: TextStyle(fontSize: 30),),
                SizedBox(height: 20,)
              ],
            )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.cyan,
                    ),
                  ),
                )
            ),
            const SizedBox(
              height: 19,
            ),
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.cyan,
                    ),
                  ),
                )
            ),
            const Expanded(
                child: Text(
                  "Planning for a trip -",
                  style: TextStyle(
                      fontSize: 30)
                )
            ),
            const FloatingActionButton.extended(
                label: Text("TIME FOR TRIP"),
                onPressed: null
            ),
            const SizedBox(height: 20,)


          ],

        ),
      ),
    );
  }
}
