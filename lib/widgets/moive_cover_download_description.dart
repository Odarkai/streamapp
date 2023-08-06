import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream_app/bottom_nav_controllers/downloads.dart';
import 'package:stream_app/widgets/stream_video.dart';

class MovieCoverDownloadDescription extends StatefulWidget {
  const MovieCoverDownloadDescription({Key? key}) : super(key: key);

  @override
  State<MovieCoverDownloadDescription> createState() =>
      _MovieCoverDownloadDescriptionState();
}

class _MovieCoverDownloadDescriptionState
    extends State<MovieCoverDownloadDescription> {
  var fireStoreInstance = FirebaseFirestore.instance;
  var movieCoverDownloadDescription = <DocumentSnapshot>[]; // Initialize with an empty list

  @override
  void initState() {
    fetchMovieCovers();
    super.initState();
  }

  fetchMovieCovers() async {
    QuerySnapshot querySnapshot =
    await fireStoreInstance.collection("movie-covers").get();
    setState(() {
      movieCoverDownloadDescription = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 220,
            padding: const EdgeInsets.only(
              left: 10,
              top: 20,
              right: 0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  if (movieCoverDownloadDescription.isEmpty) {
                    // Show a loading indicator or empty placeholder if the list is empty
                    return const Padding(
                      padding:  EdgeInsets.only(left: 50),
                      child:  Center(child:  CircularProgressIndicator()),
                    ); // Replace this with your loading widget
                  }
                  String imageUrl =
                  movieCoverDownloadDescription[index]["img"];
                  String movieDesc =
                  movieCoverDownloadDescription[index]["desc"];
                  return GestureDetector(
                    onTap: () {
                      // Handle movie cover tap here
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 145,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25,),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Text(
                            movieDesc,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 180,),
              SizedBox(
                width: 90,
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoPlayerScreen()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.play_arrow, size: 30, color: Colors.black,),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: 90,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Downloads()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.download_rounded, size: 30, color: Colors.black,),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20,),
            ],
          ),
        ],
      ),
    );
  }
}