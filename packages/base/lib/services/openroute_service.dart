import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

// Models for OpenRoute Service
class RouteResponse {
  final List<LatLng> coordinates;
  final List<RouteInstruction> instructions;
  final RouteSummary summary;

  RouteResponse({
    required this.coordinates,
    required this.instructions,
    required this.summary,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    final route = json['routes'][0];
    final geometry = route['geometry'];

    // Decode polyline coordinates
    final coordinates = _decodePolyline(geometry);

    // Parse instructions
    final instructionsJson = route['segments'][0]['steps'] as List;
    final instructions = instructionsJson
        .map((step) => RouteInstruction.fromJson(step))
        .toList();

    // Parse summary
    final summary = RouteSummary.fromJson(route['summary']);

    return RouteResponse(
      coordinates: coordinates,
      instructions: instructions,
      summary: summary,
    );
  }

  static List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> coordinates = [];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < encoded.length) {
      int shift = 0;
      int result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      coordinates.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return coordinates;
  }
}

class RouteInstruction {
  final String instruction;
  final String name;
  final double distance;
  final double duration;
  final String formattedDistance;
  final String formattedDuration;

  RouteInstruction({
    required this.instruction,
    required this.name,
    required this.distance,
    required this.duration,
    required this.formattedDistance,
    required this.formattedDuration,
  });

  factory RouteInstruction.fromJson(Map<String, dynamic> json) {
    final distance = (json['distance'] as num).toDouble();
    final duration = (json['duration'] as num).toDouble();

    return RouteInstruction(
      instruction: json['instruction'] ?? '',
      name: json['name'] ?? '',
      distance: distance,
      duration: duration,
      formattedDistance: _formatDistance(distance),
      formattedDuration: _formatDuration(duration),
    );
  }

  static String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()} m';
    }
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  static String _formatDuration(double seconds) {
    final minutes = (seconds / 60).round();
    if (minutes < 60) {
      return '$minutes menit';
    }
    final hours = (minutes / 60).floor();
    final remainingMinutes = minutes % 60;
    return '$hours jam $remainingMinutes menit';
  }
}

class RouteSummary {
  final double distance; // in kilometers
  final double duration; // in seconds
  final String distanceText;
  final String durationText;

  RouteSummary({
    required this.distance,
    required this.duration,
    required this.distanceText,
    required this.durationText,
  });

  factory RouteSummary.fromJson(Map<String, dynamic> json) {
    final distance =
        (json['distance'] as num).toDouble() / 1000; // convert to km
    final duration = (json['duration'] as num).toDouble(); // already in seconds

    return RouteSummary(
      distance: distance,
      duration: duration,
      distanceText: _formatDistance(distance),
      durationText: _formatDuration(duration),
    );
  }

  static String _formatDistance(double km) {
    if (km < 1) {
      return '${(km * 1000).round()} m';
    }
    return '${km.toStringAsFixed(1)} km';
  }

  static String _formatDuration(double seconds) {
    final minutes = (seconds / 60).round();
    if (minutes < 60) {
      return '$minutes menit';
    }
    final hours = (minutes / 60).floor();
    final remainingMinutes = minutes % 60;
    return '$hours jam $remainingMinutes menit';
  }
}

class OpenRouteService {
  static const String _baseUrl = 'https://api.openrouteservice.org/v2';

  // Mendapatkan API key dari environment variable
  static String get _apiKey {
    final key = dotenv.env['OPENROUTESERVICE_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('OPENROUTESERVICE_API_KEY tidak ditemukan di file .env');
    }
    return key;
  }

  static Future<RouteResponse> getDirections({
    required LatLng start,
    required LatLng end,
    String profile = 'driving-car',
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/directions/$profile');

      final body = {
        'coordinates': [
          [start.longitude, start.latitude],
          [end.longitude, end.latitude],
        ],
        'format': 'json',
        'instructions': true,
        'geometry': true,
      };

      print('Making request to: $url');
      print('Request body: $body');

      final response = await http.post(
        url,
        headers: {
          'Authorization': _apiKey,
          'Content-Type': 'application/json',
          'Accept':
              'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
        },
        body: json.encode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return RouteResponse.fromJson(data);
      } else {
        print('API Error ${response.statusCode}: ${response.body}');
        throw Exception(
            'Failed to get directions: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      rethrow;
    }
  }
}
