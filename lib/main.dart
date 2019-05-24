import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_name/modal_class/function.dart';
import 'package:startup_name/modal_class/genres.dart';
import 'package:startup_name/bloc/change_theme_bloc.dart';
import 'package:startup_name/bloc/change_theme_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Matinee',
        theme: ThemeData(
          primarySwatch: Colors.blue, canvasColor: Colors.transparent),
        home: Text('欢迎来到首页...'),
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
          ),
        );
      }
    );
  }

}
