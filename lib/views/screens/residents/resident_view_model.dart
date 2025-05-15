import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/app/locator.dart';
import 'package:rick_and_morty_app/models/characters_model.dart';
import 'package:rick_and_morty_app/services/api_service.dart';

class ResidentViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel> _residents = [];
  List<CharacterModel> get residents => _residents;

  void getResidents(List residentsUrlList) async {
    _residents = await _apiService.getCharactersFromUrlList(
      residentsUrlList.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }
}
