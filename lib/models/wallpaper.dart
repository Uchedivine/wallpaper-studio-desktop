class Wallpaper {
  final String id;
  final String imageUrl;
  final String category;
  final String wallpaperNumber;
  final bool isActive;

  Wallpaper({
    required this.id,
    required this.imageUrl,
    required this.category,
    required this.wallpaperNumber,
    this.isActive = false,
  });
}