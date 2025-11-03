import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/category.dart';
import '../widgets/top_navigation.dart';
import '../widgets/category_card.dart';
import '../widgets/active_wallpaper_card.dart';
import '../services/active_wallpaper_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ActiveWallpaperService _activeWallpaperService = ActiveWallpaperService();

  @override
  void initState() {
    super.initState();
    _activeWallpaperService.addListener(_onActiveWallpaperChanged);
  }

  @override
  void dispose() {
    _activeWallpaperService.removeListener(_onActiveWallpaperChanged);
    super.dispose();
  }

  void _onActiveWallpaperChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final categories = CategoryData.getAllCategories();
    final hasActiveWallpaper = _activeWallpaperService.hasActiveWallpaper;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const TopNavigation(activeTab: 'Home'),
          
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 48, 40, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasActiveWallpaper) ...[
                      ActiveWallpaperCard(
                        wallpaper: _activeWallpaperService.activeWallpaper!,
                      ),
                      const SizedBox(height: 32),
                    ] else ...[
                      _buildHeroSection(),
                      const SizedBox(height: 48),
                    ],
                    
                    _buildCategoriesSection(categories),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFFFBB03B),
              Color(0xFFEC0C43),
            ],
          ).createShader(bounds),
          child: Text(
            'Discover Beautiful Wallpapers',
            style: GoogleFonts.poppins(
              fontSize: 60,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Discover curated collections of stunning wallpapers. Browse by\ncategory, preview in full-screen, and set your favorites.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(List<Category> categories) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/browse');
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.linkBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.7,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(category: categories[index]);
          },
        ),
      ],
    );
  }
}