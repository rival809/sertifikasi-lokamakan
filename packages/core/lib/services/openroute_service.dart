import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenRouteService {
  // Get API key from environment variables
  static String get _apiKey {
    final apiKey = dotenv.env['OPENROUTESERVICE_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception(
        'OPENROUTESERVICE_API_KEY not found in environment variables. '
        'Please check your .env file.',
      );
    }
    return apiKey;
  }

  static const String _baseUrl = 'https://api.openrouteservice.org/v2';

  /// Get route directions between two points
  static Future<RouteResponse> getDirections({
    required LatLng start,
    required LatLng end,
    String profile =
        'driving-car', // driving-car, foot-walking, cycling-regular
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/directions/$profile');

      final body = {
        'coordinates': [
          [start.longitude, start.latitude],
          [end.longitude, end.latitude]
        ],
        'radiuses': [1000, 1000], // Search radius in meters
        'format': 'geojson',
        'instructions': true,
        'maneuvers': true,
        'units': 'km'
      };

      final response = await http.post(
        url,
        headers: {
          'Accept':
              'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
          'Authorization': _apiKey,
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RouteResponse.fromJson(data);
      } else {
        throw Exception('Failed to get directions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting directions: $e');
    }
  }

  /// Get route summary (distance and duration only)
  static Future<RouteSummary> getRouteSummary({
    required LatLng start,
    required LatLng end,
    String profile = 'driving-car',
  }) async {
    try {
      final route = await getDirections(
        start: start,
        end: end,
        profile: profile,
      );

      return RouteSummary(
        distance: route.summary.distance,
        duration: route.summary.duration,
        distanceText: _formatDistance(route.summary.distance),
        durationText: _formatDuration(route.summary.duration),
      );
    } catch (e) {
      throw Exception('Error getting route summary: $e');
    }
  }

  static String _formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()} m';
    }
    return '${distanceKm.toStringAsFixed(1)} km';
  }

  static String _formatDuration(double durationSeconds) {
    final hours = (durationSeconds / 3600).floor();
    final minutes = ((durationSeconds % 3600) / 60).floor();

    if (hours > 0) {
      return '$hours jam $minutes menit';
    }
    return '$minutes menit';
  }
}

class RouteResponse {
  final List<LatLng> coordinates;
  final List<RouteInstruction> instructions;
  final RouteSummaryData summary;

  RouteResponse({
    required this.coordinates,
    required this.instructions,
    required this.summary,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    final features = json['features'] as List;
    final geometry = features.first['geometry'];
    final properties = features.first['properties'];

    // Parse coordinates
    final coords = (geometry['coordinates'] as List)
        .map<LatLng>(
            (coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
        .toList();

    // Parse instructions
    final segments = properties['segments'] as List;
    final steps = segments.first['steps'] as List;
    final instructions = steps
        .map<RouteInstruction>((step) => RouteInstruction.fromJson(step))
        .toList();

    // Parse summary
    final summary = RouteSummaryData.fromJson(properties['summary']);

    return RouteResponse(
      coordinates: coords,
      instructions: instructions,
      summary: summary,
    );
  }
}

class RouteInstruction {
  final String instruction;
  final double distance;
  final double duration;
  final int type;
  final String name;

  RouteInstruction({
    required this.instruction,
    required this.distance,
    required this.duration,
    required this.type,
    required this.name,
  });

  factory RouteInstruction.fromJson(Map<String, dynamic> json) {
    return RouteInstruction(
      instruction: json['instruction'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
      duration: (json['duration'] ?? 0).toDouble(),
      type: json['type'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  String get formattedDistance {
    if (distance < 1) {
      return '${(distance * 1000).round()} m';
    }
    return '${distance.toStringAsFixed(1)} km';
  }
}

class RouteSummaryData {
  final double distance;
  final double duration;

  RouteSummaryData({
    required this.distance,
    required this.duration,
  });

  factory RouteSummaryData.fromJson(Map<String, dynamic> json) {
    return RouteSummaryData(
      distance: (json['distance'] ?? 0).toDouble(),
      duration: (json['duration'] ?? 0).toDouble(),
    );
  }
}

class RouteSummary {
  final double distance;
  final double duration;
  final String distanceText;
  final String durationText;

  RouteSummary({
    required this.distance,
    required this.duration,
    required this.distanceText,
    required this.durationText,
  });
}
