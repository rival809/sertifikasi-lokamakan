class MenuBerandaModel {
  final String text;
  final String icon;
  final Function()? onTap;

  MenuBerandaModel({
    required this.text,
    required this.icon,
    this.onTap,
  });
}
