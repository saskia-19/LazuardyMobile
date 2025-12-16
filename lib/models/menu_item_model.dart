class MenuItemModel {
  final String iconAsset;
  final String label;
  final Function() onTap;

  MenuItemModel({
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });
}
