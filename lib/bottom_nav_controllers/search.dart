import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream_app/widgets/stream_video.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchQuery = '';
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(); // Add a FocusNode

  @override
  void initState() {
    super.initState();
    // Add a listener to the FocusNode to handle focus changes
    searchFocusNode.addListener(_onSearchFocusChange);
  }

  @override
  void dispose() {
    // Clean up the FocusNode when the widget is disposed
    searchFocusNode.dispose();
    super.dispose();
  }

  // Function to handle focus changes
  void _onSearchFocusChange() {
    setState(() {}); // Update the state when the focus changes
  }

  // Function to clear the search query and remove focus from the TextFormField
  void _clearSearch() {
    searchController.clear();
    _searchQuery = '';
    searchFocusNode.unfocus();
    setState(() {});
  }

  // Function to search items in Firebase Firestore
  Future<List<Map<String, dynamic>>> searchItems(String searchQuery) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('movie-covers')
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .get();

    List<Map<String, dynamic>> searchResults = [];
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> itemData = {
        'name': doc['name'],
        'img': doc['img'],
      };
      searchResults.add(itemData);
    });

    return searchResults;
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchFocused = searchFocusNode.hasFocus; // Check if the TextFormField is focused

    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, right: 40), // Adjust the horizontal padding as needed
                    child: TextFormField( // Use a TextFormField instead of TextField
                      controller: searchController,
                      focusNode: searchFocusNode, // Assign the FocusNode to the TextFormField
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                    ),
                  ),
                ),
                // Show "Cancel" button when the TextFormField is focused and has some text
                if (isSearchFocused && _searchQuery.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: TextButton(
                      onPressed: _clearSearch,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: searchItems(_searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Map<String, dynamic>> searchResults = snapshot.data!;
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoPlayerScreen()));
                    },
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            searchResults[index]['img'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(searchResults[index]['name'],
                            style: const TextStyle(color: Colors.white),),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}