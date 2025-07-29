# 🍽️ LOKAMAKAN - Restaurant Discovery App

Aplikasi mobile Flutter untuk menemukan restoran lokal dengan fitur Location Based Service (LBS) dan Firebase backend.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

## 📋 Fitur Utama

### ✅ Sudah Diimplementasi
- **🏠 Beranda Screen**: Daftar restoran dengan search dan filter (Semua/Terdekat)
- **❤️ Favorites Management**: Sistem favorit dengan local storage (Hive) + timestamp
- **📍 Location Based Service**: GPS positioning dan distance calculation
- **🔐 Authentication**: Firebase Auth dengan Google Sign-in integration
- **☁️ Cloud Storage**: Firebase Firestore untuk restaurant data
- **🎨 Reusable Components**: BaseAppDrawer dan BaseRestaurantCard
- **🌓 Theme System**: Dark/Light mode dengan Material Design 3
- **📱 Responsive UI**: Adaptive design dengan SliverAppBar
- **🔄 Offline Support**: Local caching dengan refresh capabilities
- **🚪 Navigation Drawer**: Unified drawer dengan logout functionality

### 🔜 Fitur Mendatang  
- **🗺️ Google Maps Integration**: Visual map dengan markers
- **🧭 Navigation**: Petunjuk arah ke restoran
- **📝 Reviews & Ratings**: Sistem review dan rating user
- **🔔 Push Notifications**: Notifikasi promo dan update
- **🎯 Geofencing**: Alert saat dekat restoran favorit
- **📊 Restaurant Details**: Detail view dengan foto dan info lengkap

## 📁 Struktur Project

```
sertifikasi/
├── lib/                          # Main app entry point
│   ├── main.dart                 # App initialization dengan Firebase
│   ├── setup.dart               # Global setup dan dependencies
│   ├── core_package.dart        # Core package exports
│   └── firebase_options.dart    # Firebase configuration
├── packages/
│   ├── core/                    # 🔧 Shared utilities & reusable components
│   │   ├── lib/
│   │   │   ├── models/          # Data models (RestaurantLocation, etc.)
│   │   │   ├── services/        # Business logic services
│   │   │   │   ├── auth_service.dart      # Firebase authentication
│   │   │   │   ├── firestore_service.dart # Cloud data operations
│   │   │   │   ├── location_service.dart  # GPS & distance calculation
│   │   │   │   ├── favorite_service.dart  # Favorites management
│   │   │   │   └── session_service.dart   # User session
│   │   │   ├── database/        # Local storage (Hive)
│   │   │   │   ├── favorite_restaurant_model.dart
│   │   │   │   └── favorite_database.dart
│   │   │   ├── widgets/         # 🎨 Reusable UI components
│   │   │   │   ├── drawer/      # BaseAppDrawer + examples
│   │   │   │   ├── restaurant_card/  # BaseRestaurantCard
│   │   │   │   ├── base_button/ # Standardized buttons
│   │   │   │   └── base_form/   # Form components
│   │   │   ├── themes/          # App theming system
│   │   │   └── utils/           # Helper utilities
│   │   └── pubspec.yaml
│   └── base/                    # 📱 Feature modules
│       ├── lib/
│       │   ├── beranda/         # 🏠 Home screen
│       │   │   ├── view/        # BerandaView dengan search & filter
│       │   │   └── controller/  # BerandaController business logic
│       │   ├── favorites/       # ❤️ Favorites feature  
│       │   │   ├── view/        # FavoritesView dengan time tracking
│       │   │   └── controller/  # FavoritesController
│       │   └── models/         # Feature-specific models
│       └── pubspec.yaml
├── android/                     # Android configuration
│   └── app/
│       └── google-services.json # Firebase Android config
├── ios/                        # iOS configuration
├── firebase.json              # Firebase project configuration
├── firestore.rules           # Firestore security rules
├── functions/                 # Firebase Cloud Functions (future)
├── JAWABAN_SERTIFIKASI.md    # Technical documentation
└── pubspec.yaml              # Main dependencies
```

## 🏗️ Architecture Overview

### Clean Architecture + Package-by-Feature

```
┌─────────────────┐
│   Presentation  │ ← Views (BerandaView, FavoritesView)
├─────────────────┤
│   Business      │ ← Controllers, Services (LocationService, etc.)
├─────────────────┤
│   Data          │ ← Repositories, Models (Hive + Firestore)
└─────────────────┘
```

### Current Implementation Highlights

**🎨 Reusable Component System:**
- `BaseAppDrawer`: Unified navigation drawer untuk semua screens
- `BaseRestaurantCard`: Consistent restaurant card dengan favorite toggle
- Theme-aware components dengan Material Design 3

**📊 Data Flow:**
```
Firebase Firestore → FirestoreService → Controllers → Views
                  ↓
Local Hive Cache ← FavoriteService ← User Actions
```

**🗂️ State Management:**
- Local State: `setState()` untuk UI interactions
- Global State: Services untuk data management  
- Persistence: Hive (offline) + Firestore (cloud sync)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.3.4)
- Dart SDK (>=3.3.4)
- Android Studio / VS Code
- Firebase account
- Google Services JSON file

### Installation

1. **Clone repository**
   ```bash
   git clone https://github.com/rival809/sertifikasi-lokamakan.git
   cd sertifikasi-lokamakan
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   cd packages/core && flutter pub get
   cd ../base && flutter pub get
   cd ../..
   ```

3. **Generate Hive adapters (untuk favorites)**
   ```bash
   cd packages/core
   flutter packages pub run build_runner build
   cd ../..
   ```

4. **Firebase Setup**
   - Create Firebase project di console.firebase.google.com
   - Enable Firestore Database, Authentication, Storage
   - Download `google-services.json` ke `android/app/`
   - Setup iOS configuration jika diperlukan
   - Import sample restaurant data ke Firestore

5. **Run aplikasi**
   ```bash
   flutter run
   ```

## 🔧 Key Services Implementation

### LocationService
```dart
class LocationService {
  // Get current user GPS location
  static Future<Position?> getCurrentLocation() async {
    // Permission handling + GPS positioning
  }
  
  // Calculate distance using Haversine formula  
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    // Returns distance in kilometers
  }
  
  // Format distance for UI display
  static String formatDistance(double? distance) {
    // "1.2 km" or "500 m"
  }
}
```

### FavoriteService
```dart
class FavoriteService {
  // Add restaurant to favorites with timestamp
  static Future<void> addToFavorites(RestaurantLocation restaurant) async {
    // Save to local Hive database
  }
  
  // Check if restaurant is favorited
  static bool isFavorite(String restaurantId) {
    // Query local database
  }
  
  // Get all favorites with "added time ago" info
  static List<FavoriteRestaurant> getAllFavorites() {
    // Return sorted by addedAt desc
  }
}
```

### AuthService
```dart
class AuthService {
  // Google Sign-in integration
  static Future<User?> signInWithGoogle() async {
    // Firebase + Google OAuth flow
  }
  
  // Get current user session
  static User? getCurrentUser() {
    // Firebase Auth current user
  }
}
```

## 📊 Data Models

### RestaurantLocation (Core Model)
```dart
class RestaurantLocation {
  final String id;
  final String name;
  final GeoPoint location;      // Firebase GeoPoint
  final String address;
  final String city;
  final double? rating;
  final String? pictureUrl;     // Firebase Storage URL
  final String? description;
  final double? distance;       // Calculated from user location
  
  // Factory constructor from Firestore document
  factory RestaurantLocation.fromFirestore(DocumentSnapshot doc);
}
```

### FavoriteRestaurant (Hive Local Storage)
```dart
@HiveType(typeId: 10)
class FavoriteRestaurant extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) final String name;
  @HiveField(2) final String? description;
  @HiveField(3) final double? rating;
  @HiveField(4) final DateTime addedAt;      // Timestamp untuk "X jam yang lalu"
  @HiveField(5) final String userId;
  @HiveField(6) final String? address;
  @HiveField(7) final String? city;
  @HiveField(8) final String? pictureId;
  
  // Helper method untuk time display
  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(addedAt);
    // Return "2 jam yang lalu", "1 hari yang lalu", etc.
  }
}
```

### User Authentication Model
```dart
class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final DateTime? lastLoginAt;
  
  // Convert from Firebase User
  factory UserModel.fromFirebaseUser(User user);
}
```

## 🎨 Reusable Components

### BaseAppDrawer
```dart
// Factory constructors untuk different configurations
BaseAppDrawer.beranda({
  required VoidCallback onRestaurantListTap,
  required VoidCallback onFavoriteTap,
});

BaseAppDrawer.custom({
  required List<DrawerMenuModel> menuItems,
  VoidCallback? onLogout,
});
```

### BaseRestaurantCard  
```dart
// Unified card untuk beranda dan favorites
BaseRestaurantCard.withFavorite({
  required RestaurantLocation restaurant,
  required bool isFavorite,
  required VoidCallback onFavoriteToggle,
  DateTime? addedAt,           // Optional untuk favorites
  bool showDistance = false,   // Show untuk "Terdekat" filter
  VoidCallback? onTap,
});
```

## 🔄 Current App Flow

### 1. Beranda Screen Flow
```
Launch App → Firebase Auth Check → BerandaView
    ↓
Load Restaurants → GPS Location → Calculate Distances  
    ↓
Display Cards → Search/Filter → Favorite Toggle
```

### 2. Favorites Screen Flow  
```
Favorites Tab → Load from Hive → Display with Timestamps
    ↓
"2 jam yang lalu" → Remove Option → Refresh Available
```

### 3. Authentication Flow
```
Google Sign-in → Firebase Auth → Session Storage
    ↓  
User Profile → Drawer Display → Logout Option
```

## 🛠️ Development Guidelines

### Current Features Status

**✅ Implemented:**
- ✅ Restaurant listing dengan search functionality
- ✅ Distance-based filtering (Semua/Terdekat)
- ✅ Favorite management dengan local persistence
- ✅ Google Sign-in authentication
- ✅ Drawer navigation sistem
- ✅ Theme-aware UI components
- ✅ Time tracking untuk favorites ("X jam yang lalu")
- ✅ Offline-first architecture

**🔧 Current Limitations:**
- Restaurant detail page belum diimplementasi
- Google Maps integration belum ada
- Review & rating system belum ada
- Push notifications belum setup
- Image upload functionality belum ada

### Code Style & Standards
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` sebelum commit
- Prefer `const` constructors ketika memungkinkan
- Use meaningful variable names
- Add documentation untuk public APIs

### Testing Strategy
```bash
# Unit tests untuk services
flutter test test/unit/

# Widget tests untuk components  
flutter test test/widget/

# Integration tests (future)
flutter drive --target=test_driver/app.dart
```

### Performance Best Practices
```dart
// ✅ Good: Use const constructors
const Text('Restaurant Name');

// ✅ Good: ListView.builder untuk large lists
ListView.builder(
  itemCount: restaurants.length,
  itemBuilder: (context, index) => RestaurantCard(...),
);

// ✅ Good: Cache network images
CachedNetworkImage(imageUrl: restaurant.pictureUrl);

// ✅ Good: Efficient distance calculation
final distance = LocationService.calculateDistance(
  userLat, userLng, restaurant.lat, restaurant.lng
);
```

### Firebase Best Practices
```dart
// ✅ Use compound queries efficiently
Query restaurantsQuery = FirebaseFirestore.instance
  .collection('restaurants')
  .where('isActive', isEqualTo: true)
  .where('city', isEqualTo: userCity)
  .orderBy('rating', descending: true);

// ✅ Handle offline scenarios
try {
  final restaurants = await FirestoreService.getRestaurants();
  return restaurants;
} catch (e) {
  // Fallback to cached data
  return CacheService.getCachedRestaurants();
}
```

## 📱 Screenshots & UI Examples

### Beranda Screen
- **SliverAppBar** dengan search functionality
- **Filter buttons**: "Semua" dan "Terdekat"  
- **Restaurant cards** dengan favorite toggle
- **Distance display** untuk nearby filter

### Favorites Screen
- **Header** dengan total count dan clear all option
- **Time tracking**: "Ditambahkan: 2 jam yang lalu"
- **Remove functionality** dengan confirmation
- **Empty state** dengan call-to-action

### Navigation Drawer
- **User profile** dengan Google account info
- **Menu items**: Restaurant List, Favorites
- **Logout button** dengan confirmation dialog

## 🔮 Roadmap & Next Steps

### Phase 1: Core Enhancements (Current)
- ✅ Reusable component system
- ✅ Theme integration 
- ✅ Offline-first architecture
- 🔄 Restaurant detail page
- 🔄 Enhanced error handling

### Phase 2: Advanced Features
- 🔜 Google Maps integration
- 🔜 Navigation to restaurants
- 🔜 Reviews & ratings system
- 🔜 Photo upload functionality
- 🔜 Social sharing

### Phase 3: Scale & Performance
- 🔜 Push notifications
- 🔜 Analytics integration  
- 🔜 Performance monitoring
- 🔜 A/B testing framework
- 🔜 CI/CD pipeline

## 🤝 Contributing

### Development Workflow
1. Fork repository ini
2. Create feature branch: `git checkout -b feature/nama-fitur`
3. Commit changes: `git commit -m 'Add some feature'`
4. Push to branch: `git push origin feature/nama-fitur`  
5. Submit pull request

### Code Review Checklist
- [ ] Code follows Dart style guide
- [ ] All tests passing
- [ ] Documentation updated
- [ ] No lint warnings
- [ ] Performance considerations addressed

## 📄 License

Project ini dibuat untuk keperluan sertifikasi dan pembelajaran Flutter development.

## 🙏 Acknowledgments

- **Flutter Team** untuk framework yang amazing
- **Firebase** untuk backend infrastructure
- **Material Design** untuk design system
- **Open Source Community** untuk packages yang digunakan

---

> 💡 **Note**: Ini adalah implementasi sementara untuk tujuan sertifikasi. Beberapa fitur masih dalam tahap development dan akan terus dikembangkan.

**Developed with ❤️ using Flutter & Firebase**
