import 'package:flutter/material.dart';
import 'package:stream_app/constants/colors.dart';
import 'package:stream_app/widgets/moive_cover_download_description.dart';
import 'package:stream_app/widgets/movie_covers.dart';
import '../widgets/top_bar_category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: const [
                SizedBox(width: 100,),
                Text("My Cinema",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: GlobalVariables.cinemaColor),),
                SizedBox(width: 50,),
                Icon(Icons.person_4_outlined, color: Colors.white,)
              ],
            ),
          ),
        const Categories(),
        const MovieCoverDownloadDescription(),
        const SizedBox(height: 20,),
        const MovieCovers(),
        ],
      )
    );
  }
}