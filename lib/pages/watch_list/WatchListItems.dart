import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/api/api_constant.dart';
import 'package:movies_app/data/database_utils/database_utils.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/pages/movie_details.dart';


class WatchListItems extends StatefulWidget {
  Movie movie;
  WatchListItems(this.movie);

  @override
  State<WatchListItems> createState() => _WatchListItemsState();
}

class _WatchListItemsState extends State<WatchListItems> {
  @override
  Widget build(BuildContext context) {
    int isSelected = 0;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieDetails.routeName,arguments: widget.movie );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${ApiConstant.imageBaseUrl}${widget.movie.posterPath}',
                  imageBuilder: (context, imageProvider) => Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Center(
                      child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 42,
                  )),
                ),
                    InkWell(
                    onTap: () {
                      if (isSelected == 0) {
                        DatabaseUtils.DeletTask('${widget.movie.dataBaseId}');
                      }
                      setState(() {});
                    },
                    child: Image.asset('assets/bookmarkSelected.png')),
                  ],
                )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.movie.title}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.movie.releaseDate!.substring(0, 4)} ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.movie.overview} ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
