import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../widgets/top_navigation.dart';
import '../services/favourites_service.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final FavouritesService _favouritesService = FavouritesService();

  @override
  void initState() {
    super.initState();
    _favouritesService.addListener(_onFavouritesChanged);
  }

  @override
  void dispose() {
    _favouritesService.removeListener(_onFavouritesChanged);
    super.dispose();
  }

  void _onFavouritesChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final savedWallpapers = _favouritesService.favourites;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const TopNavigation(activeTab: 'Favourites'),
          
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFBB03B), Color(0xFFEC0C43)],
                      ).createShader(bounds),
                      child: Text(
                        'Saved Wallpapers',
                         style: const TextStyle(
    fontFamily: 'ClashDisplay',
    fontSize: 60,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.0,
    letterSpacing: 0,
  ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your saved wallpapers collection',
                      style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    savedWallpapers.isEmpty
                        ? _buildEmptyState(context)
                        : _buildWallpaperGrid(savedWallpapers),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.favorite, size: 60, color: Color(0xFFD1D5DB)),
                  Positioned(
                    right: 25,
                    top: 25,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check, size: 24, color: Color(0xFFD1D5DB)),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'No Saved Wallpapers',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
            
            const SizedBox(height: 8),
            
            const Text(
              'Start adding your favorite wallpapers and find them here',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            
            const SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/browse');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBB03B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text(
                'Browse Wallpapers',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWallpaperGrid(List<Map<String, dynamic>> wallpapers) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: wallpapers.length,
      itemBuilder: (context, index) {
        return _buildWallpaperCard(wallpapers[index]);
      },
    );
  }

  Widget _buildWallpaperCard(Map<String, dynamic> wallpaper) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(wallpaper['image'], fit: BoxFit.cover),
            
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  _favouritesService.removeFavourite(wallpaper['id']);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite, size: 18, color: Colors.white),
                ),
              ),
            ),
            
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wallpaper['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    wallpaper['category'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}