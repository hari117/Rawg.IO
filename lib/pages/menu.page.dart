import 'package:flutter/material.dart';
import 'package:rawg/rebuilderstates/home.satate.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MenuOptions extends StatefulWidget {
  @override
  _MenuOptionsState createState() => _MenuOptionsState();
}

class _MenuOptionsState extends State<MenuOptions> {
  HomePageState menuState = HomePageState.homePageState;
  List<String> genres = ["Action", "Strategy", "RPG", "Shooter", "Adventure", "Puzzle", "Racing", "Sports"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: StateBuilder(
          observe: () => menuState,
          builder: (con, _) {
            return Column(
              children: [
                Container(
//                    width: double.infinity,
//                    height: double.infinity,
                    child: Column(
                  children: [
                    genresSection("action", context),
                    genresSection("shooter", context),
                    genresSection("strategy", context),
                    genresSection("racing", context),
                    genresSection("sports", context),
                  ],
                )),
              ],
            );
          },
        ),
      ),
      floatingActionButton: floatingButton(),
    );
  }

  genresSection(String name, BuildContext context) {
    return InkWell(
      onTap: () {
        menuState.resetState();
        menuState.genresSeter(name);
        menuState.loadNextPage();
        Navigator.pop(context);
      },
      child: Text(
        name,
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }

  floatingButton() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.clear,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
    );
  }
}