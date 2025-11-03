class Category {
  final String name;
  final String description;
  final int wallpaperCount;
  final String imagePath;

  Category({
    required this.name,
    required this.description,
    required this.wallpaperCount,
    required this.imagePath,
  });
}

// Static list of categories matching the design
class CategoryData {
  static List<Category> getAllCategories() {
    return [
      Category(
        name: 'Nature',
        description: 'Mountains, Forest and Landscapes',
        wallpaperCount: 3,
        imagePath: 'assets/images/nature.png',
      ),
      Category(
        name: 'Abstract',
        description: 'Modern Geometric and artistic designs',
        wallpaperCount: 4,
        imagePath: 'assets/images/abstract.png',
      ),
      Category(
        name: 'Urban',
        description: 'Cities, architecture and street',
        wallpaperCount: 6,
        imagePath: 'assets/images/urban.png',
      ),
      Category(
        name: 'Space',
        description: 'Cosmos, planets, and galaxies',
        wallpaperCount: 3,
        imagePath: 'assets/images/space.png',
      ),
      Category(
        name: 'Minimalist',
        description: 'Clean, simple, and elegant',
        wallpaperCount: 6,
        imagePath: 'assets/images/minimalist.png',
      ),
      Category(
        name: 'Animals',
        description: 'Wildlife and nature photography',
        wallpaperCount: 4,
        imagePath: 'assets/images/animals.png',
      ),
    ];
  }
}