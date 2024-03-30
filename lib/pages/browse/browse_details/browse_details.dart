import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/api/api_constant.dart';
import 'package:movies_app/data/api/api_manager.dart';
import 'package:movies_app/data/models/movie_model.dart';
import 'package:movies_app/pages/browse/catigory_movies_Dm.dart';
import 'package:movies_app/pages/movie_details.dart';



class BrowseDetails extends StatefulWidget {
  final CategoryMovies categoryMovies;

  BrowseDetails({required this.categoryMovies});

  @override
  _BrowseDetailsState createState() => _BrowseDetailsState();
}
class _BrowseDetailsState extends State<BrowseDetails> {
  List<Movie> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }
  Future<void> fetchMovies() async {
    try {
      final moviesList = await ApiManager.getCategoryMoviesList(widget.categoryMovies.id);
      setState(() {
        movies = moviesList.results ?? [];
        isLoading = false;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 19, 18, 1.0),
      appBar: AppBar(
        title: Text(
          widget.categoryMovies.name,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:movieList(),
        ),
      ),
    );
  }

  List<Widget> movieList() {
    if (movies.isEmpty) {
      return [
        const Center(
          child: Text(
            'No movies available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ];
    }
    return [
      CarouselSlider.builder(
        itemCount: movies.length,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.30, // Adjust height as needed
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final movie = movies[index];
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, MovieDetails.routeName,arguments: movie );
            },
            child: Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConstant.imageBaseUrl}${movie.backdropPath ?? ""}',
                      imageBuilder: (context, imageProvider) => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red, size: 42),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset('assets/playbutton.png'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      const SizedBox(height: 20),
      Container(
        color: Theme.of(context).colorScheme.background,
        child: const Text(
          'Your additional text goes here',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      Card(
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 5,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            CarouselSlider.builder(
              itemCount: movies.length,
              options: CarouselOptions(
                enableInfiniteScroll: true,
                disableCenter: false,
                height: MediaQuery.of(context).size.height * 0.4,
                viewportFraction: 0.6,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final movie = movies[index];
                return Container(
                  color: Theme.of(context).colorScheme.background,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, MovieDetails.routeName,arguments: movie );
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: "${ApiConstant.imageBaseUrl}${movie.backdropPath ?? ""}",
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: MediaQuery.of(context).size.height * 0.4, // Adjust the height as needed
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error, color: Colors.red, size: 42)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${movie.title ?? ""}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

}

