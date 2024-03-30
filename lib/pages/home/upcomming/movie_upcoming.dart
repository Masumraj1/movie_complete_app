import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/database_utils/database_utils.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/pages/movie_details.dart';



class MovieUpcomming extends StatefulWidget {
  Movie movie;
  MovieUpcomming(this.movie);

  @override
  State<MovieUpcomming> createState() => _MovieUpcommingState();
}

class _MovieUpcommingState extends State<MovieUpcomming> {
  String img = 'https://image.tmdb.org/t/p/w500';
  int isSelected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkMovieInFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, MovieDetails.routeName,arguments: widget.movie );

          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 5,
            child: CachedNetworkImage(
              imageUrl: "$img${widget.movie.posterPath}",
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.red,size: 42,)),
            ),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.005,
          left: MediaQuery.of(context).size.width * 0.01,
          child: InkWell(
              onTap: () {
                isSelected = 1 - isSelected;
                if (isSelected == 1) {
                  DatabaseUtils.AddMoviesToFirebase(widget.movie);
                } else {
                  DatabaseUtils.DeletTask('${widget.movie.dataBaseId}');
                }
                setState(() {});
              },
              child: isSelected == 0
                  ? Image.asset('assets/bookmark.png')
                  : Image.asset('assets/bookmarkSelected.png')),
        ),
      ],
    );
  }

  Future<void> checkMovieInFireStore() async {
    QuerySnapshot<Movie> temp =
        await DatabaseUtils.readMovieFormFirebase(widget.movie.id!);
    if (temp.docs.isEmpty) {
    } else {
      widget.movie.dataBaseId = temp.docs[0].data().dataBaseId;
      isSelected = 1;
      setState(() {});
    }
  }
}
