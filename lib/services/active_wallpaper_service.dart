import 'package:flutter/foundation.dart';

class ActiveWallpaperService extends ChangeNotifier {
  static final ActiveWallpaperService _instance = ActiveWallpaperService._internal();
  factory ActiveWallpaperService() => _instance;
  ActiveWallpaperService._internal();

  Map<String, dynamic>? _activeWallpaper;

  Map<String, dynamic>? get activeWallpaper => _activeWallpaper;

  bool get hasActiveWallpaper => _activeWallpaper != null;

  void setActiveWallpaper(Map<String, dynamic> wallpaper) {
    _activeWallpaper = wallpaper;
    notifyListeners();
  }

  void clearActiveWallpaper() {
    _activeWallpaper = null;
    notifyListeners();
  }
}