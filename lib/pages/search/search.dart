import 'package:flutter/material.dart';
import 'package:movies_app/Theme/MyTheme.dart';
import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/models/movie_model.dart';


import 'search_widget.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';
  List<Movie> movies = []; // Change 'movies' to a list
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: MyTheme.blackColor,
        title: TextFormField(
          cursorColor: Colors.white,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 21,
          ),
          controller: search,
          onChanged: (String value) {
            setState(() {
              query = value;
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            filled: true,
            fillColor: MyTheme.containerColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide:
              BorderSide(color: Theme.of(context).colorScheme.onSecondary),
            ),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 32,
              ),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  query = '';
                  search.clear();
                });
              },
              icon: Icon(
                Icons.close,
                size: 32,
              ),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<MoviesModel>(
              future: ApiManager.getSearchMovies(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(
                      '${snapshot.error}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          ApiManager.getSearchMovies(query);
                          setState(() {});
                        },
                        child: const Text(
                          "Try Again",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasData) {
                  movies = snapshot.data?.results ?? [];
                  movies.sort((a, b) =>
                      (a.originalTitle ?? "").compareTo(b.originalTitle ?? ""));
                  return SearchWidget(
                    movies: movies,
                    query: query,
                  );
                } else {
                  return Text('No results found.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
