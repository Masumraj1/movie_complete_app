import 'package:flutter/material.dart';
import 'package:movies_app/pages/browse/catigory_movies_Dm.dart';
import 'browse_details/browse_details.dart';

class CategoryCard extends StatelessWidget {
  final CategoryMovies categoryMovies;

  CategoryCard(this.categoryMovies);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BrowseDetails(categoryMovies: categoryMovies,),
          ),
        );
      },
      child: Card(
        semanticContainer: true,
        borderOnForeground: true,
        margin: EdgeInsets.only(bottom: 10, left: 10),
        color: Color(0xFF343534),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: Image.asset(
                  'assets/${categoryMovies.imageName}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoryMovies.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}