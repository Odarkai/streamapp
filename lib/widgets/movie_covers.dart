import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_app/widgets/stream_video.dart';

class MovieCovers extends StatefulWidget {
  const MovieCovers({Key? key}) : super(key: key);

  @override
  State<MovieCovers> createState() => _MovieCoversState();
}

class _MovieCoversState extends State<MovieCovers> {
  var fireStoreInstance = FirebaseFirestore.instance;
  var movieCovers = <DocumentSnapshot>[]; // Initialize with an empty list

  @override
  void initState() {
    fetchMovieCovers();
    super.initState();
  }

  fetchMovieCovers() async {
    QuerySnapshot querySnapshot =
    await fireStoreInstance.collection("movie-covers").get();
    setState(() {
      movieCovers = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: const Text(
                'Special for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // Display movie covers in horizontal ListView
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieCovers.length,
              itemBuilder: (context, index) {
                if (movieCovers.isEmpty) {
                  // Show a loading indicator or empty placeholder if the list is empty
                  return const CircularProgressIndicator(); // Replace this with your loading widget
                }
                String imageUrl = movieCovers[index]["img"];
                String movieName = movieCovers[index]["name"];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoPlayerScreen()));
                  },
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          movieName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}