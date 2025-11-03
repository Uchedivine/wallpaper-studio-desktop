import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/category.dart';
import '../widgets/top_navigation.dart';
import '../widgets/category_card.dart';
import '../screens/category_details_screen.dart'; //

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    final categories = CategoryData.getAllCategories();
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const TopNavigation(activeTab: 'Browse'), // Pass active tab
          
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 48, 40, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 32),
                    isGridView 
                        ? _buildGridView(categories)
                        : _buildListView(categories),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
                'Browse Categories',
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
              'Explore our curated collections of stunning wallpapers',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildViewButton(
                icon: Icons.grid_view,
                isActive: isGridView,
                onTap: () => setState(() => isGridView = true),
              ),
              _buildViewButton(
                icon: Icons.view_list,
                isActive: !isGridView,
                onTap: () => setState(() => isGridView = false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildViewButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFF9E6) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? const Color(0xFFFF8A3D) : const Color(0xFF9CA3AF),
        ),
      ),
    );
  }

  Widget _buildGridView(List<Category> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.6,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: categories[index]);
      },
    );
  }

  Widget _buildListView(List<Category> categories) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return _buildListItem(categories[index]);
      },
    );
  }

 Widget _buildListItem(Category category) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryDetailsScreen(
            category: category,
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              category.imagePath,
              width: 120,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          
          const SizedBox(width: 20),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${category.wallpaperCount} wallpapers',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 20),
        ],
      ),
    ),
  );
}
}