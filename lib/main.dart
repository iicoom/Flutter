import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_name/modal_class/function.dart';
import 'package:startup_name/modal_class/genres.dart';
import 'package:startup_name/bloc/change_theme_bloc.dart';
import 'package:startup_name/bloc/change_theme_state.dart';
import 'package:startup_name/modal_class/movie.dart';
import 'package:startup_name/screens/search_view.dart';
import 'package:startup_name/screens/movie_detail.dart';
import 'package:startup_name/screens/settings.dart';
import 'package:startup_name/screens/widgets.dart';
import 'package:startup_name/api/endpoints.dart';
import 'package:flutter/rendering.dart';

//void main() => runApp(MyApp());

void main() {
  debugPaintSizeEnabled=true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Matinee',
        theme: ThemeData(
          primarySwatch: Colors.blue, canvasColor: Colors.transparent),
        home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Genres> _genres;

  @override
  void initState() {
    super.initState();
    fetchGenres().then((value) {
      _genres = value.genres;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: changeThemeBloc,
      builder: (BuildContext context, ChangeThemeState state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: state.themeData.accentColor,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                }
            ),
            centerTitle: true,
            title: Text(
              'Matinee',
              style: state.themeData.textTheme.headline,
            ),
            backgroundColor: state.themeData.primaryColor,
            actions: <Widget>[
              IconButton(
                color: state.themeData.accentColor,
                icon: Icon(Icons.search),
                onPressed: () async {
                  if(_genres != null) {
                    final Movie result = await showSearch(
                      context: context,
                      delegate: MovieSearch(
                        themeData: state.themeData, genres: _genres
                      )
                    );
                    if (result != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                              movie: result,
                              themeData: state.themeData,
                              genres: _genres,
                              heroId: '${result.id}search'
                            )
                        )
                      );
                    }
                  }
                },
              )
            ],
          ),
          drawer: Drawer(
            child: SettingsPage(),
          ),
          body: Container(
            color: state.themeData.primaryColor,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                DiscoverMovies(
                  themeData: state.themeData,
                  genres: _genres,
                ),
                ScrollingMovies(
                  themeData: state.themeData,
                  title: 'Top Rated',
                  api: Endpoints.topRatedUrl(1),
                  genres: _genres,
                ),
                ScrollingMovies(
                  themeData: state.themeData,
                  title: 'Now Playing',
                  api: Endpoints.nowPlayingMoviesUrl(1),
                  genres: _genres,
                ),
                ScrollingMovies(
                  themeData: state.themeData,
                  title: 'Popular',
                  api: Endpoints.popularMoviesUrl(1),
                  genres: _genres,
                ),
                FirstRoute()
              ],
            ),
          ),
        );
      }
    );
  }

}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(8.0),
      child: Text('Open route'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute()),
        );
      },
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}