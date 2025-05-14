import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/app/locator.dart';
import 'package:rick_and_morty_app/models/location_model.dart';
import 'package:rick_and_morty_app/services/api_service.dart';

class LocationViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  LocationModel? _locationModel;
  LocationModel? get locationModel => _locationModel;

  void getLocations() async {
    _locationModel = await _apiService.getAllLocations();
    notifyListeners();
  }

  bool loadMore = false;
  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  int _page = 1;

  void getMoreLocation() async {
    if (loadMore && _page == _locationModel!.info.pages) return;
    setLoadMore(true);

    final data = await _apiService.getAllLocations(
      url: _locationModel!.info.next,
    );
    _page++;

    _locationModel!.info = data.info;
    _locationModel!.locations.addAll(data.locations);

    setLoadMore(false);
  }
}
