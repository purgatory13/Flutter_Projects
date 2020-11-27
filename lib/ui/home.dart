import 'package:first_flutter_app/model/movie.dart';
import 'package:flutter/material.dart';

import 'movie_ui/movie_ui.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "1984",
    "I am Legend",
    "A Clockwork Orange",
    "The Zero Theorem",
    "Snowpiercer",
    "Brazil",
    "Metropolis",
    "Soylent Green",
    "Bladerunner",
    "The Island",
    "District 9",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Dystopian Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ), //Appbar
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
          return Stack(
              children:<Widget>[

                movieCard(movieList[index], context),

                Positioned(
                  top: 10.0,
                   //left: 10.0,
                    child: movieImage(movieList[index].poster))
                   // child: movieCard(movieList[index], context))
              ]);
      }), //Listview.builder
    ); //scaffold
  }
  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
          width: MediaQuery.of(context).size.width,
          height: 120.0,
          child: Card(
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,
              bottom: 8.0,
              left: 40.0,
              right: 20.0,),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Flexible(
                        child: Text(
                            movie.title, style:
                        TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white
                        )
                        ),
                      ),
                     Text("Rating: ${movie.imdbRating} / 10",
                       style: TextStyle(
                         fontSize: 14.0,
                         color: Colors.grey
                       ),)
                ]
                ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Released: ${movie.released}",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey
                          ),),
                        Text(movie.runtime,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey
                          ),),
                        Text(movie.rated,
                          style: mainTextStyle()
                        )
                      ],
                    )
        ],
      ),
              ),
    ),
    ),
    ),
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MovieListViewDetails(movieName: movie.title,
          movie: movie )))
      },
    );
  }
TextStyle mainTextStyle() {
    return TextStyle(
        fontSize: 14.0,
        color: Colors.grey
    );
}



  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(imageUrl ?? 'https://cdn.pixabay.com/photo/2019/08/11/18/54/icon-4399690_1280.png'),
        fit: BoxFit.cover)
      ),
    );

  }

}

//end of MovieListView
//new route/screen/page Details page




