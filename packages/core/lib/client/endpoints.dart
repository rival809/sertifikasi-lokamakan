class Endpoints {
  Endpoints._();

  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);

  //Auth https://restaurant-api.dicoding.dev
  static const String listResto = "/list";
  static const String detailResto = "/detail";
  static const String searchResto = "/search";
}
