import 'package:base/beranda/view/beranda_view.dart';
import 'package:base/models/detail_restaurant_model.dart';
import 'package:base/service/api_service_base.dart';
import 'package:flutter/material.dart';

class BerandaController extends State<BerandaView> {
  static late BerandaController instance;
  late BerandaView view;

  ApiServiceBase apiService = ApiServiceBase();

  // State variables for restaurant data
  List<Restaurant> restaurants = [];
  List<Restaurant> filteredRestaurants = [];
  bool isLoading = false;
  String errorMessage = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    instance = this;

    // Load restaurant data when controller initializes
    fetchRestaurants();

    // Add listener to search controller
    searchController.addListener(_onSearchChanged);

    super.initState();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    apiService.resetCancelToken();
    super.dispose();
  }

  // Fetch restaurant list from API
  Future<void> fetchRestaurants() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await apiService.getListResto();
      setState(() {
        restaurants = response.restaurants ?? [];
        filteredRestaurants = restaurants;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });

      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Search restaurants locally only
  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredRestaurants = restaurants;
      });
    } else {
      // Filter locally based on name, description, city, and categories
      final localResults = restaurants.where((restaurant) {
        final name = restaurant.name?.toLowerCase() ?? '';
        final description = restaurant.description?.toLowerCase() ?? '';
        final city = restaurant.city?.toLowerCase() ?? '';
        final address = restaurant.address?.toLowerCase() ?? '';

        // Check categories if available
        final categories = restaurant.categories
                ?.map((cat) => cat.name?.toLowerCase() ?? '')
                .join(' ') ??
            '';

        return name.contains(query) ||
            description.contains(query) ||
            city.contains(query) ||
            address.contains(query) ||
            categories.contains(query);
      }).toList();

      setState(() {
        filteredRestaurants = localResults;
      });
    }
  }

  // Refresh data (for pull-to-refresh)
  Future<void> refreshData() async {
    await fetchRestaurants();
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    setState(() {
      filteredRestaurants = restaurants;
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
