import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/database_utils/database_utils.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/pages/movie_details.dart';


class MoviePopular extends StatefulWidget {
Movie movie ;

MoviePopular(this.movie);

  @override
  State<MoviePopular> createState() => _MoviePopularState();
}

class _MoviePopularState extends State<MoviePopular> {
String img = 'https://image.tmdb.org/t/p/w500';

int isSelected = 0;
@override
  void initState() {
    super.initState();
    checkMovieInFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "$img${widget.movie.backdropPath}",
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

        Positioned(
          height: MediaQuery.of(context).size.height * 0.26,
          left:MediaQuery.of(context).size.height * 0.15 ,
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, MovieDetails.routeName,arguments: widget.movie );
            },
            child: Image.asset('assets/playbutton.png'),
          ),
        ),

        Positioned(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.30,
          top: MediaQuery.of(context).size.height * 0.13,
          left:MediaQuery.of(context).size.height * 0.010 ,
          child: CachedNetworkImage(
            imageUrl: "$img${widget.movie.posterPath}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.red,size: 42,)),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.13,
          left: MediaQuery.of(context).size.width * 0.02,
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
        Positioned(
          top: MediaQuery.of(context).size.height * 0.31,
          left: MediaQuery.of(context).size.height * 0.20,
          child: Text(
            '${widget.movie.title}',
            style: TextStyle(color: Colors.white, fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.36,
          left: MediaQuery.of(context).size.height * 0.20,
          child: Text(
            '${widget.movie.releaseDate!.substring(0, 4)}  PG-13  ${widget.movie.originalLanguage}',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
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
