// Script untuk menambahkan sample data restaurant ke Firebase
// Jalankan ini dari Flutter console atau buat sebagai function terpisah

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataSetup {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addSampleRestaurants() async {
    final List<Map<String, dynamic>> sampleRestaurants = [
      {
        'name': 'Warung Padang Sederhana',
        'location': const GeoPoint(-6.8571, 107.9207), // Sumedang center
        'address': 'Jl. Mayor Abdurahman No. 123, Sumedang',
        'city': 'Sumedang',
        'rating': 4.5,
        'pictureUrl':
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&auto=format&fit=crop',
        'description':
            'Warung Padang dengan cita rasa autentik dan bumbu yang kaya',
        'categories': ['Indonesian', 'Padang'],
        'priceRange': '\$\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Sate Ayam Pak Haji',
        'location': const GeoPoint(-6.8522, 107.9156), // Sumedang Utara
        'address': 'Jl. Prabu Geusan Ulun No. 45, Sumedang',
        'city': 'Sumedang',
        'rating': 4.3,
        'pictureUrl':
            'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop',
        'description': 'Sate ayam bakar dengan bumbu kacang spesial',
        'categories': ['Indonesian', 'Grilled'],
        'priceRange': '\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Bakso Malang Kajoetangan',
        'location': const GeoPoint(-6.8612, 107.9178), // Sumedang Selatan
        'address': 'Jl. Ahmad Yani No. 67, Sumedang',
        'city': 'Sumedang',
        'rating': 4.7,
        'pictureUrl':
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800&auto=format&fit=crop',
        'description': 'Bakso Malang asli dengan topping lengkap',
        'categories': ['Indonesian', 'Soup'],
        'priceRange': '\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Gudeg Yu Djum',
        'location': const GeoPoint(-6.8445, 107.9134), // Situ area
        'address': 'Jl. Otto Iskandardinata No. 89, Sumedang',
        'city': 'Sumedang',
        'rating': 4.6,
        'pictureUrl':
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop',
        'description': 'Gudeg Jogja dengan rasa manis khas',
        'categories': ['Indonesian', 'Javanese'],
        'priceRange': '\$\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Es Teler 77',
        'location': const GeoPoint(-6.9275, 107.7783), // Jatinangor
        'address': 'Jl. Raya Sumedang-Bandung No. 234, Jatinangor',
        'city': 'Sumedang',
        'rating': 4.2,
        'pictureUrl':
            'https://images.unsplash.com/photo-1551782450-a2132b4ba21d?w=800&auto=format&fit=crop',
        'description': 'Es teler dan minuman segar lainnya',
        'categories': ['Drinks', 'Dessert'],
        'priceRange': '\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Rumah Makan Sunda Asli',
        'location': const GeoPoint(-6.8590, 107.9220),
        'address': 'Jl. Raya Sumedang No. 45, Sumedang',
        'city': 'Sumedang',
        'rating': 4.4,
        'pictureUrl':
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&auto=format&fit=crop',
        'description': 'Masakan Sunda dengan lalapan segar',
        'categories': ['Indonesian', 'Sundanese'],
        'priceRange': '\$\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Tahu Sumedang Asli',
        'location': const GeoPoint(-6.8580, 107.9200),
        'address': 'Jl. Pasar Sumedang No. 12, Sumedang',
        'city': 'Sumedang',
        'rating': 4.8,
        'pictureUrl':
            'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=800&auto=format&fit=crop',
        'description': 'Tahu Sumedang goreng dan isi original',
        'categories': ['Indonesian', 'Snack'],
        'priceRange': '\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Mie Ayam Bakso Pak Kumis',
        'location': const GeoPoint(-6.8550, 107.9180),
        'address': 'Jl. Veteran No. 78, Sumedang',
        'city': 'Sumedang',
        'rating': 4.3,
        'pictureUrl':
            'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800&auto=format&fit=crop',
        'description': 'Mie ayam dengan bakso kenyal dan kuah gurih',
        'categories': ['Indonesian', 'Noodles'],
        'priceRange': '\$',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      },
    ];

    try {
      // Add restaurants to Firestore
      final batch = _firestore.batch();

      for (final restaurant in sampleRestaurants) {
        final docRef = _firestore.collection('resto').doc();
        batch.set(docRef, restaurant);
      }

      await batch.commit();
      print(
          '✅ Successfully added ${sampleRestaurants.length} sample restaurants to Firebase!');
    } catch (e) {
      print('❌ Error adding sample restaurants: $e');
    }
  }

  // Method untuk menghapus semua data (gunakan dengan hati-hati!)
  static Future<void> clearAllRestaurants() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('resto').get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      print('✅ All restaurants cleared from Firebase');
    } catch (e) {
      print('❌ Error clearing restaurants: $e');
    }
  }
}

// Cara penggunaan:
// 1. Import file ini ke dalam aplikasi
// 2. Panggil FirebaseDataSetup.addSampleRestaurants() dari controller atau main()
// 3. Data akan ditambahkan ke collection 'resto' di Firestore
