class Images {
  static String basePath = 'assets/images';

  final logo = _Logo();
}

class _Logo {
  String get logo => '${Images.basePath}/logo/logo.png';
  String get logoWhite => '${Images.basePath}/logo/logo_white.png';
}
