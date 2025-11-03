import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TopNavigation extends StatelessWidget {
  final String activeTab;

  const TopNavigation({
    Key? key,
    this.activeTab = 'Home',
  }) : super(key: key);

  void _handleTabChange(String tab, BuildContext context) {
    if (tab == activeTab) return;
    
    switch (tab) {
      case 'Home':
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 'Browse':
        Navigator.pushReplacementNamed(context, '/browse');
        break;
      case 'Favourites':
        Navigator.pushReplacementNamed(context, '/favourites');
        break;
      case 'Settings':
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.topBarBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
            child: Row(
              children: [
                // Updated logo with custom diamond shape
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomPaint(
                    painter: DiamondLogoPainter(),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Wallpaper Studio',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          Row(
            children: [
              _buildNavButton('Home', Icons.home, context),
              const SizedBox(width: 8),
              _buildNavButton('Browse', Icons.apps, context),
              const SizedBox(width: 8),
              _buildNavButton('Favourites', Icons.favorite_border, context),
              const SizedBox(width: 8),
              _buildNavButton('Settings', Icons.settings, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String label, IconData icon, BuildContext context) {
    final isActive = activeTab == label;
    
    return InkWell(
      onTap: () => _handleTabChange(label, context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.navActiveBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? AppColors.navIconActive : AppColors.navIconInactive,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.navTextActive : AppColors.navTextInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the diamond/star logo
class DiamondLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFF6B6B),
          Color(0xFFFF8E53),
          Color(0xFFFBB03B),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Create a 4-point star/diamond shape
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // Top point
    path.moveTo(centerX, 4);
    
    // Top-right curve
    path.quadraticBezierTo(
      centerX + 8, centerY - 8,
      size.width - 4, centerY,
    );
    
    // Bottom-right curve
    path.quadraticBezierTo(
      centerX + 8, centerY + 8,
      centerX, size.height - 4,
    );
    
    // Bottom-left curve
    path.quadraticBezierTo(
      centerX - 8, centerY + 8,
      4, centerY,
    );
    
    // Top-left curve
    path.quadraticBezierTo(
      centerX - 8, centerY - 8,
      centerX, 4,
    );
    
    path.close();
    
    canvas.drawPath(path, paint);
    
    // Add inner white sparkle for depth
    final whitePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    
    final innerPath = Path();
    innerPath.moveTo(centerX, centerY - 6);
    innerPath.lineTo(centerX + 2, centerY);
    innerPath.lineTo(centerX, centerY + 6);
    innerPath.lineTo(centerX - 2, centerY);
    innerPath.close();
    
    canvas.drawPath(innerPath, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}