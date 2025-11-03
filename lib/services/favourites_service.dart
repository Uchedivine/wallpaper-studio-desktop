import 'package:flutter/foundation.dart';

class FavouritesService extends ChangeNotifier {
  static final FavouritesService _instance = FavouritesService._internal();
  factory FavouritesService() => _instance;
  FavouritesService._internal();

  final List<Map<String, dynamic>> _favourites = [];

  List<Map<String, dynamic>> get favourites => List.unmodifiable(_favourites);

  bool isFavourite(String wallpaperId) {
    return _favourites.any((w) => w['id'] == wallpaperId);
  }

  void toggleFavourite(Map<String, dynamic> wallpaper) {
    final index = _favourites.indexWhere((w) => w['id'] == wallpaper['id']);
    
    if (index >= 0) {
      _favourites.removeAt(index);
    } else {
      _favourites.add(wallpaper);
    }
    
    notifyListeners();
  }

  void removeFavourite(String wallpaperId) {
    _favourites.removeWhere((w) => w['id'] == wallpaperId);
    notifyListeners();
  }
}