import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Theme/MyTheme.dart';
import 'package:movies_app/data/database_utils/database_utils.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/pages/watch_list/WatchListItems.dart';



class WatchList extends StatefulWidget {
  const WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyTheme.blackColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Watchlist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot<Movie>>(
              stream: DatabaseUtils.readMoviesFormFirebaseWL(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: MyTheme.yellowColor,
                  ));
                }
                List<Movie> movies =
                    snapshot.data?.docs.map((task) => task.data()).toList() ??
                        [];
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return WatchListItems(movies[index]);
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
