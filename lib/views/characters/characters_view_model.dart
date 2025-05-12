import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

enum CharacterType { all, alive, dead, unknown }

class CharactersViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  CharacterType characterType = CharacterType.all;

  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;

  void clearCharacters() {
    _charactersModel = null;
    currentPageIndex = 1;
    notifyListeners();
  }

  void getCharacters() async {
    _charactersModel = await _apiService.getCharacters();
    notifyListeners();
  }

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getCharactersMore() async {
    if (loadMore) return;

    if (_charactersModel!.info.pages == currentPageIndex) return;

    setLoadMore(true);
    final data = await _apiService.getCharacters(
      url: _charactersModel?.info.next,
    );
    setLoadMore(false);

    currentPageIndex++;

    _charactersModel!.info = data.info;
    _charactersModel!.characters.addAll(data.characters);

    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    _charactersModel = await _apiService.getCharacters(args: {'name': name});
    notifyListeners();
  }

  void onCharacterTypeChanged(CharacterType type) async {
    characterType = type;
    clearCharacters();

    Map<String, dynamic>? args;
    if (type != CharacterType.all) {
      args = {'status': type.name};
    }

    _charactersModel = await _apiService.getCharacters(args: args);
    notifyListeners();
  }
}
