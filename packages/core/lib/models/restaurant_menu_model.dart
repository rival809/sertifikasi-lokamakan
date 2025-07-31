import 'package:cloud_firestore/cloud_firestore.dart';

// Model untuk kategori menu
class MenuCategory {
  final String id;
  final String name;
  final String? description;
  final String? iconUrl;
  final int sortOrder;
  final bool isActive;

  const MenuCategory({
    required this.id,
    required this.name,
    this.description,
    this.iconUrl,
    this.sortOrder = 0,
    this.isActive = true,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      iconUrl: json['iconUrl'],
      sortOrder: json['sortOrder'] ?? 0,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'sortOrder': sortOrder,
      'isActive': isActive,
    };
  }
}

// Model untuk item menu
class MenuItem {
  final String id;
  final String restaurantId;
  final String categoryId;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final List<String>? ingredients;
  final List<String>? allergens;
  final bool isAvailable;
  final bool isSpicy;
  final bool isVegetarian;
  final bool isVegan;
  final bool isHalal;
  final String? cookingTime; // e.g., "15-20 menit"
  final double? calories;
  final Map<String, dynamic>? nutrition; // Info nutrisi
  final List<String>? variants; // Varian ukuran/rasa
  final DateTime createdAt;
  final DateTime updatedAt;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.name,
    required this.price,
    this.description,
    this.imageUrl,
    this.ingredients,
    this.allergens,
    this.isAvailable = true,
    this.isSpicy = false,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isHalal = true,
    this.cookingTime,
    this.calories,
    this.nutrition,
    this.variants,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'],
      ingredients: json['ingredients'] != null
          ? List<String>.from(json['ingredients'])
          : null,
      allergens: json['allergens'] != null
          ? List<String>.from(json['allergens'])
          : null,
      isAvailable: json['isAvailable'] ?? true,
      isSpicy: json['isSpicy'] ?? false,
      isVegetarian: json['isVegetarian'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isHalal: json['isHalal'] ?? true,
      cookingTime: json['cookingTime'],
      calories: json['calories']?.toDouble(),
      nutrition: json['nutrition'],
      variants:
          json['variants'] != null ? List<String>.from(json['variants']) : null,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'allergens': allergens,
      'isAvailable': isAvailable,
      'isSpicy': isSpicy,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'isHalal': isHalal,
      'cookingTime': cookingTime,
      'calories': calories,
      'nutrition': nutrition,
      'variants': variants,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Helper methods untuk UI
  String get formattedPrice {
    if (price >= 1000000) {
      return 'Rp ${(price / 1000000).toStringAsFixed(price % 1000000 == 0 ? 0 : 1)}jt';
    } else if (price >= 1000) {
      return 'Rp ${(price / 1000).toStringAsFixed(price % 1000 == 0 ? 0 : 0)}rb';
    } else {
      return 'Rp ${price.toStringAsFixed(0)}';
    }
  }

  String get dietaryInfo {
    List<String> info = [];
    if (isVegan) {
      info.add('Vegan');
    } else if (isVegetarian) info.add('Vegetarian');
    if (isHalal) info.add('Halal');
    if (isSpicy) info.add('Pedas');
    return info.join(' • ');
  }

  List<String> get tags {
    List<String> tags = [];
    if (isVegan) {
      tags.add('Vegan');
    } else if (isVegetarian) tags.add('Vegetarian');
    if (isHalal) tags.add('Halal');
    if (isSpicy) tags.add('Pedas');
    if (!isAvailable) tags.add('Tidak Tersedia');
    return tags;
  }

  MenuItem copyWith({
    String? id,
    String? restaurantId,
    String? categoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    List<String>? ingredients,
    List<String>? allergens,
    bool? isAvailable,
    bool? isSpicy,
    bool? isVegetarian,
    bool? isVegan,
    bool? isHalal,
    String? cookingTime,
    double? calories,
    Map<String, dynamic>? nutrition,
    List<String>? variants,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuItem(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      isAvailable: isAvailable ?? this.isAvailable,
      isSpicy: isSpicy ?? this.isSpicy,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isHalal: isHalal ?? this.isHalal,
      cookingTime: cookingTime ?? this.cookingTime,
      calories: calories ?? this.calories,
      nutrition: nutrition ?? this.nutrition,
      variants: variants ?? this.variants,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// Model untuk menu lengkap restoran
class RestaurantMenu {
  final String restaurantId;
  final List<MenuCategory> categories;
  final List<MenuItem> items;
  final DateTime lastUpdated;

  const RestaurantMenu({
    required this.restaurantId,
    required this.categories,
    required this.items,
    required this.lastUpdated,
  });

  // Mendapatkan items berdasarkan kategori
  List<MenuItem> getItemsByCategory(String categoryId) {
    return items.where((item) => item.categoryId == categoryId).toList();
  }

  // Mendapatkan items yang tersedia
  List<MenuItem> get availableItems {
    return items.where((item) => item.isAvailable).toList();
  }

  // Mendapatkan kategori yang aktif
  List<MenuCategory> get activeCategories {
    return categories.where((category) => category.isActive).toList();
  }

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) {
    return RestaurantMenu(
      restaurantId: json['restaurantId'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => MenuCategory.fromJson(e))
              .toList() ??
          [],
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => MenuItem.fromJson(e))
              .toList() ??
          [],
      lastUpdated:
          (json['lastUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'categories': categories.map((e) => e.toJson()).toList(),
      'items': items.map((e) => e.toJson()).toList(),
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }
}
