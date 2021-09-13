import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/home/movie.dart';
import 'package:moviesapp/home/movie_service.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;

  final movieService = ref.watch(moviesServiceProvider);
  final movies = await movieService.getMovies();

  return movies;
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Movies'),
      ),
      body: watch(moviesFutureProvider).when(
          error: (e, s) {
            return Text("error");
          },
          loading: () => CircularProgressIndicator(),
          data: (movies) {
            return GridView.extent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
              children: movies.map((movie) {
                return Stack(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movie.fullImageUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width * 0.465,
                    height: MediaQuery.of(context).size.height * 0.10,
                    top: 200,
                    child: Container(
                        color: Colors.transparent.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            movie.title,
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        )),
                  )
                ]);
              }).toList(),
            );
          }),
    );
  }
}
