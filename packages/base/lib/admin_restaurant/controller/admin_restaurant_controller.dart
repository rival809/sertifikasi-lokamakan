import 'dart:developer';
import 'dart:math' as math;
import 'package:base/admin_restaurant/view/admin_restaurant_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AdminRestaurantController extends State<AdminRestaurantView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  String validationMessage = '';
  bool isValidationError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  /// Clear the input fields
  void clearForm() {
    setState(() {
      nameController.clear();
      descriptionController.clear();
      validationMessage = '';
      isValidationError = false;
    });
  }

  /// Generate random restaurant data and save to Firebase
  Future<void> generateAndSaveRestaurant() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isEmpty) {
      _showValidationMessage('Nama restaurant wajib diisi', isError: true);
      return;
    }

    if (description.isEmpty) {
      _showValidationMessage('Deskripsi restaurant wajib diisi', isError: true);
      return;
    }

    setState(() {
      isLoading = true;
      validationMessage = '';
      isValidationError = false;
    });

    try {
      // Generate restaurant data with random values
      final restaurantData = _generateRestaurantData(name, description);

      // Save to Firebase
      await _saveToFirebase(restaurantData);

      _showValidationMessage(
          'Restaurant "$name" berhasil ditambahkan ke Firebase!');
      clearForm();
    } catch (e) {
      log('Error saving restaurant: $e');
      _showValidationMessage('Terjadi kesalahan: ${e.toString()}',
          isError: true);
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// Generate complete restaurant data with random values
  Map<String, dynamic> _generateRestaurantData(
      String name, String description) {
    final random = math.Random();
    final now = DateTime.now();

    // Generate unique ID
    final id = 'resto_${now.millisecondsSinceEpoch}_${random.nextInt(1000)}';

    // Random cities in Indonesia
    final cities = [
      'Sumedang',
      'Bandung',
    ];
    final city = cities[random.nextInt(cities.length)];

    // Random street addresses
    final streets = [
      'Jl. Sudirman',
      'Jl. Thamrin',
      'Jl. Gatot Subroto',
      'Jl. Kuningan',
      'Jl. Senopati',
      'Jl. Kemang',
      'Jl. Menteng',
      'Jl. Kebayoran',
      'Jl. Pondok Indah',
      'Jl. Blok M',
      'Jl. Fatmawati',
      'Jl. Cipete'
    ];
    final street = streets[random.nextInt(streets.length)];
    final address = '$street No. ${random.nextInt(500) + 1}, $city';

    // Random rating between 3.5 and 5.0
    final rating = (random.nextDouble() * 1.5 + 3.5);

    // Random picture ID (1-41 based on dicoding restaurant API)
    // Random Unsplash food photo
    // Gunakan ID Unsplash yang valid dan benar-benar foto restoran (bukan makanan close-up saja)
    // Berikut contoh ID foto restoran dari Unsplash (bisa dicek di Unsplash.com, kategori "restaurant" atau "cafe")
    final unsplashIds = [
      '1506744038136-46273834b3fb', // https://unsplash.com/photos/1506744038136-46273834b3fb (restoran interior)
      '1414235077428-338989a2e8c0', // https://unsplash.com/photos/1414235077428-338989a2e8c0 (restoran outdoor)
      '1528605248644-14dd04022da1', // https://unsplash.com/photos/1528605248644-14dd04022da1 (restoran/cafe)
      '1464983953574-0892a716854b', // https://unsplash.com/photos/1464983953574-0892a716854b (restoran/cafe)
      '1504674900247-eca3c3b8b8e6', // https://unsplash.com/photos/1504674900247-eca3c3b8b8e6 (restoran/cafe)
      '1465101178521-c1a9136a3b99', // https://unsplash.com/photos/1465101178521-c1a9136a3b99 (restoran/cafe)
      '1504674900247-6e4b7c1e1c5b', // https://unsplash.com/photos/1504674900247-6e4b7c1e1c5b (restoran/cafe)
      '1504674900247-2d3e1b1a1b1c', // https://unsplash.com/photos/1504674900247-2d3e1b1a1b1c (restoran/cafe)
      '1504674900247-3f4e5d6c7b8a', // https://unsplash.com/photos/1504674900247-3f4e5d6c7b8a (restoran/cafe)
      '1504674900247-9a8b7c6d5e4f', // https://unsplash.com/photos/1504674900247-9a8b7c6d5e4f (restoran/cafe)
    ];
    final unsplashId = unsplashIds[random.nextInt(unsplashIds.length)];
    final pictureUrl = "https://images.unsplash.com/photo-$unsplashId?w=400";

    // Random location coordinates (close to 6.8571° S, 107.9207° E)
    // Latitude: -6.9571 to -6.7571 (~±0.1 deg, ~11km)
    // Longitude: 107.8207 to 108.0207 (~±0.1 deg, ~11km)
    final latitude = -6.8571 + (random.nextDouble() - 0.5) * 0.2;
    final longitude = 107.9207 + (random.nextDouble() - 0.5) * 0.2;
    final location = GeoPoint(latitude, longitude);

    // Random categories

    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureUrl': pictureUrl,
      'city': city,
      'rating': double.parse(rating.toStringAsFixed(1)),
      'address': address,
      'location': location, // GeoPoint for Firebase
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    };
  }

  /// Save data to Firebase Firestore
  Future<void> _saveToFirebase(Map<String, dynamic> restaurantData) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final restaurantId = restaurantData['id'];

      // Create new restaurant (ID is always unique due to timestamp)
      await firestore.collection('resto').doc(restaurantId).set(restaurantData);

      log('Restaurant created: $restaurantId - ${restaurantData['name']}');
    } catch (e) {
      log('Error saving to Firebase: $e');
      throw Exception('Gagal menyimpan data ke Firebase: ${e.toString()}');
    }
  }

  /// Show validation message to user
  void _showValidationMessage(String message, {bool isError = false}) {
    setState(() {
      validationMessage = message;
      isValidationError = isError;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, this);
  }
}
