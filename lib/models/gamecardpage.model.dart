import 'package:rawg/models/generated/gamecardpage.json.model.dart';

class GamePage {
//  int id;
//  String gameName;
  String gameDescription;

  GamePage(GameCardPageDetails gameCardPageDetails) {
//    this.id = gameCardPageDetails.id;
//    this.gameName = gameCardPageDetails.name;
    this.gameDescription = gameCardPageDetails.descriptionRaw;
  }
}
