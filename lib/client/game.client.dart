import 'package:dio/dio.dart';
import 'package:gameg/helperfiles/logger.helper.dart';
import 'package:gameg/models/generated/gamecardpage.json.model.dart';
import 'package:gameg/models/generated/page.json.model.dart';
import 'package:gameg/models/userGenarated/game.model.dart';
import 'package:logger/logger.dart';

class GameClient {
  static final GameClient instance = GameClient();
  static final Logger _log = getLogger("GameClient");

  final String GAME_RESOURCE_URL = "https://api.rawg.io/api/games";
  final int GAMES_PER_PAGE = 40;

  final Dio dio = Dio();

  Future<List<Game>> loadGamesOnPage(int pageNumber, int genre, String searchText) async {
    _log.i("the search text is  :$searchText");
    Map<String, dynamic> queryParameters = {};
    print(genre);
    if (searchText != "") {
      queryParameters.putIfAbsent("search", () => searchText);
    }
    if (genre != 0) {
      queryParameters.putIfAbsent("genres", () => genre);
    }
    queryParameters.putIfAbsent("page", () => pageNumber);
    queryParameters.putIfAbsent("page_size", () => GAMES_PER_PAGE);

    try {
      _log.i("loading list of games for page number ${pageNumber} with params $queryParameters}");
      Response response = await dio.get(GAME_RESOURCE_URL, queryParameters: queryParameters);
      _log.d("got response from rest url: $GAME_RESOURCE_URL");
      _log.d("response data: ${response.data}");
      ListOfGamesPage listOfGamesPage = ListOfGamesPage.fromJson(response.data);
      List<Game> gameList = Game.getGamesFrom(listOfGamesPage);
      _log.i("received ${gameList.length} games from rest url");
      return gameList;
    } catch (error) {
      return Future.error(error);
    }
  }

//  Future getDescriptionAndSuggestedGames(Game game, int suggestionPageNum) async {
////    _log.i("loading game description for game: ${game.gameId}");
//    String description = await loadGameDescription(game);
//
////    _log.i("loading game suggestion for game: ${game.gameId} at pageNum: ${suggestionPageNum}");
// //   List<Game> suggested = await suggestRelatedGames(game.gameId, suggestionPageNum);
//   // return Future.value([description, suggested]);
//    return Future.value([description]);
//  }

//  Future suggestRelatedGames(int gameId, int pageNum) async {
//    Map<String, dynamic> queryParameters = {
//      "page": pageNum,
//      "page_size": 40,
//    };
//
//    String url = "$GAME_RESOURCE_URL/$gameId/suggested";
//    Response response = await dio.get(url, queryParameters: queryParameters);
//    var games = response.data;
//    ListOfGamesPage listOfGamesPage = ListOfGamesPage.fromJson(games);
//    List<Game> gameList = Game.getGamesFrom(listOfGamesPage);
////    _log.i("receved game suggestion for game: ${gameId} at pageNum: ${pageNum}. no of suggestion: ${gameList.length}");
//    return gameList;
//  }

  Future loadGameDescription(Game game) async {
    _log.i("calling loadGameDescription ");

//    if (game.description != null || game.description != "")
//      return game.description;

    if (game.description == null || game.description == "")
      _log.i("game description is empty , going to call api ");

    String url = "$GAME_RESOURCE_URL/${game.gameId}";
    Response futurePage = await dio.get(url);

    GameCardPageDetails gameCardPageDetails = GameCardPageDetails.fromJson(futurePage.data);
    var descriptionRaw = gameCardPageDetails.descriptionRaw;
    var website=gameCardPageDetails.website;
    return Future.value([descriptionRaw, website]);
 //   return descriptionRaw;
  }
}
