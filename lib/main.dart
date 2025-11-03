import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/browse_screen.dart';
import 'screens/wallpaper_setup_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/favourites_screen.dart';

void main() {
  runApp(const WallpaperStudioApp());
}

class WallpaperStudioApp extends StatelessWidget {
  const WallpaperStudioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ClashDisplay',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Homepage(),
        '/browse': (context) => const BrowseScreen(),
        '/setup': (context) => const WallpaperSetupScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/favourites': (context) => const FavouritesScreen(),
      },
    );
  }
}