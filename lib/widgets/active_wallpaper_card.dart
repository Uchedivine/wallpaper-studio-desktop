import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActiveWallpaperCard extends StatelessWidget {
  final Map<String, dynamic> wallpaper;

  const ActiveWallpaperCard({
    Key? key,
    required this.wallpaper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              wallpaper['image'],
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          
          const SizedBox(width: 20),
          
          Expanded(
            child: Column(
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
                    'Your Active Wallpaper',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'This wallpaper is currently set as your active background',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip('Category', wallpaper['category']),
                    const SizedBox(width: 16),
                    _buildInfoChip('Selected', wallpaper['name']),
                  ],
                ),
              ],
            ),
          ),
          
          Row(
            children: [
              _buildIconButton(Icons.share_outlined),
              const SizedBox(width: 8),
              _buildIconButton(Icons.settings_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label - ',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        size: 18,
        color: const Color(0xFF6B7280),
      ),
    );
  }
}