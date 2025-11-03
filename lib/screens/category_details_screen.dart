import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/category.dart';
import '../widgets/top_navigation.dart';
import '../screens/wallpaper_setup_screen.dart';
import '../services/favourites_service.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final Category category;

  const CategoryDetailsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  int selectedWallpaperIndex = 0;
  final FavouritesService _favouritesService = FavouritesService();

  @override
  Widget build(BuildContext context) {
    final wallpapers = List.generate(
      6,
      (index) => {
        'id': '${widget.category.name.toLowerCase()}_${index + 1}',
        'name': '${widget.category.name} ${index + 1}',
        'image': widget.category.imagePath,
        'category': widget.category.name,
        'description': widget.category.description,
      },
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const TopNavigation(),
          
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWideScreen = constraints.maxWidth > 1000;
                
                if (isWideScreen) {
                  return _buildWideLayout(wallpapers);
                } else {
                  return _buildNarrowLayout(wallpapers);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWideLayout(List<Map<String, dynamic>> wallpapers) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                const SizedBox(height: 24),
                _buildCategoryHeader(),
                const SizedBox(height: 24),
                Expanded(
                  child: _buildWallpaperGrid(wallpapers),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 32),
          
          SizedBox(
            width: 350,
            child: _buildPreviewSection(wallpapers[selectedWallpaperIndex]),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout(List<Map<String, dynamic>> wallpapers) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(context),
            const SizedBox(height: 16),
            _buildCategoryHeader(),
            const SizedBox(height: 24),
            _buildPreviewSection(wallpapers[selectedWallpaperIndex]),
            const SizedBox(height: 24),
            _buildWallpaperGrid(wallpapers, scrollable: false),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.arrow_back, size: 18, color: Color(0xFF6B7280)),
          SizedBox(width: 8),
          Text(
            'Back to Categories',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Row(
      children: [
        Text(
          widget.category.name,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${widget.category.wallpaperCount}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF8A3D),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWallpaperGrid(List<Map<String, dynamic>> wallpapers, {bool scrollable = true}) {
    return GridView.builder(
      shrinkWrap: !scrollable,
      physics: scrollable ? null : const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: wallpapers.length,
      itemBuilder: (context, index) {
        final isSelected = selectedWallpaperIndex == index;
        final wallpaper = wallpapers[index];
        final isFavorite = _favouritesService.isFavourite(wallpaper['id']);
        
        return InkWell(
          onTap: () {
            setState(() {
              selectedWallpaperIndex = index;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? const Color(0xFFFF8A3D) : Colors.transparent,
                width: 3,
              ),
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
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _favouritesService.toggleFavourite(wallpaper);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Text(
                      wallpaper['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviewSection(Map<String, dynamic> wallpaper) {
    final isFavorite = _favouritesService.isFavourite(wallpaper['id']);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Preview',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            
            // Phone mockup with realistic design
            Center(
              child: Container(
                width: 220,
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Phone bezel
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.black,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Stack(
                          children: [
                            // Wallpaper image
                            Positioned.fill(
                              child: Image.asset(
                                wallpaper['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            // Status bar overlay (top)
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Time
                                      const Text(
                                        '9:41',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // Status icons
                                      Row(
                                        children: const [
                                          Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 14),
                                          SizedBox(width: 4),
                                          Icon(Icons.wifi, color: Colors.white, size: 14),
                                          SizedBox(width: 4),
                                          Icon(Icons.battery_full, color: Colors.white, size: 14),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            
                            // Dynamic Island / Notch
                            Positioned(
                              top: 8,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Wallpaper name
            Text(
              wallpaper['name'],
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTag(wallpaper['category']),
                _buildTag('Landscape'),
                _buildTag('Flowers'),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Description
            Text(
              wallpaper['description'] ?? 'Discover the peace beauty of Trillium Tabletop – where gardening meets serenity in butterly beautiful tablescapes. let nature bloom on your table and create an enchanting paradise right from the comfort of home',
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
                height: 1.6,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              children: [
                _buildActionButton(Icons.download_outlined),
                const SizedBox(width: 8),
                _buildActionButton(Icons.share_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _favouritesService.toggleFavourite(wallpaper);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isFavorite ? const Color(0xFFFFF9E6) : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isFavorite ? const Color(0xFFFF8A3D) : const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFavorite ? const Color(0xFFFF8A3D) : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Save to favorites button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _favouritesService.toggleFavourite(wallpaper);
                  });
                },
                icon: Icon(
                  isFavorite ? Icons.bookmark : Icons.bookmark_border,
                  size: 18,
                ),
                label: Text(isFavorite ? 'Saved to favorites' : 'Save to favorites'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                    color: isFavorite ? const Color(0xFFFF8A3D) : const Color(0xFFE5E7EB),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: isFavorite ? const Color(0xFFFF8A3D) : const Color(0xFF6B7280),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Set as wallpaper button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WallpaperSetupScreen(
                        wallpaper: wallpaper,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBB03B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Set as Wallpaper',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
          ),
        ),
      ),
    );
  }
}