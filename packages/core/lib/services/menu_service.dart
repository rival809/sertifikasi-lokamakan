import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/models/restaurant_menu_model.dart';
import 'dart:developer';

class MenuService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  static CollectionReference<Map<String, dynamic>> get _menusCollection =>
      _firestore.collection('menus');

  static CollectionReference<Map<String, dynamic>> get _categoriesCollection =>
      _firestore.collection('menu_categories');

  /// Get menu for a specific restaurant
  static Future<RestaurantMenu?> getRestaurantMenu(String restaurantId) async {
    try {
      // Get menu document
      final menuDoc = await _menusCollection.doc(restaurantId).get();

      if (!menuDoc.exists) {
        log('Menu not found for restaurant: $restaurantId');
        return null;
      }

      final menuData = menuDoc.data()!;
      return RestaurantMenu.fromJson(menuData);
    } catch (e) {
      log('Error fetching restaurant menu: $e');
      return null;
    }
  }

  /// Get menu items by category
  static Future<List<MenuItem>> getMenuItemsByCategory(
      String restaurantId, String categoryId) async {
    try {
      final menuDoc = await _menusCollection.doc(restaurantId).get();

      if (!menuDoc.exists) return [];

      final menuData = menuDoc.data()!;
      final menu = RestaurantMenu.fromJson(menuData);

      return menu.getItemsByCategory(categoryId);
    } catch (e) {
      log('Error fetching menu items by category: $e');
      return [];
    }
  }

  /// Get all menu categories
  static Future<List<MenuCategory>> getAllMenuCategories() async {
    try {
      final snapshot = await _categoriesCollection
          .where('isActive', isEqualTo: true)
          .orderBy('sortOrder')
          .get();

      return snapshot.docs
          .map((doc) => MenuCategory.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log('Error fetching menu categories: $e');
      return [];
    }
  }

  /// Add or update restaurant menu
  static Future<bool> saveRestaurantMenu(RestaurantMenu menu) async {
    try {
      await _menusCollection.doc(menu.restaurantId).set(menu.toJson());
      log('Menu saved for restaurant: ${menu.restaurantId}');
      return true;
    } catch (e) {
      log('Error saving restaurant menu: $e');
      return false;
    }
  }

  /// Add menu item to restaurant
  static Future<bool> addMenuItem(MenuItem item) async {
    try {
      final menuDoc = await _menusCollection.doc(item.restaurantId).get();

      RestaurantMenu menu;
      if (menuDoc.exists) {
        menu = RestaurantMenu.fromJson(menuDoc.data()!);
      } else {
        menu = RestaurantMenu(
          restaurantId: item.restaurantId,
          categories: [],
          items: [],
          lastUpdated: DateTime.now(),
        );
      }

      // Add the new item
      final updatedItems = [...menu.items, item];
      final updatedMenu = RestaurantMenu(
        restaurantId: menu.restaurantId,
        categories: menu.categories,
        items: updatedItems,
        lastUpdated: DateTime.now(),
      );

      return await saveRestaurantMenu(updatedMenu);
    } catch (e) {
      log('Error adding menu item: $e');
      return false;
    }
  }

  /// Update menu item
  static Future<bool> updateMenuItem(MenuItem item) async {
    try {
      final menuDoc = await _menusCollection.doc(item.restaurantId).get();

      if (!menuDoc.exists) return false;

      final menu = RestaurantMenu.fromJson(menuDoc.data()!);

      // Find and update the item
      final updatedItems = menu.items.map((existingItem) {
        if (existingItem.id == item.id) {
          return item.copyWith(updatedAt: DateTime.now());
        }
        return existingItem;
      }).toList();

      final updatedMenu = RestaurantMenu(
        restaurantId: menu.restaurantId,
        categories: menu.categories,
        items: updatedItems,
        lastUpdated: DateTime.now(),
      );

      return await saveRestaurantMenu(updatedMenu);
    } catch (e) {
      log('Error updating menu item: $e');
      return false;
    }
  }

  /// Delete menu item
  static Future<bool> deleteMenuItem(String restaurantId, String itemId) async {
    try {
      final menuDoc = await _menusCollection.doc(restaurantId).get();

      if (!menuDoc.exists) return false;

      final menu = RestaurantMenu.fromJson(menuDoc.data()!);

      // Remove the item
      final updatedItems =
          menu.items.where((item) => item.id != itemId).toList();

      final updatedMenu = RestaurantMenu(
        restaurantId: menu.restaurantId,
        categories: menu.categories,
        items: updatedItems,
        lastUpdated: DateTime.now(),
      );

      return await saveRestaurantMenu(updatedMenu);
    } catch (e) {
      log('Error deleting menu item: $e');
      return false;
    }
  }

  /// Search menu items
  static Future<List<MenuItem>> searchMenuItems(
      String restaurantId, String query) async {
    try {
      final menu = await getRestaurantMenu(restaurantId);
      if (menu == null) return [];

      final lowerQuery = query.toLowerCase();
      return menu.items.where((item) {
        return item.name.toLowerCase().contains(lowerQuery) ||
            item.description?.toLowerCase().contains(lowerQuery) == true ||
            item.ingredients?.any((ingredient) =>
                    ingredient.toLowerCase().contains(lowerQuery)) ==
                true;
      }).toList();
    } catch (e) {
      log('Error searching menu items: $e');
      return [];
    }
  }

  /// Get popular menu items (based on some criteria)
  static Future<List<MenuItem>> getPopularMenuItems(String restaurantId) async {
    try {
      final menu = await getRestaurantMenu(restaurantId);
      if (menu == null) return [];

      // For now, return first 5 available items
      // In real app, this could be based on order frequency, ratings, etc.
      return menu.availableItems.take(5).toList();
    } catch (e) {
      log('Error fetching popular menu items: $e');
      return [];
    }
  }

  /// Note: Auto-generate sample menu function has been removed.
  /// To add menu data, please use the manual input method via Firebase Console
  /// or use the CRUD methods above to programmatically add menu items.
  ///
  /// For manual input examples, see: MENU_DATA_FIREBASE.md

  // /// Generate sample menu data for a restaurant - REMOVED
  // static RestaurantMenu generateSampleMenu(String restaurantId) {
  //   // Function removed to prevent auto-generation of sample data
  //   // Use manual input methods instead
  // }
}
