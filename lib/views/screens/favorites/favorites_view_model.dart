import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/app/locator.dart';
import 'package:rick_and_morty_app/models/characters_model.dart';
import 'package:rick_and_morty_app/services/api_service.dart';
import 'package:rick_and_morty_app/services/preferences_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final _preferencesService = locator<PreferencesService>();
  final _apiService = locator<ApiService>();

  List<int> _favorites = [];
  List<CharacterModel> _characters = [];

  List<CharacterModel> get characters => _characters;

  void getFavorites() {
    _favorites = _preferencesService.getSavedCharacters();
    _getCharacters();
  }

  void _getCharacters() async {
    _characters = await _apiService.getMultipleCharacters(_favorites);
    notifyListeners();
  }
}
