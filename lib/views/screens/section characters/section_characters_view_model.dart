import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/app/locator.dart';
import 'package:rick_and_morty_app/models/characters_model.dart';
import 'package:rick_and_morty_app/models/episode_model.dart';
import 'package:rick_and_morty_app/services/api_service.dart';

class SectionCharactersViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;

  void getCharacters(EpisodeModel episodeModel) async {
    _characters = await _apiService.getCharactersFromUrlList(
      episodeModel.characters,
    );
    notifyListeners();
  }
}
